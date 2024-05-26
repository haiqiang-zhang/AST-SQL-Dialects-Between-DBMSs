drop table if exists t1;
create table t1(n1 int, n2 int, s char(20), vs varchar(20), t text);
insert into t1 values (1,11, 'one','eleven', 'eleven'),
 (1,11, 'one','eleven', 'eleven'),
 (2,11, 'two','eleven', 'eleven'),
 (2,12, 'two','twevle', 'twelve'),
 (2,13, 'two','thirteen', 'foo'),
 (2,13, 'two','thirteen', 'foo'),
 (2,13, 'two','thirteen', 'bar'),
 (NULL,13, 'two','thirteen', 'bar'),
 (2,NULL, 'two','thirteen', 'bar'),
 (2,13, NULL,'thirteen', 'bar'),
 (2,13, 'two',NULL, 'bar'),
 (2,13, 'two','thirteen', NULL);
