RESET ROLE;
CREATE SCHEMA regress_schema_1 AUTHORIZATION CURRENT_ROLE
  CREATE TABLE regress_schema_1.tab (id int);
DROP SCHEMA regress_schema_1 CASCADE;
RESET ROLE;
