SET send_logs_level = 'fatal';
SELECT * FROM system.numbers LIMIT 3;
SELECT sys_num.number FROM system.numbers AS sys_num WHERE number > 2 LIMIT 2;
SELECT number FROM system.numbers WHERE number >= 5 LIMIT 2;
SELECT * FROM system.numbers WHERE number == 7 LIMIT 1;
SELECT number AS n FROM system.numbers WHERE number IN(8, 9) LIMIT 2;
select number from system.numbers limit 0;
