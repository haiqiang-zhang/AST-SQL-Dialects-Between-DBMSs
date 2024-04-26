
--
-- Test for bug by voi@ims.at
--

--disable_warnings
drop table if exists test;
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
CREATE TABLE test (
  gnr INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  url VARCHAR(80) DEFAULT '' NOT NULL,
  shortdesc VARCHAR(200) DEFAULT '' NOT NULL,
  longdesc text DEFAULT '' NOT NULL,
  description VARCHAR(80) DEFAULT '' NOT NULL,
  name VARCHAR(80) DEFAULT '' NOT NULL,
  FULLTEXT(url,description,shortdesc,longdesc),
  PRIMARY KEY(gnr)
);
SET sql_mode = default;
insert into test (url,shortdesc,longdesc,description,name) VALUES 
("http:/test.at", "kurz", "lang","desc", "name");
insert into test (url,shortdesc,longdesc,description,name) VALUES 
("http:/test.at", "kurz", "","desc", "name");
update test set url='test', description='ddd', name='nam' where gnr=2;
update test set url='test', shortdesc='ggg', longdesc='mmm', 
description='ddd', name='nam' where gnr=2;
drop table test;
