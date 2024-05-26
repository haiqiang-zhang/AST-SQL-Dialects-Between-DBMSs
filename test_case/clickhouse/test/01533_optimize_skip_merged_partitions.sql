OPTIMIZE TABLE optimize_final FINAL;
INSERT INTO optimize_final SELECT toDate('2000-01-01'), number FROM numbers(5);
INSERT INTO optimize_final SELECT toDate('2000-01-01'), number + 5 FROM numbers(5);
OPTIMIZE TABLE optimize_final FINAL;
SELECT table, partition, active, level from system.parts where table = 'optimize_final' and database = currentDatabase() and active = 1;
DROP TABLE optimize_final;
