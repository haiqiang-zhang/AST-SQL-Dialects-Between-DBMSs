CREATE TABLE x(a);
INSERT INTO x VALUES('assert');
CREATE TABLE w(a);
CREATE TABLE y(a);
CREATE TABLE z(a);
INSERT INTO x(a) VALUES(5);
INSERT INTO y(a) VALUES(10);
INSERT INTO w VALUES('incorrect');
SELECT * FROM z;
INSERT INTO y(a) VALUES(10);
INSERT INTO w VALUES('assert');
SELECT * FROM z;