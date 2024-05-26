DROP TABLE IF EXISTS xp;
DROP TABLE IF EXISTS xp_d;
SET log_queries = 1;
CREATE TABLE xp (`A` Date, `B` Int64, `S` String) ENGINE = MergeTree PARTITION BY toYYYYMM(A) ORDER BY B;
INSERT INTO xp SELECT '2020-01-01', number, '' FROM numbers(100000);
DROP TABLE IF EXISTS xp;
DROP TABLE IF EXISTS xp_d;
DROP TABLE IF EXISTS trace_log;
CREATE TABLE trace_log
(
   `event_date` Date,
   `event_time` DateTime,
   `event_time_microseconds` DateTime64(6),
   `timestamp_ns` UInt64,
   `revision` UInt32,
   `trace_type` Enum8('Real' = 0, 'CPU' = 1, 'Memory' = 2, 'MemorySample' = 3),
   `thread_id` UInt64,
   `query_id` String,
   `trace` Array(UInt64),
   `size` Int64
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(event_date)
ORDER BY (event_date, event_time)
SETTINGS index_granularity = 8192;
INSERT INTO trace_log values ('2020-10-06','2020-10-06 13:43:39','2020-10-06 13:43:39.208819',1601981019208819975,54441,'Real',20412,'2e8ddf40-48da-4641-8ccc-573dd487753f',[140316350688023,130685338,226362737,224904385,227758790,227742969,227761037,224450136,219847931,219844987,219854151,223212098,223208665,228194329,228227607,257889111,257890159,258775545,258767526,140316350645979,140316343425599],0);
set allow_introspection_functions = 1;
