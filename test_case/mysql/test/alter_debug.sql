
CREATE TABLE test.t1(col INT);
SET SESSION debug= "+d, enable_stack_overrun_post_alter_commit";
ALTER TABLE test.t1 ADD COLUMN col1 CHAR;
SET SESSION debug= "-d, enable_stack_overrun_post_alter_commit";
DROP TABLE test.t1;
