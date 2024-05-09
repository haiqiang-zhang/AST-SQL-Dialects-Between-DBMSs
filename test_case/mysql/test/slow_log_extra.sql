SELECT unix_timestamp(), sleep(2);
DROP TABLE IF EXISTS islow;
CREATE TABLE islow(i INT) ENGINE=innodb;
INSERT INTO islow VALUES (1), (2), (3), (4), (5), (6), (7), (8);
SELECT * FROM islow;
SELECT * FROM islow;
DROP TABLE islow;
