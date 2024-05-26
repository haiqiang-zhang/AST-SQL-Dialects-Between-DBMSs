CREATE TABLE abc(a, b, c);
DROP TABLE abc;
CREATE VIEW v1 AS SELECT * FROM sqlite_master;
DROP VIEW v1;
CREATE TABLE abc(a, b, c);
CREATE INDEX abc_index ON abc(a);
DROP INDEX abc_index;
