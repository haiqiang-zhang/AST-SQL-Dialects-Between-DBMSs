ATTACH DATABASE '__TEST_DIR__/attach_seq.db' AS db1;;
CREATE SEQUENCE seq;;
CREATE TABLE db1.integers(i INTEGER DEFAULT nextval('seq'));
CREATE SEQUENCE db1.seq;
CREATE TABLE db1.integers(i INTEGER DEFAULT nextval('db1.seq'));
CREATE TABLE integers(i INTEGER DEFAULT nextval('db1.seq'));
detach db1;;
ATTACH DATABASE '__TEST_DIR__/attach_seq.db' AS db1;;
SELECT nextval('db1.seq');
SELECT nextval('seq');