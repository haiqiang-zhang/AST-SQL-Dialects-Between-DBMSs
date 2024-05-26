SELECT number as x, roundDown(x, [0, 1, 2, 3, 4, 5]) FROM system.numbers LIMIT 10;
SET send_logs_level = 'fatal';
