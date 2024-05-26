CREATE DATABASE regress_nosuch_db;
CREATE TABLE tenant_table (i integer);
CREATE INDEX tenant_idx ON tenant_table(i);
CREATE VIEW tenant_view AS SELECT * FROM pg_catalog.pg_class;
