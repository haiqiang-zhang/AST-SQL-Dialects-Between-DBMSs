
--
-- Test of multiple key caches
--
--disable_warnings
drop table if exists t1, t2, t3;

SET @save_key_buffer=@@key_buffer_size;

SELECT @@key_buffer_size, @@small.key_buffer_size;

-- Change default key cache size
SET @@global.key_buffer_size=16*1024*1024;
SET @@global.default.key_buffer_size=16*1024*1024;
SET @@global.default.key_buffer_size=16*1024*1024;

SET @@global.small.key_buffer_size=1*1024*1024;
SET @@global.medium.key_buffer_size=4*1024*1024;
SET @@global.medium.key_buffer_size=0;
SET @@global.medium.key_buffer_size=0;

-- Print key buffer with different syntaxes
SHOW VARIABLES like "key_buffer_size";
SELECT @@key_buffer_size;
SELECT @@global.key_buffer_size;
SELECT @@global.default.key_buffer_size;
SELECT @@global.default.`key_buffer_size`;
SELECT @@global.`default`.`key_buffer_size`;
SELECT @@`default`.key_buffer_size;

SELECT @@small.key_buffer_size;
SELECT @@medium.key_buffer_size;

SET @@global.key_buffer_size=@save_key_buffer;

--
-- Errors
--

--error 1064
SELECT @@default.key_buffer_size;
SELECT @@skr.default_storage_engine="test";

select @@keycache1.key_cache_block_size;
select @@keycache1.key_buffer_size;
set global keycache1.key_cache_block_size=2048;
select @@keycache1.key_buffer_size;
select @@keycache1.key_cache_block_size;
set global keycache1.key_buffer_size=1*1024*1024;
select @@keycache1.key_buffer_size;
select @@keycache1.key_cache_block_size;
set global keycache2.key_buffer_size=4*1024*1024;
select @@keycache2.key_buffer_size;
select @@keycache2.key_cache_block_size;
set global keycache1.key_buffer_size=0;
select @@keycache1.key_buffer_size;
select @@keycache1.key_cache_block_size;
select @@key_buffer_size;
select @@key_cache_block_size;

set global keycache1.key_buffer_size=1024*1024;

create table t1 (p int primary key, a char(10)) delay_key_write=1;
create table t2 (p int primary key, i int, a char(10), key k1(i), key k2(a));

-- Following results differs on 64 and 32 bit systems because of different
-- pointer sizes, which takes up different amount of space in key cache

--replace_result 1812 KEY_BLOCKS_UNUSED 1793 KEY_BLOCKS_UNUSED 1674 KEY_BLOCKS_UNUSED 1818 KEY_BLOCKS_UNUSED 1824 KEY_BLOCKS_UNUSED
show status like 'key_blocks_unused';

insert into t1 values (1, 'qqqq'), (11, 'yyyy');
insert into t2 values (1, 1, 'qqqq'), (2, 1, 'pppp'),
                      (3, 1, 'yyyy'), (4, 3, 'zzzz');
select * from t1;
select * from t2;

update t1 set p=2 where p=1;
update t2 set i=2 where i=1;
select p from t1;
select i from t2;
select count(*) from t1, t2 where t1.p = t2.i;
update t2 set p=p+1000, i=2 where a='qqqq';
insert into t2 values (2000, 3, 'yyyy');
update t2 set p=3000 where a='zzzz';
select * from t2;
select p from t2;
select i from t2;
select a from t2;

-- Test some error conditions
--error 1284
cache index t1 in unknown_key_cache;

select @@keycache2.key_buffer_size;
select @@keycache2.key_cache_block_size;
set global keycache2.key_buffer_size=0;
select @@keycache2.key_buffer_size;
select @@keycache2.key_cache_block_size;
set global keycache2.key_buffer_size=1024*1024;
select @@keycache2.key_buffer_size;

update t2 set p=4000 where a='zzzz';
update t1 set p=p+1;

set global keycache1.key_buffer_size=0;
select * from t2;
select p from t2;
select i from t2;
select a from t2;
select * from t1;
select p from t1;

-- Use the 'small' key cache
create table t3 (like t1);
insert into t3 select * from t1;
drop table t1,t2,t3;

create table t1 (a int primary key);
insert t1 values (1),(2),(3),(4),(5),(6),(7),(8);
set global keycache2.key_buffer_size=0;
select * from t1;
drop table t1;

-- Test to set up a too small size for a key cache (bug #2064)
set global keycache3.key_buffer_size=100;
set global keycache3.key_buffer_size=0;

-- Test case for bug 6447

create table t1 (mytext text, FULLTEXT (mytext));
insert t1 values ('aaabbb');
set @my_key_cache_block_size= @@global.key_cache_block_size;
set GLOBAL key_cache_block_size=2048;
drop table t1;
set global key_cache_block_size= @my_key_cache_block_size;

--
-- Bug #19079: corrupted index when key_cache_block_size is not multiple of
--             myisam_block_size

CREATE TABLE t1(a int NOT NULL AUTO_INCREMENT PRIMARY KEY);
SET @my_key_cache_block_size= @@global.key_cache_block_size;
SET GLOBAL key_cache_block_size=1536;
INSERT INTO t1 VALUES (1);
SELECT @@key_cache_block_size;
DROP TABLE t1;

CREATE TABLE t1(a int NOT NULL AUTO_INCREMENT PRIMARY KEY, b int);
CREATE TABLE t2(a int NOT NULL AUTO_INCREMENT PRIMARY KEY, b int);
SET GLOBAL key_cache_block_size=1536;
INSERT INTO t1 VALUES (1,0);
INSERT INTO t2(b) SELECT b FROM t1;
INSERT INTO t1(b) SELECT b FROM t2;
INSERT INTO t2(b) SELECT b FROM t1;
INSERT INTO t1(b) SELECT b FROM t2;
INSERT INTO t2(b) SELECT b FROM t1;
INSERT INTO t1(b) SELECT b FROM t2;
INSERT INTO t2(b) SELECT b FROM t1;
INSERT INTO t1(b) SELECT b FROM t2;
INSERT INTO t2(b) SELECT b FROM t1;
INSERT INTO t1(b) SELECT b FROM t2;
INSERT INTO t2(b) SELECT b FROM t1;
INSERT INTO t1(b) SELECT b FROM t2;
INSERT INTO t2(b) SELECT b FROM t1;
INSERT INTO t1(b) SELECT b FROM t2;
INSERT INTO t2(b) SELECT b FROM t1;
INSERT INTO t1(b) SELECT b FROM t2;
INSERT INTO t2(b) SELECT b FROM t1;
INSERT INTO t1(b) SELECT b FROM t2;
SELECT COUNT(*) FROM t1;
SELECT @@key_cache_block_size;
DROP TABLE t1,t2;
set global key_cache_block_size= @my_key_cache_block_size;

--
-- Bug#10473 - Cannot set 'key_buffer_size' system variable to ZERO
-- (One cannot drop the default key cache.)
--
--error ER_WARN_CANT_DROP_DEFAULT_KEYCACHE
set @@global.key_buffer_size=0;
select @@global.key_buffer_size;

--
-- Bug#28478 - Improper key_cache_block_size corrupts MyISAM tables
--
SET @bug28478_key_cache_block_size= @@global.key_cache_block_size;
SET GLOBAL key_cache_block_size= 1536;
CREATE TABLE t1 (
  id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  c1 CHAR(83),
  c2 CHAR(83),
  c3 CHAR(83),
  KEY(c1, c2, c3)
  ) ENGINE= MyISAM DEFAULT CHARSET utf8mb4;
INSERT INTO t1 (c1, c2, c3) VALUES
  ('a', 'b', 'c'), ('b', 'c', 'd'), ('c', 'd', 'e'), ('d', 'e', 'f'),
  ('e', 'f', 'g'), ('f', 'g', 'h'), ('g', 'h', 'i'), ('h', 'i', 'j'),
  ('i', 'j', 'k'), ('j', 'k', 'l'), ('k', 'l', 'm'), ('l', 'm', 'n'),
  ('m', 'n', 'o'), ('n', 'o', 'p'), ('o', 'p', 'q'), ('p', 'q', 'r'),
  ('q', 'r', 's'), ('r', 's', 't'), ('s', 't', 'u'), ('t', 'u', 'v'),
  ('u', 'v', 'w'), ('v', 'w', 'x'), ('w', 'x', 'y'), ('x', 'y', 'z');
INSERT INTO t1 (c1, c2, c3) SELECT c1, c2, c3 from t1;
INSERT INTO t1 (c1, c2, c3) SELECT c1, c2, c3 from t1;
INSERT INTO t1 (c1, c2, c3) SELECT c1, c2, c3 from t1;
SET GLOBAL key_cache_block_size= @bug28478_key_cache_block_size;
DROP TABLE t1;

-- End of 4.1 tests

--echo --
--echo -- Bug#12361113: crash when load index into cache
--echo --

--echo -- Note that this creates an empty disabled key cache!
SET GLOBAL key_cache_none.key_cache_block_size = 1024;
CREATE TABLE t1 (a INT, b INTEGER NOT NULL, KEY (b) ) ENGINE = MYISAM;
INSERT INTO t1 VALUES (1, 1);
DROP TABLE t1;
