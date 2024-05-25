select 'create replica 1 and check deduplication';
select 'two inserts with exact data, one inserted, one deduplicated by data digest';
select 'two inserts with the same dedup token, one inserted, one deduplicated by the token';
set insert_deduplication_token = '1';
select 'reset deduplication token and insert new row';
set insert_deduplication_token = '';
select 'create replica 2 and check deduplication';
select 'inserted value deduplicated by data digest, the same result as before';
set insert_deduplication_token = '';
select 'inserted value deduplicated by dedup token, the same result as before';
set insert_deduplication_token = '1';
select 'new record inserted by providing new deduplication token';
set insert_deduplication_token = '2';