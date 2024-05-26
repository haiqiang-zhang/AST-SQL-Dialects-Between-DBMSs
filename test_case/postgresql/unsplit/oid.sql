CREATE TABLE OID_TBL(f1 oid);
INSERT INTO OID_TBL(f1) VALUES ('1234');
INSERT INTO OID_TBL(f1) VALUES ('1235');
INSERT INTO OID_TBL(f1) VALUES ('987');
INSERT INTO OID_TBL(f1) VALUES ('-1040');
INSERT INTO OID_TBL(f1) VALUES ('99999999');
INSERT INTO OID_TBL(f1) VALUES ('5     ');
INSERT INTO OID_TBL(f1) VALUES ('   10  ');
INSERT INTO OID_TBL(f1) VALUES ('	  15 	  ');
SELECT * FROM OID_TBL;
SELECT pg_input_is_valid('1234', 'oid');
SELECT * FROM pg_input_error_info('01XYZ', 'oid');
SELECT o.* FROM OID_TBL o WHERE o.f1 = 1234;
SELECT o.* FROM OID_TBL o WHERE o.f1 <> '1234';
SELECT o.* FROM OID_TBL o WHERE o.f1 <= '1234';
SELECT o.* FROM OID_TBL o WHERE o.f1 < '1234';
SELECT o.* FROM OID_TBL o WHERE o.f1 >= '1234';
SELECT o.* FROM OID_TBL o WHERE o.f1 > '1234';
DROP TABLE OID_TBL;
