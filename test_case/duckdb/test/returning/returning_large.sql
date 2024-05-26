SELECT count(*) FROM table1;
INSERT INTO table1(a, b, c) SELECT a, b, c FROM table1  RETURNING a;
