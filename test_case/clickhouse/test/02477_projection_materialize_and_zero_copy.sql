DROP TABLE IF EXISTS t;
insert into t (c1, c18) select number, -number from numbers(2000000);
alter table t add projection p_norm (select * order by c1);
optimize table t final;
alter table t materialize projection p_norm settings mutations_sync = 1;
SYSTEM FLUSH LOGS;
SELECT * FROM system.text_log WHERE event_time >= now() - 30 and level == 'Error' and message like '%BAD_DATA_PART_NAME%'and message like '%p_norm%';
DROP TABLE IF EXISTS t;