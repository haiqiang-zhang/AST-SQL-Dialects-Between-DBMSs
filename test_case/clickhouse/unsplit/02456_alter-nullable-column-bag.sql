DROP TABLE IF EXISTS column_modify_test;
CREATE TABLE column_modify_test (id UInt64, val String, other_col UInt64) engine=MergeTree ORDER BY id SETTINGS min_bytes_for_wide_part=0;
INSERT INTO column_modify_test VALUES (1,'one',0);
INSERT INTO column_modify_test VALUES (2,'two',0);
ALTER TABLE column_modify_test MODIFY COLUMN val Nullable(String);
INSERT INTO column_modify_test VALUES (3,Null,0);
-- and it what part it will update columns.txt to the latest 'correct' state w/o updating the column file!
alter table column_modify_test update other_col=1 where id = 1 SETTINGS mutations_sync=1;
