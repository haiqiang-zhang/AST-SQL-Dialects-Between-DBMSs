ALTER TABLE alter_test MODIFY COLUMN `b` DateTime DEFAULT now();
ALTER TABLE alter_test MODIFY COLUMN `b` DEFAULT now() + 1;
SHOW CREATE TABLE alter_test;
DROP TABLE alter_test;
