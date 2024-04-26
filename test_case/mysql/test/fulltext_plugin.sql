
--
-- BUG#39746 - Debug flag breaks struct definition (server crash)
--
--replace_regex /\.dll/.so/
eval INSTALL PLUGIN simple_parser SONAME '$SIMPLE_PARSER';
CREATE TABLE t1(a TEXT, b TEXT, FULLTEXT(a) WITH PARSER simple_parser);
ALTER TABLE t1 ADD FULLTEXT(b) WITH PARSER simple_parser;
DROP TABLE t1;