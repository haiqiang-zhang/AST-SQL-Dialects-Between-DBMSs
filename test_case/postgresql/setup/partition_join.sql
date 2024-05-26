SET enable_partitionwise_join to true;
CREATE TABLE prt1 (a int, b int, c varchar) PARTITION BY RANGE(a);
CREATE TABLE prt1_p1 PARTITION OF prt1 FOR VALUES FROM (0) TO (250);
CREATE TABLE prt1_p3 PARTITION OF prt1 FOR VALUES FROM (500) TO (600);
CREATE TABLE prt1_p2 PARTITION OF prt1 FOR VALUES FROM (250) TO (500);
INSERT INTO prt1 SELECT i, i % 25, to_char(i, 'FM0000') FROM generate_series(0, 599) i WHERE i % 2 = 0;
CREATE INDEX iprt1_p1_a on prt1_p1(a);
CREATE INDEX iprt1_p2_a on prt1_p2(a);
CREATE INDEX iprt1_p3_a on prt1_p3(a);
