SET joined_subquery_requires_alias = 0;
SET max_threads = 1;
SET max_bytes_before_external_sort = 0;
SET max_bytes_before_external_group_by = 0;
DROP TABLE IF EXISTS target_table;
DROP TABLE IF EXISTS logins;
DROP TABLE IF EXISTS mv_logins2target;
DROP TABLE IF EXISTS checkouts;
DROP TABLE IF EXISTS mv_checkouts2target;
CREATE TABLE target_table Engine=SummingMergeTree() ORDER BY id
SETTINGS index_granularity=128, index_granularity_bytes = '10Mi'
AS
   SELECT
     number as id,
     maxState( toDateTime(0, 'UTC') ) as latest_login_time,
     maxState( toDateTime(0, 'UTC') ) as latest_checkout_time,
     minState( toUInt64(-1) ) as fastest_session,
     maxState( toUInt64(0) ) as biggest_inactivity_period
FROM numbers(50000)
GROUP BY id
SETTINGS max_insert_threads=1;
CREATE TABLE logins (
    id UInt64,
    ts DateTime('UTC')
) Engine=MergeTree ORDER BY id;
CREATE MATERIALIZED VIEW mv_logins2target TO target_table
AS
   SELECT
     id,
     maxState( ts ) as latest_login_time,
     maxState( toDateTime(0, 'UTC') ) as latest_checkout_time,
     minState( toUInt64(-1) ) as fastest_session,
     if(max(current_latest_checkout_time) > 0, maxState(toUInt64(ts - current_latest_checkout_time)), maxState( toUInt64(0) ) ) as biggest_inactivity_period
   FROM logins
   LEFT JOIN (
       SELECT
          id,
          maxMerge(latest_checkout_time) as current_latest_checkout_time

        -- normal MV sees only the incoming block, but we need something like feedback here
        -- so we do join with target table, the most important thing here is that
        -- we extract from target table only row affected by that MV, referencing src table
        -- it second time
        FROM target_table
        WHERE id IN (SELECT id FROM logins)
        GROUP BY id
    ) USING (id)
   GROUP BY id;
CREATE TABLE checkouts (
    id UInt64,
    ts DateTime('UTC')
) Engine=MergeTree ORDER BY id;
CREATE MATERIALIZED VIEW mv_checkouts2target TO target_table
AS
   SELECT
     id,
     maxState( toDateTime(0, 'UTC') ) as latest_login_time,
     maxState( ts ) as latest_checkout_time,
     if(max(current_latest_login_time) > 0, minState( toUInt64(ts - current_latest_login_time)), minState( toUInt64(-1) ) ) as fastest_session,
     maxState( toUInt64(0) ) as biggest_inactivity_period
   FROM checkouts
   LEFT JOIN (SELECT id, maxMerge(latest_login_time) as current_latest_login_time FROM target_table WHERE id IN (SELECT id FROM checkouts) GROUP BY id) USING (id)
   GROUP BY id;
