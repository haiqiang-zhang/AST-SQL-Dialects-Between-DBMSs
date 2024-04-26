
-- mysqltest needs to be invoked with --compress option. Write to a file and then invoke mysql test with compress option.
--write_file $MYSQL_TMP_DIR/bug26974113.test
SET GLOBAL max_allowed_packet=33554432;
SELECT REPEAT('T', 16777211);
SET GLOBAL MAX_ALLOWED_PACKET=default;
