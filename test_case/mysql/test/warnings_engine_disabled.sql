
--
-- Only run this test with a compiled in but disabled
-- engine
--
let $federated_support = `select engine from information_schema.engines where engine = 'FEDERATED'`;

--
-- Test for using disabled engine
-- The server will throw an error - since FEDERATED is disabled
--
--ERROR ER_UNKNOWN_STORAGE_ENGINE
create table t1 (id int) engine=FEDERATED;
alter table t1 engine=FEDERATED;
drop table t1;

--
-- Bug#29263 disabled storage engines omitted in SHOW ENGINES
--
SELECT ENGINE, SUPPORT FROM INFORMATION_SCHEMA.ENGINES WHERE ENGINE='FEDERATED';
SELECT PLUGIN_NAME, PLUGIN_STATUS FROM INFORMATION_SCHEMA.PLUGINS WHERE
PLUGIN_NAME='FEDERATED';
