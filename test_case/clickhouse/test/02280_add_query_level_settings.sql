ALTER TABLE table_for_alter MODIFY SETTING parts_to_throw_insert = 100, parts_to_delay_insert = 100;
INSERT INTO table_for_alter VALUES (3, '3');
