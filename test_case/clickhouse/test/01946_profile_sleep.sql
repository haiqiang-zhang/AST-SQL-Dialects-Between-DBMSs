SET log_queries=1;
SET log_profile_events=true;
SYSTEM FLUSH LOGS;
SYSTEM FLUSH LOGS;
SYSTEM FLUSH LOGS;
SYSTEM FLUSH LOGS;
CREATE VIEW sleep_view AS SELECT sleepEachRow(0.001) FROM system.numbers;
SYSTEM FLUSH LOGS;
SYSTEM FLUSH LOGS;
DROP TABLE sleep_view;