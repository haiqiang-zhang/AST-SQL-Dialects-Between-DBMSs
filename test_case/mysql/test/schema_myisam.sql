DROP SCHEMA s;
CREATE SCHEMA s;
CREATE TABLE s.t_myisam (pk INTEGER PRIMARY KEY);
ALTER TABLE s.t_myisam ADD COLUMN c INTEGER;
DROP SCHEMA s;
CREATE SCHEMA s;
CREATE TABLE s.t_myisam (pk INTEGER PRIMARY KEY);
DROP SCHEMA s;
CREATE SCHEMA s;
CREATE TABLE s.t_myisam (pk INTEGER PRIMARY KEY);
DROP TABLE s.t_myisam;
DROP SCHEMA s;
