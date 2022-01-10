SET check_function_bodies = false;
CREATE TABLE public.users (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    email text NOT NULL,
    password_hash text,
    last_login_at timestamp with time zone,
    password_changed boolean DEFAULT false
);
CREATE FUNCTION public.check_password(email text, password text) RETURNS SETOF public.users
    LANGUAGE sql STABLE
    AS $$
    SELECT *
  FROM users
 WHERE email = email
   AND password_hash = crypt(password, password_hash);
$$;
CREATE FUNCTION public.crypt_password() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	NEW.password_hash := crypt(NEW.password_hash, gen_salt('bf', 8));
    RETURN NEW;
END;
$$;
CREATE FUNCTION public.crypt_password_on_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
 IF
    NEW.password_changed IS TRUE 
 THEN
    NEW.password_hash := crypt(NEW.password_hash, gen_salt('bf', 8));
 END IF;
 RETURN NEW;
END
$$;
CREATE TABLE public.roles (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL
);
CREATE TABLE public.users_roles (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    role_id uuid
);
ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);
ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.users_roles
    ADD CONSTRAINT users_roles_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.users_roles
    ADD CONSTRAINT users_roles_user_id_role_id_key UNIQUE (user_id, role_id);
CREATE TRIGGER encrypt_password_on_insert BEFORE INSERT ON public.users FOR EACH ROW EXECUTE FUNCTION public.crypt_password();
CREATE TRIGGER encrypt_password_on_update BEFORE UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION public.crypt_password_on_update();
ALTER TABLE ONLY public.users_roles
    ADD CONSTRAINT users_roles_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.users_roles
    ADD CONSTRAINT users_roles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
