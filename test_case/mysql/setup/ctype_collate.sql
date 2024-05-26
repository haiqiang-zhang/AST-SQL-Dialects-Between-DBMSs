DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
CREATE TABLE t1 (
  latin1_f CHAR(32) NOT NULL
) charset latin1;
INSERT INTO t1 (latin1_f) VALUES (_latin1'A');
INSERT INTO t1 (latin1_f) VALUES (_latin1'a');
INSERT INTO t1 (latin1_f) VALUES (_latin1'AD');
INSERT INTO t1 (latin1_f) VALUES (_latin1'ad');
INSERT INTO t1 (latin1_f) VALUES (_latin1'AE');
INSERT INTO t1 (latin1_f) VALUES (_latin1'ae');
INSERT INTO t1 (latin1_f) VALUES (_latin1'AF');
INSERT INTO t1 (latin1_f) VALUES (_latin1'af');
INSERT INTO t1 (latin1_f) VALUES (_latin1'B');
INSERT INTO t1 (latin1_f) VALUES (_latin1'b');
INSERT INTO t1 (latin1_f) VALUES (_latin1'U');
INSERT INTO t1 (latin1_f) VALUES (_latin1'u');
INSERT INTO t1 (latin1_f) VALUES (_latin1'UE');
INSERT INTO t1 (latin1_f) VALUES (_latin1'ue');
INSERT INTO t1 (latin1_f) VALUES (_latin1'SS');
INSERT INTO t1 (latin1_f) VALUES (_latin1'ss');
INSERT INTO t1 (latin1_f) VALUES (_latin1'Y');
INSERT INTO t1 (latin1_f) VALUES (_latin1'y');
INSERT INTO t1 (latin1_f) VALUES (_latin1'Z');
INSERT INTO t1 (latin1_f) VALUES (_latin1'z');
