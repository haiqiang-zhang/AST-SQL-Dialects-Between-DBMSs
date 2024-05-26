--    2024.02.22 19:33:36.280936 [ 108818 ] {0e1586f5-8ae0-4065-81b7-1e7d43b85d82} <Error> DDLWorker(test_devov0ke): Query /* ddl_entry=query-0000000009 */ CREATE MATERIALIZED VIEW test_devov0ke.mv UUID 'bf3a2bfe-1446-4a02-b760-bae514488c5a' TO test_devov0ke.output (`key` UInt64, `val` UInt64) AS SELECT key, dictGetUInt64('dict_in_01023.dict', 'val', key) AS val FROM test_devov0ke.dist_out wasn't finished successfully: Code: 36. DB::Exception: Dictionary (`dict_in_01023.dict`) not found. (BAD_ARGUMENTS), Stack trace (when copying this message, always include the lines below):

-- Create dictionary, since dictGet*() uses DB::Context in executeImpl()
-- (To cover scope of the Context in PushingToViews chain)

set distributed_foreground_insert=1;
DROP TABLE IF EXISTS mv;
DROP DATABASE IF EXISTS dict_in_01023;
CREATE DATABASE dict_in_01023;
CREATE TABLE dict_in_01023.input (key UInt64, val UInt64) Engine=Memory();
CREATE DICTIONARY dict_in_01023.dict
(
  key UInt64 DEFAULT 0,
  val UInt64 DEFAULT 1
)
PRIMARY KEY key
SOURCE(CLICKHOUSE(HOST 'localhost' PORT tcpPort() USER 'default' TABLE 'input' PASSWORD '' DB 'dict_in_01023'))
LIFETIME(MIN 0 MAX 0)
LAYOUT(HASHED());
CREATE TABLE null_    (key UInt64) Engine=Null();
CREATE TABLE buffer_  (key UInt64) Engine=Buffer(currentDatabase(), dist_out, 1, 0, 0, 0, 0, 0, 0);
CREATE TABLE output (key UInt64, val UInt64) Engine=Memory();
SELECT count() FROM output;
DROP TABLE output;
DROP TABLE buffer_;
DROP TABLE null_;
DROP DICTIONARY dict_in_01023.dict;
DROP TABLE dict_in_01023.input;
DROP DATABASE dict_in_01023;
