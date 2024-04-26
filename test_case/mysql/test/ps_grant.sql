let $type= 'MYISAM' ;
select '------ grant/revoke/drop affects a parallel session test ------'
  as test_sequence ;
--  Here we test that:
--  1. A new GRANT will be visible within another sessions.            #
--                                                                     #
--  Let's assume there is a parallel session with an already prepared  #
--  statement for a table.                                             #
--  A DROP TABLE will affect the EXECUTE properties.                   #
--  A REVOKE will affect the EXECUTE properties.                       #
-----------------------------------------------------------------------#

-- Who am I ?
-- this is different across different systems:
-- select current_user(), user() ;
--# There should be no grants for that non existing user
--error 1141
show grants for second_user@localhost ;
--# create a new user account by using GRANT statements on t9
create database mysqltest;
use mysqltest;
use test;
create user second_user@localhost
identified by 'looser' ;
--# switch to the second session
connection con3;
select current_user();
--# check the access rights
--sorted_result
show grants for current_user();
                                 from t9 where c1= 1' ;
select a as my_col from t1;
--# switch back to the first session
connection default;
drop table mysqltest.t9 ;
--# switch to the second session
connection con3;
--# switch back to the first session
connection default;
--# switch to the second session
connection con3;

--# cleanup
--# switch back to the first session
connection default;
--# disconnect the second session
disconnect con3 ;
--# remove all rights of second_user@localhost
revoke all privileges, grant option from second_user@localhost ;
drop user second_user@localhost ;

drop database mysqltest;

-- End of 4.1 tests

--
-- grant/revoke + drop user
--
create user drop_user@localhost identified by 'looser';
drop user drop_user@localhost;
