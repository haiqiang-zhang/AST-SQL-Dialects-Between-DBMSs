SELECT toTypeName(alias) FROM data_01269;
SELECT any(alias) FROM data_01269;
ALTER TABLE data_01269 DROP COLUMN alias;
ALTER TABLE data_01269 ADD COLUMN alias UInt8 ALIAS value>0;
SELECT toTypeName(alias) FROM data_01269;
SELECT any(alias) FROM data_01269;
DROP TABLE data_01269;