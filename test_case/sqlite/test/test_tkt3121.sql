PRAGMA encoding = 'utf16';
CREATE TABLE r1(field);
CREATE TABLE r2(col PRIMARY KEY, descr);
INSERT INTO r1 VALUES('abcd');
INSERT INTO r2 VALUES('abcd', 'A nice description');
INSERT INTO r2 VALUES('efgh', 'Another description');
