-- liquibase formatted sql

-- changeset liquibase:1
CREATE TABLE SCHEMA_A.DEPARTMENTS (
    DEPARTMENT_ID     NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY,
    DEPARTMENT_NAME   VARCHAR2(80) NOT NULL,
) LOGGING;


--rollback DROP TABLE SCHEMA_A.DEPARTMENTS;