CREATE TABLE t1 (
  id bigint NOT NULL AUTO_INCREMENT,
  time date,
  id2 bigint not null,
  PRIMARY KEY (id,time)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb3;
INSERT INTO t1 (time,id2) VALUES ('2011-07-24',1);
INSERT INTO t1 (time,id2) VALUES ('2011-07-25',1);
INSERT INTO t1 (time,id2) VALUES ('2011-07-25',1);
