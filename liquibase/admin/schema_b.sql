-- liquibase formatted sql

-- changeset liquibase:2
CREATE USER "SCHEMA_B" NO AUTHENTICATION;
ALTER USER "SCHEMA_B" GRANT CONNECT THROUGH SYSTEM;
GRANT UNLIMITED TABLESPACE TO "SCHEMA_B";
GRANT CONNECT, RESOURCE TO "SCHEMA_B";
ALTER USER "SCHEMA_B" DEFAULT ROLE CONNECT, RESOURCE;