CREATE TEMPORARY TABLE test ("\\" String DEFAULT '\r\n\t\\' || '
');
INSERT INTO test VALUES ('Hello, world!');
INSERT INTO test ("\\") VALUES ('Hello, world!');
