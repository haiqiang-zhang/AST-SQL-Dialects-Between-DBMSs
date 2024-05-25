DROP TABLE IF EXISTS mt_01451;
CREATE TABLE mt_01451 (v UInt8) ENGINE = MergeTree() order by tuple() SETTINGS old_parts_lifetime=0;
