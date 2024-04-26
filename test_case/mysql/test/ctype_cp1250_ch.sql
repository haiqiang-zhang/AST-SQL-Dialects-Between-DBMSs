drop table if exists t1;
DROP TABLE IF EXISTS t1;

SET @test_character_set= 'cp1250';
SET @test_collation= 'cp1250_general_ci';

SET @test_character_set= 'cp1250';
SET @test_collation= 'cp1250_czech_cs';



--
-- Bugs: #8840: Empty string comparison and character set 'cp1250'
--

CREATE TABLE t1 (a char(16)) character set cp1250 collate cp1250_czech_cs;
INSERT INTO t1 VALUES ('');
SELECT a, length(a), a='', a=' ', a='  ' FROM t1;
DROP TABLE t1;

--
-- Bug#9759 Empty result with 'LIKE' and cp1250_czech_cs
--
CREATE TABLE t1 (
  popisek varchar(30) collate cp1250_general_ci NOT NULL default '',
 PRIMARY KEY  (`popisek`)
);
INSERT INTO t1 VALUES ('2005-01-1');
SELECT * FROM t1 WHERE popisek = '2005-01-1';
SELECT * FROM t1 WHERE popisek LIKE '2005-01-1';
drop table t1;

--
-- Bug#13347: empty result from query with like and cp1250 charset
--
set names cp1250;
CREATE TABLE t1
(
 id  INT AUTO_INCREMENT PRIMARY KEY,
 str VARCHAR(32)  CHARACTER SET cp1250 COLLATE cp1250_czech_cs NOT NULL default '',
 UNIQUE KEY (str)
);
			
INSERT INTO t1 VALUES (NULL, 'a');
INSERT INTO t1 VALUES (NULL, 'aa');
INSERT INTO t1 VALUES (NULL, 'aaa');
INSERT INTO t1 VALUES (NULL, 'aaaa');
INSERT INTO t1 VALUES (NULL, 'aaaaa');
INSERT INTO t1 VALUES (NULL, 'aaaaaa');
INSERT INTO t1 VALUES (NULL, 'aaaaaaa');
select * from t1 where str like 'aa%';
drop table t1;

--
-- Bug#19741 segfault with cp1250 charset + like + primary key + 64bit os
--
set names cp1250;
create table t1 (a varchar(15) collate cp1250_czech_cs NOT NULL, primary key(a));
insert into t1 values("abcdefgh�");
insert into t1 values("����");
select a from t1 where a like "abcdefgh�";
drop table t1;

set names cp1250 collate cp1250_czech_cs;

-- End of 4.1 tests

--
-- Bug #48053 String::c_ptr has a race and/or does an invalid 
--            memory reference
--            (triggered by Valgrind tests)
--  (see also ctype_eucjpms.test, ctype_cp1250.test, ctype_cp1251.test)
--
--error 1649
set global LC_MESSAGES=convert((@@global.log_bin_trust_function_creators) 
    using cp1250);

set names cp1250 collate cp1250_czech_cs;

SET NAMES cp1250;