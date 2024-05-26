DROP TABLE IF EXISTS test;
CREATE TABLE test(a UInt8, b String EPHEMERAL) Engine=Memory();
