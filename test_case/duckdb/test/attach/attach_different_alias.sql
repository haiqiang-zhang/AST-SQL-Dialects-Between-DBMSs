PRAGMA enable_verification;
ATTACH '__TEST_DIR__/attach_alias.db' AS alias1;
create table alias1.tbl1 as select 1 as a;;
DETACH alias1;
ATTACH '__TEST_DIR__/attach_alias.db' AS alias2;
FROM alias1.tbl1;
FROM alias2.tbl1;
