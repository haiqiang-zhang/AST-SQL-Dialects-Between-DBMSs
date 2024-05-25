PRAGMA enable_verification;
CREATE TABLE pk_integers(i INTEGER PRIMARY KEY);
CREATE TABLE fk_integers(j INTEGER, FOREIGN KEY (j) REFERENCES pk_integers(i));
INSERT INTO pk_integers VALUES (1), (2), (3);
INSERT INTO fk_integers VALUES (1), (2);
ATTACH ':memory:' AS db1;
USE db1;
