CREATE TABLE ta (pk integer primary key);
CREATE TABLE tb (pk integer primary key);
DROP TABLE ta, tb;
CREATE TABLE ta (pk integer primary key);
CREATE TABLE tb (pk integer primary key);
DROP TABLE ta, tb;
CREATE TABLE tb (pk integer primary key);
DROP TABLE tb;
CREATE TABLE tb (pk integer primary key);
SELECT COUNT(*) = 1 FROM information_schema.processlist
    WHERE state LIKE 'Waiting for table flush' AND info LIKE 'FLUSH TABLES';
DROP TABLE tb;
CREATE TABLE tb (pk integer primary key);
SELECT COUNT(*) = 1 FROM information_schema.processlist
    WHERE state LIKE 'Waiting for table flush' AND info LIKE 'FLUSH TABLES tb';
DROP TABLE tb;
CREATE TABLE tb (pk integer primary key);
SELECT COUNT(*) = 1 FROM information_schema.processlist
    WHERE state LIKE 'Waiting for table flush' AND info LIKE 'FLUSH TABLES';
SELECT COUNT(*) = 0 FROM information_schema.processlist
    WHERE state LIKE 'Waiting for table flush' AND info LIKE 'FLUSH TABLES';
DROP TABLE tb;
SELECT COUNT(*) = 1 FROM information_schema.processlist
    WHERE state LIKE 'Waiting for table metadata lock'
      AND info LIKE 'CREATE TABLE tb%';
CREATE TABLE ta (pk integer primary key);
CREATE TABLE tb (pk integer primary key);
INSERT INTO ta VALUES(0);
DROP TABLE ta, tb;
