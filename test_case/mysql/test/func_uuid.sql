SELECT HEX(uuid_to_bin('{c8eb4b15-cb09-48bb-bbb2-e6a0b6b4d5c7}', TRUE)) AS a,
       HEX(uuid_to_bin('{e60c88ba-083f-4ceb-be59-f67636d718a2}', TRUE)) AS b;
SELECT HEX(uuid_to_bin('c8eb4b15cb0948bbbbb2e6a0b6b4d5c7', TRUE)) AS a,
       HEX(uuid_to_bin('e60c88ba083f4cebbe59f67636d718a2', TRUE)) AS b;
SELECT HEX(uuid_to_bin('c8eb4b15-cb09-48bb-bbb2-e6a0b6b4d5c7', TRUE)) AS a,
       HEX(uuid_to_bin('e60c88ba-083f-4ceb-be59-f67636d718a2', TRUE)) AS b;
SELECT bin_to_uuid(unhex('7f9d04ae61b34468ac798ffcc984ab68')) AS a, bin_to_uuid(unhex('7f9d04ae61b34468ac898ffcc984ab68'),TRUE) AS b;
SELECT uuid_to_bin('{c8eb4b15-CB09-48bb-bbb2-e6a0b6b4d5c7}') = x'c8eb4b15cb0948bbbbb2e6a0b6b4d5c7';
SELECT uuid_to_bin('{c8eb4b15-CB09-48bb-bbb2-e6a0b6b4d5c7}', TRUE) = x'48bbcb09c8eb4b15bbb2e6a0b6b4d5c7';
SELECT bin_to_uuid(x'7f9d04ae61b34468ac798ffcc984ab68') = '7f9d04ae-61b3-4468-ac79-8ffcc984ab68';
SELECT bin_to_uuid(x'7f9d04ae61b34468ac798ffcc984ab68', TRUE) = '61b34468-04ae-7f9d-ac79-8ffcc984ab68';
SELECT bin_to_uuid(NULL) AS a, bin_to_uuid(NULL, TRUE) AS b;
SELECT uuid_to_bin(NULL) AS a, uuid_to_bin(NULL, TRUE) AS b;
SELECT is_uuid(NULL);
CREATE TABLE t(a binary(16));
INSERT into t VALUES(unhex('7f9d04ae61b34468ac798ffcc984ab68')),(unhex('d00653b290b940d193c2194456bd4f3d')),(unhex('e60c88ba083f4cebbe59f67636d718a2')),(unhex('c8eb4b15cb0948bbbbb2e6a0b6b4d5c7'));
SELECT bin_to_uuid(a), bin_to_uuid(a,TRUE) FROM t;
SELECT HEX(uuid_to_bin(bin_to_uuid(a))) AS c1,
       uuid_to_bin(bin_to_uuid(a)) = a AS c2,
       HEX(uuid_to_bin(bin_to_uuid(a, TRUE), TRUE)) AS c3,
       uuid_to_bin(bin_to_uuid(a, TRUE), TRUE) = a AS c4
FROM t;
DROP TABLE t;
CREATE TABLE at(_bin binary(16),
                _vbn varbinary(16),
                _tbl tinyblob,
                _ttx tinytext,
                _blb blob);
INSERT into at VALUES(
x'12345678123456781234567812345678',
x'12345678123456781234567812345678',
x'12345678123456781234567812345678',
x'12345678123456781234567812345678',
x'12345678123456781234567812345678');
DELETE FROM at;
INSERT into at(_bin,_blb) VALUES('c8eb4b15cb0948bb','c8eb4b15cb0948bb');
CREATE TABLE t3 AS SELECT hex('c8eb4b15cb0948bb'),hex(_bin),hex(_blb) FROM at;
DROP TABLE t3;
CREATE TABLE t3 AS SELECT
uuid_to_bin('c8eb4b15-cb09-48bb-bbb2-e6a0b6b4d5c7') AS a,
uuid_to_bin('c8eb4b15-cb09-48bb-bbb2-e6a0b6b4d5c7', true) AS b;
DROP TABLE t3;
CREATE TABLE t3 AS SELECT unhex(_bin) FROM at;
DROP TABLE t3;
DROP TABLE at;
PREPARE s FROM "SELECT bin_to_uuid(x'7f9d04ae61b34468ac798ffcc984ab68',true)";
PREPARE s2 FROM "SELECT bin_to_uuid(uuid_to_bin('{12345678-1234-5678-1234-567812345678}', true), true)";
CREATE TABLE t1(col1 varchar(100), gcol2 binary(16) AS (uuid_to_bin(col1)) virtual, index(gcol2));
INSERT into t1(col1) VALUES
('{12345678-1234-5678-1234-567812345678}'),
('12345679123456781234567812345678'),
('12345670-1234-5678-1234-567812345678');
SELECT col1, HEX(gcol2) FROM t1 where gcol2=x'12345679123456781234567812345678';
CREATE TABLE t2(col1 binary(16), gcol2 varchar(36) AS (bin_to_uuid(col1)) virtual, index(col1), index(gcol2));
INSERT into t2(col1) VALUES
(x'12345678123456781234567812345678'),
(x'12345679123456781234567812345678'),
(x'12345670123456781234567812345678');
DROP TABLE t1;
DROP TABLE t2;
