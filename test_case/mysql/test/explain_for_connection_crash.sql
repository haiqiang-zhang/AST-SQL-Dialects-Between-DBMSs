--                                                                             #
-- Crash in compare Explain vs Explain Other plans                             #
--                                                                             #
--                                                                             #
-- Creation Date: 2013-Jan-02                                                  #
-- Author : Tarique Saleem                                                     #
--                                                                             #
-- 									      #
--##############################################################################


-- Bug#16077396 : CRASH ON OPT_EXPLAIN_JSON_NAMESPACE::JOIN_CTX::ADD_SUBQUERY IN OPT_EXPLAIN_JSON.

--###################################################################################################################
--   Checking if the build is Debug build else skip the test because debug sync points are avilable in Debug build  #
--###################################################################################################################

--source include/not_hypergraph.inc  -- Non-traditional formats differ in hypergraph.

 echo "WL6369 Explain for Connection";
  let $format=json;
  SET GLOBAL innodb_stats_persistent=on;
  let $point=   before_reset_query_plan;


-- Bug#16077396 : CRASH ON OPT_EXPLAIN_JSON_NAMESPACE::JOIN_CTX::ADD_SUBQUERY IN OPT_EXPLAIN_JSON.


  create table t1 (a int, c int) ;
  insert into t1 values (1, 2), (2, 3), (2, 4), (3, 5) ;
  create table t2 (a int, c int) ;
  insert into t2 values (1, 5), (2, 4), (3, 3), (3,3) ;
  let $point=   before_reset_query_plan;
  drop table t1,t2;

  CREATE TABLE t1 (a VARCHAR(10), FULLTEXT KEY a (a)) ;
  INSERT INTO t1 VALUES (1),(2) ;
  CREATE TABLE t2 (b INT) ;
  INSERT INTO t2 VALUES (1),(2) ;
  let $point=   before_reset_query_plan;
  DROP TABLE t1,t2 ;


-- Bug# 16078113 : CRASH ON EXPLAIN_FORMAT_JSON::BEGIN_CONTEXT IN OPT_EXPLAIN_JSON.CC

  let $point=   before_reset_query_plan;
