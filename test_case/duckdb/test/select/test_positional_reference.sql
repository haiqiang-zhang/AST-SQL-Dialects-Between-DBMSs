SELECT #1 FROM range(1);
SELECT #1+#2 FROM range(1) tbl, range(1) tbl2;
SELECT #1 FROM (SELECT * FROM range(1)) tbl;
