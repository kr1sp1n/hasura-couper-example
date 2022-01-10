# hasura-couper-example

Example setup to let [hasura][1] work with [couper][2].

Start couper, hasura and postgres:
```bash
docker-compose up
```

In another terminal window in the same dir:
```bash
npm run init
```
this will use hasura CLI to apply migrations, seeds and metadata.

Open in browser:

http://localhost:8080/console/api/api-explorer

Query:
```
query login($email: String!, $password: String!) {
  login(email: $email, password: $password) {
    access_token
  }
}
```

Variables:
```
{
  "email": "user@example.com",
  "password": "test123"
}
```

---

[1]: https://hasura.io/docs
[2]: https://couper.io/en/docs/