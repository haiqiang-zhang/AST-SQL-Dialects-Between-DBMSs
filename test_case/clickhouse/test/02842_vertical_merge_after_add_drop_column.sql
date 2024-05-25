alter table data add column `features_legacy_Map.id` Array(UInt8), add column `features_legacy_Map.count` Array(UInt32);
alter table data drop column legacy_features_Map settings mutations_sync=2;
optimize table data final;
DROP TABLE data;
