BEGIN TRANSACTION;
BEGIN TRANSACTION;
CREATE SEQUENCE seq;;
SELECT nextval('seq');;
COMMIT;
SELECT nextval('seq');;
COMMIT;
BEGIN TRANSACTION;
DROP SEQUENCE seq;;
SELECT nextval('seq');;
ROLLBACK;;
DROP SEQUENCE seq;;
SELECT nextval('seq');;
SELECT nextval('seq');;
SELECT nextval('seq');;
SELECT nextval('seq');;
SELECT nextval('seq');;
SELECT nextval('seq');;