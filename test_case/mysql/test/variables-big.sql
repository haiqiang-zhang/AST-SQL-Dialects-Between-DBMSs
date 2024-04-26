--

--source include/big_test.inc

--
-- Bug#27322 failure to allocate transaction_prealloc_size causes crash
--
--
-- Manual (5.1):
-- Platform Bit Size  Range                      Default
-- 32/64              1024-128k                  4096
--
-- Observation(mleich):
-- 1. - Linux 64 Bit, MySQL 64 Bit, 4 GiB RAM, 8 GiB swap
--    - SET SESSION transaction_prealloc_size=1099511627776;
--      SHOW PROCESSLIST;
--      Id   User ... Info
--      <Id> root ... SHOW PROCESSLIST
--      SELECT @@session.transaction_prealloc_size;
--      @@session.transaction_prealloc_size
--      1099511627776
--      very short runtime in 5.0
--      excessive resource consumption + long runtime in 5.1 and 6.0
-- 2. - Win in VM, slightly older version of this test, MySQL 5.0
--    - testcase timeout after 900s
--      analyze-timeout-mysqld.1.err :
--      Id User ... Time Info
--      83 root ... 542  set session transaction_prealloc_size=1024*1024*1024*2
--      84 root ... 1    SHOW PROCESSLIST
--
-- There is a significant probablitity that this tests fails with testcase
-- timeout if the testing box is not powerful enough.
--
SET @def_var= @@session.transaction_prealloc_size;
SET SESSION transaction_prealloc_size=1024*1024*1024*1;
SET SESSION transaction_prealloc_size=1024*1024*1024*2;
SET SESSION transaction_prealloc_size=1024*1024*1024*3;
SET SESSION transaction_prealloc_size=1024*1024*1024*4;
SET SESSION transaction_prealloc_size=1024*1024*1024*5;

SET @@session.transaction_prealloc_size= @def_var;
