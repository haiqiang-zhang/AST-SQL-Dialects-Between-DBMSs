--                                                                             #
-- Test: To compare Explain vs Explain Other plans of RQG queries              #
--                                                                             #
--                                                                             #
-- Creation Date: 2012-12-15                                                   #
-- Author : Tarique Saleem                                                     #
--                                                                             #
--                                                                             #
-- Description:This test contains Explain vs Explain Other plans on different  #
--             queries generated from RQG optimizer grammaers. Some distinct   #
--             have been taken from the differences cases reported.            #
--                                                                             #               
--             1. Sync Point used                                              #
--		SELECT       : before_reset_query_plan                        #
--               INSERT       : planned_single_insert                          #
--             	INSERT-SELECT: before_reset_query_plan                        #
--               UPDATE       : planned_single_update(NOT ALL QUERIES ARE HIT) #               
--               DELETE       : planned_single_delete(NOT ALL QUERIES ARE HIT) #                                                                      # 
--                                                                             #
--##############################################################################

--source include/not_hypergraph.inc  -- Non-traditional formats differ in hypergraph.

-- Skipping the test when binlog_format=STATEMENT due to unsafe statements:
-- unsafe usage of auto-increment column, LIMIT clause.
--source include/not_binlog_format_statement.inc

--###################################################################################################################
--   Checking if the build is Debug build else skip the test because debug sync points are avilable in Debug build  #
--###################################################################################################################

 echo "WL6369 Explain for Connection";

  let $format=traditional;
