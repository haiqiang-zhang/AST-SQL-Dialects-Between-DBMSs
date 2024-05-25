DROP TABLE IF EXISTS islow;
DROP TABLE IF EXISTS mslow;
CREATE TABLE islow(i INT) ENGINE=innodb;
INSERT INTO islow VALUES (1), (2), (3), (4), (5), (6), (7), (8);
CREATE TABLE mslow(i INT) ENGINE=myisam;
INSERT INTO mslow VALUES (1), (2), (3), (4), (5), (6), (7), (8);
