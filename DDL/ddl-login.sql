-- Table: login.tb_user

-- DROP TABLE IF EXISTS login.tb_user;

CREATE TABLE IF NOT EXISTS login.tb_user
(
    id integer NOT NULL,
    user_id uuid NOT NULL,
    name character(255) COLLATE pg_catalog."default" NOT NULL,
    login character(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "PK_USER_ID" PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS login.tb_user
    OWNER to financial;

-- Table: login.tb_login

-- DROP TABLE IF EXISTS login.tb_login;

CREATE TABLE IF NOT EXISTS login.tb_login
(
    id integer NOT NULL,
    user_id integer NOT NULL,
    uuid uuid NOT NULL,
    data_create timestamp without time zone,
    CONSTRAINT "PK_LOGIN_ID" PRIMARY KEY (id),
    CONSTRAINT "FK_LOGIN_USER" FOREIGN KEY (user_id)
        REFERENCES login.tb_user (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS login.tb_login
    OWNER to financial;
-- Index: IDX_LOGIN

-- DROP INDEX IF EXISTS login."IDX_LOGIN";

CREATE INDEX IF NOT EXISTS "IDX_LOGIN"
    ON login.tb_login USING btree
    (user_id ASC NULLS LAST, data_create ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: login.tb_page

-- DROP TABLE IF EXISTS login.tb_page;

CREATE TABLE IF NOT EXISTS login.tb_page
(
    id uuid NOT NULL,
    name character(255) COLLATE pg_catalog."default" NOT NULL,
    data_create timestamp without time zone,
    CONSTRAINT "PK_PAGINA_ID" PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS login.tb_pagina
    OWNER to financial;

-- Table: login.tb_perfil

-- DROP TABLE IF EXISTS login.tb_perfil;

CREATE TABLE IF NOT EXISTS login.tb_perfil
(
    id uuid NOT NULL,
    name character(255) COLLATE pg_catalog."default" NOT NULL,
    data_create timestamp without time zone,
    CONSTRAINT "PK_PERFIL_ID" PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS login.tb_perfil
    OWNER to financial;

-- Table: login.tb_type

-- DROP TABLE IF EXISTS login.tb_type;

CREATE TABLE IF NOT EXISTS login.tb_type
(
    id uuid NOT NULL,
    name character(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "PK_TYPE_ID" PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS login.tb_type
    OWNER to financial;

-- Table: login.tb_feature

-- DROP TABLE IF EXISTS login.tb_feature;

CREATE TABLE IF NOT EXISTS login.tb_feature
(
    id uuid NOT NULL,
    page_id uuid NOT NULL,
    name character(255) COLLATE pg_catalog."default" NOT NULL,
    type_id uuid NOT NULL,
    data_create timestamp without time zone,
    CONSTRAINT "PK_FEATURE_ID" PRIMARY KEY (id),
    CONSTRAINT "FK_FEATURE_PAGE" FOREIGN KEY (page_id)
        REFERENCES login.tb_page (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_FEATURE_TYPE" FOREIGN KEY (type_id)
        REFERENCES login.tb_type (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS login.tb_feature
    OWNER to financial;
-- Index: IDX_FEATURE

-- DROP INDEX IF EXISTS login."IDX_FEATURE";

CREATE INDEX IF NOT EXISTS "IDX_FEATURE"
    ON login.tb_feature USING btree
    (id ASC NULLS LAST, page_id ASC NULLS LAST, type_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: fki_FK_FEATURE_PAGINA

-- DROP INDEX IF EXISTS login."fki_FK_FEATURE_PAGINA";

CREATE INDEX IF NOT EXISTS "fki_FK_FEATURE_PAGINA"
    ON login.tb_feature USING btree
    (page_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: fki_FK_FEATURE_TYPE

-- DROP INDEX IF EXISTS login."fki_FK_FEATURE_TYPE";

CREATE INDEX IF NOT EXISTS "fki_FK_FEATURE_TYPE"
    ON login.tb_feature USING btree
    (type_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: login.feature_to_perfil

-- DROP TABLE IF EXISTS login.feature_to_perfil;

CREATE TABLE IF NOT EXISTS login.feature_to_perfil
(
    feature_id uuid NOT NULL,
    perfil_id uuid NOT NULL,
    CONSTRAINT "PK_FEATURE_TO_PERFIL" PRIMARY KEY (feature_id, perfil_id),
    CONSTRAINT "FK_FEATURE_TO_PERFIL_FEATURE" FOREIGN KEY (feature_id)
        REFERENCES login.tb_feature (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_FEATURE_TO_PERFIL_PERFIL" FOREIGN KEY (perfil_id)
        REFERENCES login.tb_perfil (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS login.feature_to_perfil
    OWNER to financial;
-- Index: IDX_FEATURE_TO_PERFIL

-- DROP INDEX IF EXISTS login."IDX_FEATURE_TO_PERFIL";

CREATE INDEX IF NOT EXISTS "IDX_FEATURE_TO_PERFIL"
    ON login.feature_to_perfil USING btree
    (perfil_id ASC NULLS LAST, feature_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: fki_FK_FEATURE_TO_PERFIL_FEATURE

-- DROP INDEX IF EXISTS login."fki_FK_FEATURE_TO_PERFIL_FEATURE";

CREATE INDEX IF NOT EXISTS "fki_FK_FEATURE_TO_PERFIL_FEATURE"
    ON login.feature_to_perfil USING btree
    (feature_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Table: login.feature_to_user

-- DROP TABLE IF EXISTS login.feature_to_user;

CREATE TABLE IF NOT EXISTS login.feature_to_user
(
    user_id integer NOT NULL,
    feature_id uuid NOT NULL,
    CONSTRAINT "PK_FEATURE_TO_USER" PRIMARY KEY (user_id, feature_id),
    CONSTRAINT "FK_FEATURE_TO_USER_FEATURE" FOREIGN KEY (feature_id)
        REFERENCES login.tb_feature (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_FEATURE_TO_USER_USER" FOREIGN KEY (user_id)
        REFERENCES login.tb_user (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS login.feature_to_user
    OWNER to financial;
-- Index: IDX_FEATURE_TO_USER

-- DROP INDEX IF EXISTS login."IDX_FEATURE_TO_USER";

CREATE INDEX IF NOT EXISTS "IDX_FEATURE_TO_USER"
    ON login.feature_to_user USING btree
    (user_id ASC NULLS LAST, feature_id ASC NULLS LAST)
    TABLESPACE pg_default;