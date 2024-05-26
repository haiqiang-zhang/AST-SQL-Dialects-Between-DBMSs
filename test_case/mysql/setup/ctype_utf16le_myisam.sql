CREATE TABLE t1 (
   word VARCHAR(64),
   bar INT(11) DEFAULT 0,
   PRIMARY KEY (word))
   ENGINE=MyISAM
   CHARSET utf16le
   COLLATE utf16le_general_ci;
INSERT INTO t1 (word) VALUES ("aar");
INSERT INTO t1 (word) VALUES ("a");
INSERT INTO t1 (word) VALUES ("aardvar");
INSERT INTO t1 (word) VALUES ("aardvark");
INSERT INTO t1 (word) VALUES ("aardvara");
INSERT INTO t1 (word) VALUES ("aardvarz");
