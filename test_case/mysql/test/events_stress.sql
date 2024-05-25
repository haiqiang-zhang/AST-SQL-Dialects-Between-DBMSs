CREATE EVENT ev_drop1 ON SCHEDULE EVERY 10 MINUTE DISABLE DO SELECT 1;
CREATE EVENT ev_drop2 ON SCHEDULE EVERY 10 MINUTE DISABLE DO SELECT 1;
CREATE EVENT ev_drop3 ON SCHEDULE EVERY 10 MINUTE DISABLE DO SELECT 1;
SELECT COUNT(*) FROM INFORMATION_SCHEMA.EVENTS;
SELECT COUNT(*) FROM INFORMATION_SCHEMA.EVENTS WHERE EVENT_SCHEMA='events_conn1_test2';
DROP DATABASE events_conn1_test2;
SELECT COUNT(*) FROM INFORMATION_SCHEMA.EVENTS WHERE EVENT_SCHEMA='events_conn1_test2';
CREATE DATABASE events_conn1_test2;
SELECT COUNT(*) FROM INFORMATION_SCHEMA.EVENTS WHERE EVENT_SCHEMA='events_conn1_test2';
DROP DATABASE events_conn1_test2;
SELECT COUNT(*) FROM INFORMATION_SCHEMA.EVENTS WHERE EVENT_SCHEMA='events_conn1_test2';
CREATE DATABASE events_conn1_test3;
SELECT COUNT(*) FROM INFORMATION_SCHEMA.EVENTS WHERE EVENT_SCHEMA='events_conn1_test3';
CREATE DATABASE events_conn1_test4;
CREATE DATABASE events_conn1_test2;
SELECT COUNT(*) FROM INFORMATION_SCHEMA.EVENTS WHERE EVENT_SCHEMA='events_conn1_test2';
DROP DATABASE events_conn2_db;
DROP DATABASE events_conn3_db;
DROP DATABASE events_conn1_test2;
DROP DATABASE events_conn1_test3;
DROP DATABASE events_conn1_test4;
DROP DATABASE events_test;
