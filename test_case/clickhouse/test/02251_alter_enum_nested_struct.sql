ALTER TABLE alter_enum_array MODIFY COLUMN Value  Array(Enum8('Option1'=1, 'Option2'=2, 'Option3'=3)) SETTINGS mutations_sync=2;
INSERT INTO alter_enum_array VALUES (3, ['Option1','Option3']);
SELECT * FROM alter_enum_array ORDER BY Key;
DETACH TABLE alter_enum_array;
ATTACH TABLE alter_enum_array;
SELECT * FROM alter_enum_array ORDER BY Key;
OPTIMIZE TABLE alter_enum_array FINAL;
SELECT COUNT() FROM system.mutations where table='alter_enum_array' and database=currentDatabase();
DROP TABLE IF EXISTS alter_enum_array;
