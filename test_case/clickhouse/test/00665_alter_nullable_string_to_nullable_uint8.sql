SELECT * FROM alter_00665;
SELECT * FROM alter_00665 ORDER BY boolean_false NULLS LAST;
ALTER TABLE alter_00665 MODIFY COLUMN `boolean_false` Nullable(UInt8);
SELECT * FROM alter_00665;
SELECT * FROM alter_00665 ORDER BY boolean_false NULLS LAST;
DROP TABLE alter_00665;