CREATE TABLE treal(a VARCHAR(16), b INTEGER, c FLOAT);
INSERT INTO treal VALUES('a', 'b', 'c');
DROP TABLE treal;
CREATE TABLE strings(str COLLATE NOCASE);
INSERT INTO strings VALUES('abc1');
INSERT INTO strings VALUES('Abc3');
INSERT INTO strings VALUES('ABc2');
INSERT INTO strings VALUES('aBc4');
SELECT str FROM strings ORDER BY 1;
