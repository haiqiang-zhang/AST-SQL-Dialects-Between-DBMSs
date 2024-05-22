DROP TABLE IF EXISTS test;
CREATE TABLE test(a UInt8, b String EPHEMERAL) Engine=Memory();
SHOW CREATE TABLE test;
DROP TABLE test;
CREATE TABLE test(a UInt8, b String EPHEMERAL 1+2) Engine=Memory();
SHOW CREATE TABLE test;
DROP TABLE test;
