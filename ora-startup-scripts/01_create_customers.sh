#!/bin/sh

echo 'Creating debezium.customers table'

sqlplus debezium/dbz@//localhost:1521/ORCLPDB1  <<- EOF

  CREATE TABLE customers (
    id NUMBER(9) GENERATED BY DEFAULT ON NULL AS IDENTITY (START WITH 1) NOT NULL PRIMARY KEY,
    first_name VARCHAR2(255) NOT NULL,
    last_name VARCHAR2(255) NOT NULL,
    email VARCHAR2(255) NOT NULL UNIQUE
  );
  /
  
EOF

sqlplus sys/top_secret@//localhost:1521/ORCLPDB1 as sysdba <<- EOF

  ALTER TABLE debezium.customers ADD SUPPLEMENTAL LOG DATA (ALL) COLUMNS;
  GRANT SELECT ON debezium.customers to c##dbzuser;

  exit;
EOF
