pragma enable_verification;
create schema my_schema;
SET schema='my_schema';
drop schema my_schema;
create schema schema1;
create schema schema2;
set schema='schema1';
drop schema schema2;
