SET check_function_bodies = false;
INSERT INTO public.roles (id, name) VALUES ('cc79fac2-5a3a-4bd5-a4f9-8ca2d3e5a0be', 'admin') ON CONFLICT DO NOTHING;
INSERT INTO public.roles (id, name) VALUES ('265e69d8-b12c-4f9c-98ed-b0bd9c1e226b', 'user') ON CONFLICT DO NOTHING;
-- INSERT INTO public.roles (name) VALUES ('superuser') ON CONFLICT DO NOTHING;
INSERT INTO public.users (id, email, password_hash, last_login_at) VALUES ('a073d05f-3861-463c-8c11-83ab109f863f', 'krispin.schulz@avenga.com', '$2a$08$4rD6riYxywJWtVr.RzbpeuomnpM9eotN5lZqrLwm/W21j4MKfwN6e', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.users_roles (id, user_id, role_id) VALUES ('43aa1f1e-4379-4ec4-9007-76b9d5b336a0', 'a073d05f-3861-463c-8c11-83ab109f863f', 'cc79fac2-5a3a-4bd5-a4f9-8ca2d3e5a0be') ON CONFLICT DO NOTHING;
INSERT INTO public.users_roles (id, user_id, role_id) VALUES ('02a814ce-1dae-489f-b8c0-17dc04ca4c41', 'a073d05f-3861-463c-8c11-83ab109f863f', '265e69d8-b12c-4f9c-98ed-b0bd9c1e226b') ON CONFLICT DO NOTHING;
