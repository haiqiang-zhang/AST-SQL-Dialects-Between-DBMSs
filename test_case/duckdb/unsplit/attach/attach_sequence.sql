ATTACH DATABASE '__TEST_DIR__/attach_seq.db' AS db1;
CREATE SEQUENCE seq;
detach db1;
ATTACH DATABASE '__TEST_DIR__/attach_seq.db' AS db1;
SELECT nextval('db1.seq');
SELECT nextval('seq');
