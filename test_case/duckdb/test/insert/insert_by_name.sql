PRAGMA enable_verification;
CREATE TABLE integers(i INTEGER, j INTEGER);;
INSERT INTO integers BY NAME SELECT 42 AS j;
INSERT INTO integers BY NAME SELECT 84 AS i;
INSERT INTO integers BY NAME SELECT 99 AS j, 9 AS i;
INSERT INTO integers BY POSITION SELECT 1 AS j, 10 AS i;
CREATE TABLE "My Table"("My Column 1" INT, "My Column 2" INT);;
INSERT INTO "My Table" BY NAME SELECT 1 AS "My Column 2";
INSERT INTO integers BY NAME SELECT 1 AS xxx;
INSERT INTO integers BY NAME SELECT 1 AS i, 2 AS i;
INSERT INTO integers (i, i) SELECT 1, 2;
INSERT INTO integers BY NAME SELECT 1 AS rowid;
CREATE TABLE tbl (
	price INTEGER,
	total_price AS ((price)::DATE)
);;
INSERT INTO tbl BY NAME SELECT 1 AS total_price;
INSERT INTO integers BY NAME VALUES (42, 84);;
INSERT INTO integers BY NAME (i) SELECT 1 AS j;
INSERT INTO integers BY POSITION VALUES (42, 84);;
FROM integers;
FROM "My Table";
