
SET default_toast_compression = 'pglz';

CREATE TABLE cmdata(f1 text COMPRESSION pglz);
CREATE INDEX idx ON cmdata(f1);
INSERT INTO cmdata VALUES(repeat('1234567890', 1000));
CREATE TABLE cmdata1(f1 TEXT COMPRESSION lz4);
INSERT INTO cmdata1 VALUES(repeat('1234567890', 1004));

SELECT pg_column_compression(f1) FROM cmdata;
SELECT pg_column_compression(f1) FROM cmdata1;

SELECT SUBSTR(f1, 200, 5) FROM cmdata;
SELECT SUBSTR(f1, 2000, 50) FROM cmdata1;

SELECT * INTO cmmove1 FROM cmdata;
SELECT pg_column_compression(f1) FROM cmmove1;

CREATE TABLE cmmove3(f1 text COMPRESSION pglz);
INSERT INTO cmmove3 SELECT * FROM cmdata;
INSERT INTO cmmove3 SELECT * FROM cmdata1;
SELECT pg_column_compression(f1) FROM cmmove3;

CREATE TABLE cmdata2 (LIKE cmdata1 INCLUDING COMPRESSION);
DROP TABLE cmdata2;

CREATE TABLE cmdata2 (f1 int COMPRESSION pglz);

CREATE TABLE cmmove2(f1 text COMPRESSION pglz);
INSERT INTO cmmove2 VALUES (repeat('1234567890', 1004));
SELECT pg_column_compression(f1) FROM cmmove2;
UPDATE cmmove2 SET f1 = cmdata1.f1 FROM cmdata1;
SELECT pg_column_compression(f1) FROM cmmove2;

CREATE OR REPLACE FUNCTION large_val() RETURNS TEXT LANGUAGE SQL AS
'select array_agg(fipshash(g::text))::text from generate_series(1, 256) g';
CREATE TABLE cmdata2 (f1 text COMPRESSION pglz);
INSERT INTO cmdata2 SELECT large_val() || repeat('a', 4000);
SELECT pg_column_compression(f1) FROM cmdata2;
INSERT INTO cmdata1 SELECT large_val() || repeat('a', 4000);
SELECT pg_column_compression(f1) FROM cmdata1;
SELECT SUBSTR(f1, 200, 5) FROM cmdata1;
SELECT SUBSTR(f1, 200, 5) FROM cmdata2;
DROP TABLE cmdata2;

CREATE TABLE cmdata2 (f1 int);
ALTER TABLE cmdata2 ALTER COLUMN f1 TYPE varchar;
ALTER TABLE cmdata2 ALTER COLUMN f1 TYPE int USING f1::integer;

ALTER TABLE cmdata2 ALTER COLUMN f1 TYPE varchar;
ALTER TABLE cmdata2 ALTER COLUMN f1 SET COMPRESSION pglz;
ALTER TABLE cmdata2 ALTER COLUMN f1 SET STORAGE plain;
INSERT INTO cmdata2 VALUES (repeat('123456789', 800));
SELECT pg_column_compression(f1) FROM cmdata2;

CREATE MATERIALIZED VIEW compressmv(x) AS SELECT * FROM cmdata1;
SELECT pg_column_compression(f1) FROM cmdata1;
SELECT pg_column_compression(x) FROM compressmv;

CREATE TABLE cmpart(f1 text COMPRESSION lz4) PARTITION BY HASH(f1);
CREATE TABLE cmpart1 PARTITION OF cmpart FOR VALUES WITH (MODULUS 2, REMAINDER 0);
CREATE TABLE cmpart2(f1 text COMPRESSION pglz);

ALTER TABLE cmpart ATTACH PARTITION cmpart2 FOR VALUES WITH (MODULUS 2, REMAINDER 1);
INSERT INTO cmpart VALUES (repeat('123456789', 1004));
INSERT INTO cmpart VALUES (repeat('123456789', 4004));
SELECT pg_column_compression(f1) FROM cmpart1;
SELECT pg_column_compression(f1) FROM cmpart2;

CREATE TABLE cminh() INHERITS(cmdata, cmdata1);
CREATE TABLE cminh(f1 TEXT COMPRESSION lz4) INHERITS(cmdata);

SET default_toast_compression = '';
SET default_toast_compression = 'I do not exist compression';
SET default_toast_compression = 'lz4';
SET default_toast_compression = 'pglz';

ALTER TABLE cmdata ALTER COLUMN f1 SET COMPRESSION lz4;
INSERT INTO cmdata VALUES (repeat('123456789', 4004));
SELECT pg_column_compression(f1) FROM cmdata;

ALTER TABLE cmdata2 ALTER COLUMN f1 SET COMPRESSION default;

ALTER MATERIALIZED VIEW compressmv ALTER COLUMN x SET COMPRESSION lz4;

ALTER TABLE cmpart1 ALTER COLUMN f1 SET COMPRESSION pglz;
ALTER TABLE cmpart2 ALTER COLUMN f1 SET COMPRESSION lz4;

INSERT INTO cmpart VALUES (repeat('123456789', 1004));
INSERT INTO cmpart VALUES (repeat('123456789', 4004));
SELECT pg_column_compression(f1) FROM cmpart1;
SELECT pg_column_compression(f1) FROM cmpart2;

SELECT pg_column_compression(f1) FROM cmdata;
VACUUM FULL cmdata;
SELECT pg_column_compression(f1) FROM cmdata;

DROP TABLE cmdata2;
CREATE TABLE cmdata2 (f1 TEXT COMPRESSION pglz, f2 TEXT COMPRESSION lz4);
CREATE UNIQUE INDEX idx1 ON cmdata2 ((f1 || f2));
INSERT INTO cmdata2 VALUES((SELECT array_agg(fipshash(g::TEXT))::TEXT FROM
generate_series(1, 50) g), VERSION());

SELECT length(f1) FROM cmdata;
SELECT length(f1) FROM cmdata1;
SELECT length(f1) FROM cmmove1;
SELECT length(f1) FROM cmmove2;
SELECT length(f1) FROM cmmove3;

CREATE TABLE badcompresstbl (a text COMPRESSION I_Do_Not_Exist_Compression); 
CREATE TABLE badcompresstbl (a text);
ALTER TABLE badcompresstbl ALTER a SET COMPRESSION I_Do_Not_Exist_Compression; 
DROP TABLE badcompresstbl;

