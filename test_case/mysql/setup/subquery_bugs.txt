CREATE TABLE t1 (
  pk int NOT NULL,
  col_int_key int DEFAULT NULL,
  col_int int DEFAULT NULL,
  col_varchar varchar(1) DEFAULT NULL,
  PRIMARY KEY (pk),
  KEY col_int_key (col_int_key)
);
INSERT INTO t1 VALUES (10,7,5,'l'), (12,7,4,'o');
CREATE TABLE t2 (
  col_date_key date DEFAULT NULL,
  col_datetime_key datetime DEFAULT NULL,
  col_int_key int(11) DEFAULT NULL,
  col_varchar_key varchar(1) DEFAULT NULL,
  col_varchar varchar(1) DEFAULT NULL,
  col_time time DEFAULT NULL,
  pk int NOT NULL,
  col_date date DEFAULT NULL,
  col_time_key time DEFAULT NULL,
  col_datetime datetime DEFAULT NULL,
  col_int int DEFAULT NULL,
  PRIMARY KEY (pk),
  KEY col_date_key (col_date_key),
  KEY col_datetime_key (col_datetime_key),
  KEY col_int_key (col_int_key),
  KEY col_varchar_key (col_varchar_key),
  KEY col_time_key (col_time_key)
);
INSERT INTO t2(col_int_key,col_varchar_key,col_varchar,pk,col_int)  VALUES
 (8,'a','w',1,5),
 (9,'y','f',7,0),
 (9,'z','i',11,9),
 (9,'r','s',12,3),
 (7,'n','i',13,6),
 (9,'j','v',17,9),
 (240,'u','k',20,6);
CREATE TABLE t3 (
  col_int int DEFAULT NULL,
  col_int_key int(11) DEFAULT NULL,
  pk int NOT NULL,
  PRIMARY KEY (pk),
  KEY col_int_key (col_int_key)
);
INSERT INTO t3 VALUES (8,4,1);
