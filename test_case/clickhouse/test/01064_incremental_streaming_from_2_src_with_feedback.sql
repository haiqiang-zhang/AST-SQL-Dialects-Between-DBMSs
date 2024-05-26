SYSTEM STOP MERGES target_table;
SYSTEM STOP MERGES checkouts;
SYSTEM STOP MERGES logins;
INSERT INTO logins SELECT number as id,    '2000-01-01 08:00:00' from numbers(50000);
INSERT INTO checkouts SELECT number as id, '2000-01-01 10:00:00' from numbers(50000);
set max_rows_to_read = 7120;
INSERT INTO logins    SELECT number as id, '2000-01-01 11:00:00' from numbers(1000);
INSERT INTO checkouts SELECT number as id, '2000-01-01 11:10:00' from numbers(1000);
set max_rows_to_read = 897;
INSERT INTO logins    SELECT number+2 as id, '2001-01-01 11:10:01' from numbers(1);
INSERT INTO checkouts SELECT number+2 as id, '2001-01-01 11:10:02' from numbers(1);
set max_rows_to_read = 0;
select '-- unmerged state';
select
   id,
   finalizeAggregation(latest_login_time) as current_latest_login_time,
   finalizeAggregation(latest_checkout_time) as current_latest_checkout_time,
   finalizeAggregation(fastest_session)  as current_fastest_session,
   finalizeAggregation(biggest_inactivity_period)  as current_biggest_inactivity_period
from target_table
where id in (1,2)
ORDER BY id, current_latest_login_time, current_latest_checkout_time;
select '-- merged state';
SELECT
     id,
     maxMerge(latest_login_time) as current_latest_login_time,
     maxMerge(latest_checkout_time) as current_latest_checkout_time,
     minMerge(fastest_session) as current_fastest_session,
     maxMerge(biggest_inactivity_period) as current_biggest_inactivity_period
FROM target_table
where id in (1,2)
GROUP BY id
ORDER BY id;
DROP TABLE IF EXISTS logins;
DROP TABLE IF EXISTS mv_logins2target;
DROP TABLE IF EXISTS checkouts;
DROP TABLE IF EXISTS mv_checkouts2target;
DROP TABLE target_table;
