DROP TABLE IF EXISTS empty1;
DROP TABLE IF EXISTS empty2;
SELECT 'Check creating empty parts';
SELECT table, partition, active FROM system.parts where table = 'empty1' and database=currentDatabase() and active = 1;
SELECT table, partition, active FROM system.parts where table = 'empty2' and database=currentDatabase() and active = 1;
SELECT table, partition, active FROM system.parts where table = 'empty1' and database=currentDatabase() and active = 1;
SELECT table, partition, active FROM system.parts where table = 'empty2' and database=currentDatabase() and active = 1;
DROP TABLE IF EXISTS empty1;
DROP TABLE IF EXISTS empty2;
