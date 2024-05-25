CREATE TABLE t1 (
  ID CHAR(32) NOT NULL,
  name CHAR(32) NOT NULL,
  value CHAR(255),
  INDEX indexIDname (ID(8),name(8))
);
INSERT INTO t1 VALUES
('keyword','indexdir','/export/home/local/www/database/indexes/keyword');
INSERT INTO t1 VALUES ('keyword','urlprefix','text/ /text');
INSERT INTO t1 VALUES ('keyword','urlmap','/text/ /');
INSERT INTO t1 VALUES ('keyword','attr','personal employee company');
INSERT INTO t1 VALUES
('emailgids','indexdir','/export/home/local/www/database/indexes/emailgids');
INSERT INTO t1 VALUES ('emailgids','urlprefix','text/ /text');
INSERT INTO t1 VALUES ('emailgids','urlmap','/text/ /');
INSERT INTO t1 VALUES ('emailgids','attr','personal employee company');
