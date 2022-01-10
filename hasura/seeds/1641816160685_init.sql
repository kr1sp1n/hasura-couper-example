SET check_function_bodies = false;
INSERT INTO public.roles (id, name) VALUES ('cc79fac2-5a3a-4bd5-a4f9-8ca2d3e5a0be', 'admin');
INSERT INTO public.roles (id, name) VALUES ('265e69d8-b12c-4f9c-98ed-b0bd9c1e226b', 'user');
INSERT INTO public.users (id, email, password_hash, last_login_at, password_changed) VALUES ('a073d05f-3861-463c-8c11-83ab109f863f', 'user@example.com', 'test123', NULL, true);
INSERT INTO public.users_roles (id, user_id, role_id) VALUES ('43aa1f1e-4379-4ec4-9007-76b9d5b336a0', 'a073d05f-3861-463c-8c11-83ab109f863f', 'cc79fac2-5a3a-4bd5-a4f9-8ca2d3e5a0be');
INSERT INTO public.users_roles (id, user_id, role_id) VALUES ('02a814ce-1dae-489f-b8c0-17dc04ca4c41', 'a073d05f-3861-463c-8c11-83ab109f863f', '265e69d8-b12c-4f9c-98ed-b0bd9c1e226b');
