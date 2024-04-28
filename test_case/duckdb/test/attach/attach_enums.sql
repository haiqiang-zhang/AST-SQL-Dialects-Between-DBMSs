PRAGMA enable_verification;
ATTACH '__TEST_DIR__/attach_enums.db' AS db1;
CREATE TYPE db1.mood AS ENUM ('sad', 'ok', 'happy');;
SELECT enum_range(NULL::xx.db1.main.mood) AS my_enum_range;;
DROP TYPE db1.mood;
DROP TYPE IF EXISTS db1.main.mood;
CREATE TYPE db1.mood AS ENUM ('sad', 'ok', 'happy');;
CREATE TABLE db1.person (
    name text,
    current_mood mood
);;
INSERT INTO db1.person VALUES ('Moe', 'happy');;
DETACH db1;
ATTACH '__TEST_DIR__/attach_enums.db' AS db1 (READ_ONLY);
ATTACH '__TEST_DIR__/attach_enums_2.db' AS db2;
CREATE TYPE db2.mood AS ENUM ('ble','grr','kkcry');;
CREATE TABLE db2.person (
    name text,
    current_mood mood
);;
INSERT INTO db2.person VALUES ('Moe', 'kkcry');;
SELECT enum_range(NULL::db1.mood) AS my_enum_range;;
SELECT enum_range(NULL::db1.main.mood) AS my_enum_range;;
select * from db1.person;
select * from db1.person;
select * from db1.person;
select * from db2.person;
