SET allow_experimental_analyzer=1;
create table test_join (TOPIC String, PARTITION UInt64, OFFSET UInt64)  ENGINE = Join(ANY, LEFT, `TOPIC`, `PARTITION`) SETTINGS join_any_take_last_row = 1;
insert into test_join values('abc',0,1);
