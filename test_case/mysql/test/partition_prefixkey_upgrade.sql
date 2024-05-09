CREATE TABLE t2 (
  a VARCHAR(10000) NOT NULL,
  b VARCHAR(10) NOT NULL,
  PRIMARY KEY (a(100),b)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 PARTITION BY KEY() PARTITIONS 3;
INSERT INTO t2 VALUES
    ('a','a'),
    ('a','b'),
    ('b','a'),
    ('a','aa'),
    ('aa','a'),
    ('a','zz'),
    ('zz','a');
