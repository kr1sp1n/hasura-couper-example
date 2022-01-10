server {
  api {
    base_path = "/api"
    endpoint "/login" {
      request {
        backend "hasura" {}
        method = "post"
        json_body = {
          variables = {
            email = request.json_body.input.email
            password = request.json_body.input.password
          }
          query = <<EOT
            query check_password($email: String!, $password: String!) {
              check_password(args: {email: $email, password: $password}) {
                id
                email
                roles {
                  role {
                    name
                  }
                }
              }
            }
          EOT
        }
      }
      response {
        status = backend_responses.default.status
        json_body = {
          id = backend_responses.default.json_body.data.check_password[0].id
          email = backend_responses.default.json_body.data.check_password[0].email
          roles = backend_responses.default.json_body.data.check_password[0].roles.*.role.name
          access_token = jwt_sign("hasura_jwt", {
            sub = backend_responses.default.json_body.data.check_password[0].email
            "https://hasura.io/jwt/claims" = {
              x-hasura-allowed-roles = backend_responses.default.json_body.data.check_password[0].roles.*.role.name
              x-hasura-default-role = "guest"
            }
          })
        }
      }
    }
  }
}

definitions {
  backend "hasura" {
    origin = env.HASURA_ORIGIN
    path = "/v1/graphql"
    set_request_headers = {
      content-type = "application/json"
      x-hasura-admin-secret = env.HASURA_ADMINSECRET
    }
  }
  backend "httpbin" {
    origin = "https://httpbin.org"
    path = "/anything"
  }
  jwt_signing_profile "hasura_jwt" {
    signature_algorithm = "RS256"
    key_file = "priv_key.pem"
    ttl = "600s"
    claims = {
      iss = "test"
      iat = unixtime()
    }
  }
}

settings {
  log_format = "json"
  log_level = "debug"
}