-- liquibase formatted sql

-- changeset liquibase:1
CREATE TABLE SCHEMA_B.TASKS (
    TASK_ID             NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY,
    TASK_NAME           VARCHAR2(300) NOT NULL,
    TASK_DESCRIPTION    VARCHAR2(4000)
) LOGGING;


--rollback DROP TABLE SCHEMA_B.TASKS;