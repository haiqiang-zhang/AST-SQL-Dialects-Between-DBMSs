SELECT a, b, c FROM buffer_00126 ORDER BY a, b, c;
SELECT b, c, a FROM buffer_00126 ORDER BY a, b, c;
SELECT c, a, b FROM buffer_00126 ORDER BY a, b, c;
SELECT a, c, b FROM buffer_00126 ORDER BY a, b, c;
SELECT b, a, c FROM buffer_00126 ORDER BY a, b, c;
SELECT c, b, a FROM buffer_00126 ORDER BY a, b, c;
SELECT a, b FROM buffer_00126 ORDER BY a, b, c;
SELECT b, c FROM buffer_00126 ORDER BY a, b, c;
SELECT c, a FROM buffer_00126 ORDER BY a, b, c;
SELECT a, c FROM buffer_00126 ORDER BY a, b, c;
SELECT b, a FROM buffer_00126 ORDER BY a, b, c;
SELECT c, b FROM buffer_00126 ORDER BY a, b, c;
SELECT a FROM buffer_00126 ORDER BY a, b, c;
SELECT b FROM buffer_00126 ORDER BY a, b, c;
SELECT c FROM buffer_00126 ORDER BY a, b, c;
INSERT INTO buffer_00126 (c, b, a) VALUES ([7], '8', 9);
SELECT a, b, c FROM buffer_00126 ORDER BY a, b, c;
SELECT b, c, a FROM buffer_00126 ORDER BY a, b, c;
SELECT c, a, b FROM buffer_00126 ORDER BY a, b, c;
SELECT a, c, b FROM buffer_00126 ORDER BY a, b, c;
SELECT b, a, c FROM buffer_00126 ORDER BY a, b, c;
SELECT c, b, a FROM buffer_00126 ORDER BY a, b, c;
SELECT a, b FROM buffer_00126 ORDER BY a, b, c;
SELECT b, c FROM buffer_00126 ORDER BY a, b, c;
SELECT c, a FROM buffer_00126 ORDER BY a, b, c;
SELECT a, c FROM buffer_00126 ORDER BY a, b, c;
SELECT b, a FROM buffer_00126 ORDER BY a, b, c;
SELECT c, b FROM buffer_00126 ORDER BY a, b, c;
SELECT a FROM buffer_00126 ORDER BY a, b, c;
SELECT b FROM buffer_00126 ORDER BY a, b, c;
SELECT c FROM buffer_00126 ORDER BY a, b, c;
INSERT INTO buffer_00126 (a, c) VALUES (11, [33]);
SELECT a, b, c FROM buffer_00126 ORDER BY a, b, c;
SELECT b, c, a FROM buffer_00126 ORDER BY a, b, c;
SELECT c, a, b FROM buffer_00126 ORDER BY a, b, c;
SELECT a, c, b FROM buffer_00126 ORDER BY a, b, c;
SELECT b, a, c FROM buffer_00126 ORDER BY a, b, c;
SELECT c, b, a FROM buffer_00126 ORDER BY a, b, c;
SELECT a, b FROM buffer_00126 ORDER BY a, b, c;
SELECT b, c FROM buffer_00126 ORDER BY a, b, c;
SELECT c, a FROM buffer_00126 ORDER BY a, b, c;
SELECT a, c FROM buffer_00126 ORDER BY a, b, c;
SELECT b, a FROM buffer_00126 ORDER BY a, b, c;
SELECT c, b FROM buffer_00126 ORDER BY a, b, c;
SELECT a FROM buffer_00126 ORDER BY a, b, c;
SELECT b FROM buffer_00126 ORDER BY a, b, c;
SELECT c FROM buffer_00126 ORDER BY a, b, c;
DROP TABLE buffer_00126;
DROP TABLE null_sink_00126;