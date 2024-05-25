SYSTEM STOP MERGES data;
-- this will create a gap in marks
INSERT INTO data SELECT number,     if(number/8192 % 2 == 0, now(), now() - INTERVAL 200 DAY) FROM numbers(1e6);
INSERT INTO data SELECT number+1e6, if(number/8192 % 2 == 0, now(), now() - INTERVAL 200 DAY) FROM numbers(1e6);
