SELECT * FROM alter_enum_array ORDER BY Key;
DETACH TABLE alter_enum_array;
ATTACH TABLE alter_enum_array;
SELECT * FROM alter_enum_array ORDER BY Key;
OPTIMIZE TABLE alter_enum_array FINAL;
SELECT COUNT() FROM system.mutations where table='alter_enum_array' and database=currentDatabase();
DROP TABLE IF EXISTS alter_enum_array;
