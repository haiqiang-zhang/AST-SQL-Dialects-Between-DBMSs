PRAGMA enable_verification;
CREATE TABLE integers(i INTEGER);
INSERT INTO integers VALUES (1), (2);
CREATE TABLE integers2(i INTEGER);
INSERT INTO integers2 VALUES (2), (3);
CREATE VIEW v1 AS SELECT * FROM integers UNION ALL SELECT * FROM integers;
CREATE VIEW v2 AS SELECT * FROM integers2 UNION ALL SELECT * FROM integers2;
CREATE VIEW v3 AS SELECT (SELECT integers2.i-1) i FROM integers2 UNION ALL SELECT (SELECT integers2.i-1) i FROM integers2;
CREATE VIEW v4 AS SELECT (SELECT integers.i+1) i FROM integers UNION ALL SELECT (SELECT integers.i+1) i FROM integers;
