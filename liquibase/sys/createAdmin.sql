-- liquibase formatted sql

-- changeset createAdminUser runAlways:true endDelimiter:/
CREATE USER admin identified by ${adminPassword};
        
-- create the schema
GRANT CONNECT, RESOURCE to admin;
GRANT UNLIMITED TABLESPACE to admin;
    
END;
/

--rollback drop user "admin" cascade;