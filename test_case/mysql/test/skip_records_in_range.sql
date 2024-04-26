--

-- Non-traditional formats differ in hypergraph. This file tests only EXPLAIN.
--source include/not_hypergraph.inc

--source include/have_debug.inc
--source include/have_debug_sync.inc
--source include/have_innodb_16k.inc

-- All the queries use EXPLAIN FOR CONNECTION. There will be no change in
-- EXPLAIN output.

CREATE TABLE t1 (
  pk_col1 INT NOT NULL,
  a1 CHAR(64),
  a2 CHAR(64),
  PRIMARY KEY(pk_col1),
  KEY t1_a1_idx (a1),
  KEY t1_a1_a2_idx (a1, a2)
) ENGINE=INNODB;

INSERT INTO t1 (pk_col1, a1, a2) VALUES (1,'a','b'), (2,'a','b'), (3,'d','c'),
                                        (4,'b','c'), (5,'c','d'), (6,'a','b');
CREATE TABLE t2 (
  pk_col1 INT NOT NULL,
  pk_col2 INT NOT NULL,
  a1 CHAR(64),
  a2 CHAR(64),
  PRIMARY KEY(pk_col1, pk_col2),
  KEY t2_a1_idx (a1),
  KEY t2_a1_a2_idx (a1, a2)
) ENGINE=INNODB;

INSERT INTO t2 (pk_col1, pk_col2, a1, a2) VALUES (1,1,'a','b'),(1,2,'a','b'),
                                                 (1,3,'d','c'),(1,4,'b','c'),
                                                 (2,1,'c','d'),(3,1,'a','b');
let query1=SELECT a1 FROM t1 WHERE a1 > 'b';
let query2=SELECT a1 FROM t1 FORCE INDEX(t1_a1_a2_idx) WHERE a1 > 'b';
let query3=SELECT a1 FROM t1 WHERE a1 = 'a';
let query4=SELECT a1 FROM t1 FORCE INDEX(t1_a1_a2_idx) WHERE a1 = 'a';
let query5=SELECT a1 FROM t1;
let query6=SELECT a1 FROM t1 FORCE INDEX(t1_a1_a2_idx);

-- This query chose index scan before this WL, but will change to range.
-- EXPLAIN FOR CONNECTION will reflect this switch. This happens because we now
-- set rows = 1 in handler::multi_range_read_info_const.
let query7=SELECT a1 FROM t1 FORCE INDEX(t1_a1_a2_idx) WHERE a1 >= 'a';
let query8=SELECT a1 FROM t1 FORCE INDEX(t1_a1_idx) WHERE a2 > 'a';
let query9=
SELECT t2.a1, t2.a2
FROM t1 FORCE INDEX(t1_a1_a2_idx) JOIN t2 ON (t1.pk_col1 = t2.pk_col2)
WHERE t1.a1 > 'a';

let $QID= `SELECT CONNECTION_ID()`;
let $point= before_join_exec;
let $err=0;

let $query= $query1;

let $query= $query2;

let $query= $query3;

let $query= $query4;

let $query= $query5;

let $query= $query6;

let $query= $query7;

let $query= $query8;

let $query= $query9;

DROP TABLE t1, t2;

CREATE TABLE t1 (v3 INT, KEY(v3));
CREATE view v1 AS SELECT v3  FROM t1 FORCE KEY (v3) GROUP BY v3;

let query1= select * from v1;

DROP VIEW v1;
DROP TABLE t1;
