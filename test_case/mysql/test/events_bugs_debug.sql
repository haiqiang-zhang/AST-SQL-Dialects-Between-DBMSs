
-- Save the initial number of concurrent sessions.
--source include/count_sessions.inc

--echo --
--echo -- Bug#21914871 : ASSERTION `! IS_SET()' FOR DIAGNOSTICS_AREA::SET_OK_STATUS
--echo --                  CREATE EVENT
--echo --

SET SESSION DEBUG='+d,thd_killed_injection';
CREATE EVENT event1 ON SCHEDULE EVERY 1 YEAR DO SELECT 1;
SET SESSION DEBUG='-d,thd_killed_injection';

CREATE EVENT café ON SCHEDULE EVERY 2 YEAR DO SELECT 1;
SET DEBUG_SYNC='after_acquiring_shared_lock_on_the_event SIGNAL locked WAIT_FOR continue';
SET DEBUG_SYNC='now WAIT_FOR locked';
let $wait_condition= SELECT COUNT(*) > 0 FROM information_schema.processlist
                     WHERE info LIKE 'ALTER EVENT%' AND
                     state='Waiting for event metadata lock';
SET DEBUG_SYNC='now SIGNAL continue';

SET DEBUG_SYNC='after_acquiring_exclusive_lock_on_the_event SIGNAL locked WAIT_FOR continue';
SET DEBUG_SYNC='now WAIT_FOR locked';
let $wait_condition= SELECT COUNT(*) > 0 FROM information_schema.processlist
                     WHERE info LIKE 'SHOW CREATE EVENT%' AND
                     state='Waiting for event metadata lock';
SET DEBUG_SYNC='now SIGNAL continue';
SET DEBUG_SYNC='RESET';


-- Check that all connections opened by test cases in this file are really gone
-- so execution of other tests won't be affected by their presence.
--source include/wait_until_count_sessions.inc


--echo --
--echo --  BUG#29140298 - `OPT_EVENT_SCHEDULER == EVENTS::EVENTS_ON ||
--echo --                  OPT_EVENT_SCHEDULER == EVENTS::EVEN
--echo --  When mysqld is started with --event_scheduler=DISABLED,
--echo --  it asserts on debug build without the fix.
--echo --  With the fix, the event scheduler initialization is skipped
--echo --  if mysqld is started with --event_scheduler=DISABLED.

--let $restart_parameters = restart: --event_scheduler=DISABLED
--source include/restart_mysqld.inc
-- Ensure the event scheduler is OFF.
SELECT @@event_scheduler='DISABLED';
