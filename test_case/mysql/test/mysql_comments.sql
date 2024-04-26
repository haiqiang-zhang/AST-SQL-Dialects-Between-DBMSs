--                                                                      #
-- Testing of comments handling by the command line client (mysql)      #
--                                                                      #
-- Creation:                                                            #
-- 2007-10-29 akopytov Implemented this test as a part of fixes for     #
--                     bug #26215 and bug #11230                        #
--                                                                      #
--#######################################################################

--
-- Bug #11230: Keeping comments when storing stored procedures
--

-- See the content of mysql_comments.sql
-- Set the test database to a known state before running the tests.
--disable_warnings
drop table if exists t1;
drop function if exists foofct;
drop procedure if exists `empty`;
drop procedure if exists foosp;
drop procedure if exists nicesp;
drop trigger if exists t1_empty;
drop trigger if exists t1_bi;
