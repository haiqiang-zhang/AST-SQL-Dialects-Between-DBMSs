SELECT COUNT() from time_table WHERE value < now() - 1 AND value != 0 AND modulo(value, 2) != 0 AND timecol < now() - 1;
INSERT INTO time_table VALUES (now(), 101);
DROP TABLE IF EXISTS time_table;
