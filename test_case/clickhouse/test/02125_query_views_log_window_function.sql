set allow_experimental_analyzer = 0;
set allow_experimental_window_view = 1;
CREATE TABLE data ( `id` UInt64, `timestamp` DateTime) ENGINE = Memory;
CREATE WINDOW VIEW wv Engine Memory as select count(id), tumbleStart(w_id) as window_start from data group by tumble(timestamp, INTERVAL '10' SECOND) as w_id;
INSERT INTO data VALUES(1,now());
SYSTEM FLUSH LOGS;