-- liquibase formatted sql

-- changeset createSchemas runAlways:true endDelimiter:/
DECLARE
  L_CONN_USER   VARCHAR2(255);
  L_USER	    VARCHAR2(255);
  L_TBLSPACE    VARCHAR2(255);
  
  TYPE Listing is TABLE OF VARCHAR2(25);
  SchemaListing Listing := Listing('schema_a', 'schema_b');
  

BEGIN

    SELECT USER INTO L_CONN_USER FROM DUAL;
    
    for i in SchemaListing.FIRST .. SchemaListing.LAST loop
        
        -- create the schema
        execute immediate 'CREATE USER "' || SchemaListing(i) || '" NO AUTHENTICATION';

        -- grants
        execute immediate 'ALTER USER "' || SchemaListing(i) || '" GRANT CONNECT THROUGH '|| L_CONN_USER;
        SELECT DEFAULT_TABLESPACE INTO L_TBLSPACE FROM DBA_USERS WHERE USERNAME=SchemaListing(i);
        execute immediate 'ALTER USER "' || SchemaListing(i) || '" QUOTA UNLIMITED ON '|| L_TBLSPACE;
        execute immediate 'GRANT CONNECT TO "' || SchemaListing(i) || '"';
        execute immediate 'GRANT RESOURCE TO "' || SchemaListing(i) || '"';
        execute immediate 'ALTER USER "' || SchemaListing(i) || '" DEFAULT ROLE CONNECT,RESOURCE';
    end loop;
    
END;
/

--rollback drop user "schema_a" cascade;
--rollback drop user "schema_b" cascade;