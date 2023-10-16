-- liquibase formatted sql

-- changeset gotsysdba:1 runAlways:true endDelimiter:/
DECLARE
  L_CONN_USER   VARCHAR2(255);
  L_USER	    VARCHAR2(255);
  L_TBLSPACE    VARCHAR2(255);
  type v_array is varray(2) of varchar2(10);
  array schmeas_array := v_array('schema_a', 'schema_b');
BEGIN
    SELECT USER INTO L_CONN_USER FROM DUAL;
    
    for i in 1..schemas_array.count loop
        
        -- create the user
        execute immediate 'CREATE USER "' || array(i) || '" NO AUTHENTICATION';

        -- grants
        execute immediate 'ALTER USER "' || array(i) || '" GRANT CONNECT THROUGH '|| L_CONN_USER;
        SELECT DEFAULT_TABLESPACE INTO L_TBLSPACE FROM DBA_USERS WHERE USERNAME=array(i);
        execute immediate 'ALTER USER "' || array(i) || '" QUOTA UNLIMITED ON '|| L_TBLSPACE;
        execute immediate 'GRANT CONNECT TO "' || array(i) || '"';
        execute immediate 'GRANT RESOURCE TO "' || array(i) || '"';
        execute immediate 'ALTER USER "' || array(i) || '" DEFAULT ROLE CONNECT,RESOURCE';
    end loop;
    
END;
/

--rollback drop user "schema_a" cascade;