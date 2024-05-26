DROP TABLE IF EXISTS mt_00168;
DROP TABLE IF EXISTS mt_00168_buffer;
set allow_deprecated_syntax_for_merge_tree=1;
CREATE TABLE mt_00168 (EventDate Date, UTCEventTime DateTime, MoscowEventDate Date DEFAULT toDate(UTCEventTime)) ENGINE = MergeTree(EventDate, UTCEventTime, 8192);
CREATE TABLE mt_00168_buffer AS mt_00168 ENGINE = Buffer(currentDatabase(), mt_00168, 16, 10, 100, 10000, 1000000, 10000000, 100000000);
