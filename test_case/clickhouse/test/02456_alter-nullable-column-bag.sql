ALTER TABLE column_modify_test MODIFY COLUMN val Nullable(String);
INSERT INTO column_modify_test VALUES (3,Null,0);
-- and it what part it will update columns.txt to the latest 'correct' state w/o updating the column file!
alter table column_modify_test update other_col=1 where id = 1 SETTINGS mutations_sync=1;
