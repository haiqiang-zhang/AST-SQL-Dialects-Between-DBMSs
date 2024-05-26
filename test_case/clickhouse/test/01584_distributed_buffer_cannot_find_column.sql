select sum(amount) = 100 from realtimebuff;
OPTIMIZE TABLE realtimebuff;
select sum(amount) IN (0, 100, 200) from realtimebuff;
select sum(amount) = 200 from realtimebuff;
DROP TABLE realtimedrep;
DROP TABLE realtimebuff;
