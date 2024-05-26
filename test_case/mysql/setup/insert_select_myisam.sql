CREATE TABLE t1(
 Month date NOT NULL,
 Type tinyint(3) unsigned NOT NULL auto_increment,
 Field int(10) unsigned NOT NULL,
 Count int(10) unsigned NOT NULL,
 UNIQUE KEY Month (Month,Type,Field)
)engine=myisam;
insert into t1 Values
(20030901, 1, 1, 100),
(20030901, 1, 2, 100),
(20030901, 2, 1, 100),
(20030901, 2, 2, 100),
(20030901, 3, 1, 100);
