DROP TABLE IF EXISTS t1, t2;
CREATE TABLE t2 (
 id_t2 mediumint unsigned NOT NULL default '0',
 id_t1 mediumint unsigned NOT NULL default '0',
 field_number tinyint unsigned NOT NULL default '0',
 PRIMARY KEY (id_t2,id_t1,field_number),
 KEY id_t1(id_t1)
) ENGINE=MyISAM;
INSERT INTO t2 VALUES (2231626,64280,0);
INSERT INTO t2 VALUES (2231626,64281,0);
INSERT INTO t2 VALUES (12346, 3, 1);
SELECT * FROM t2;
