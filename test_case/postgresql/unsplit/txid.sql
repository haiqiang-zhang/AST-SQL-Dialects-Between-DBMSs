select '12:13:'::txid_snapshot;
select '12:18:14,16'::txid_snapshot;
select '12:16:14,14'::txid_snapshot;
create temp table snapshot_test (
	nr	integer,
	snap	txid_snapshot
);
insert into snapshot_test values (1, '12:13:');
insert into snapshot_test values (2, '12:20:13,15,18');
insert into snapshot_test values (3, '100001:100009:100005,100007,100008');
insert into snapshot_test values (4, '100:150:101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131');
select snap from snapshot_test order by nr;
select  txid_snapshot_xmin(snap),
	txid_snapshot_xmax(snap),
	txid_snapshot_xip(snap)
from snapshot_test order by nr;
select id, txid_visible_in_snapshot(id, snap)
from snapshot_test, generate_series(11, 21) id
where nr = 2;
select txid_current() >= txid_snapshot_xmin(txid_current_snapshot());
select txid_snapshot '1000100010001000:1000100010001100:1000100010001012,1000100010001013';
SELECT txid_snapshot '1:9223372036854775807:3';
BEGIN;
SELECT txid_current_if_assigned() IS NULL;
COMMIT;
BEGIN;
COMMIT;
BEGIN;
CREATE FUNCTION test_future_xid_status(bigint)
RETURNS void
LANGUAGE plpgsql
AS
$$
BEGIN
  PERFORM txid_status($1);
  RAISE EXCEPTION 'didn''t ERROR at xid in the future as expected';
EXCEPTION
  WHEN invalid_parameter_value THEN
    RAISE NOTICE 'Got expected error for xid in the future';
END;
$$;
ROLLBACK;
