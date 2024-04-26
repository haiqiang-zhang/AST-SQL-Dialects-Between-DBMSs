
create user test_nopw;
create user test_newpw identified by "newpw";

select user(), current_user(), database();
select concat('<', user(), '>'), concat('<', current_user(), '>'), database();
   

change_user test_nopw;
select concat('<', user(), '>'), concat('<', current_user(), '>'), database();
select concat('<', user(), '>'), concat('<', current_user(), '>'), database();
select concat('<', user(), '>'), concat('<', current_user(), '>'), database();
select concat('<', user(), '>'), concat('<', current_user(), '>'), database();
select concat('<', user(), '>'), concat('<', current_user(), '>'), database();
select concat('<', user(), '>'), concat('<', current_user(), '>'), database();

drop user test_nopw;
drop user test_newpw;

--
-- Bug#20023 mysql_change_user() resets the value of SQL_BIG_SELECTS
--

--echo Bug--20023
SELECT @@session.sql_big_selects;
SELECT @@global.max_join_size;
SELECT @@session.sql_big_selects;
SELECT @@global.max_join_size;
SET @@global.max_join_size = 10000;
SET @@session.max_join_size = default;
SELECT @@session.sql_big_selects;
SET @@global.max_join_size = 18446744073709551615;
SET @@session.max_join_size = default;
SELECT @@session.sql_big_selects;

--
-- Bug #18329348 Bug #18329560 Bug #18328396 Bug #18329452 mysql_change_user()
-- resets all SESSION ONLY system variables
--

SET INSERT_ID=12;
SELECT @@INSERT_ID;
SET TIMESTAMP=200;
SELECT @@TIMESTAMP;
SELECT @@INSERT_ID;
SELECT @@TIMESTAMP=200;

--
-- Bug#31418 User locks misfunctioning after mysql_change_user()
--

--echo Bug--31418
SELECT IS_FREE_LOCK('bug31418');
SELECT IS_USED_LOCK('bug31418');
SELECT GET_LOCK('bug31418', 1);
SELECT IS_USED_LOCK('bug31418') = CONNECTION_ID();
SELECT IS_FREE_LOCK('bug31418');
SELECT IS_USED_LOCK('bug31418');

--
-- Bug#31222: com_% global status counters behave randomly with
-- mysql_change_user.
--

FLUSH STATUS;

let $i = 100;
{
  dec $i;

  SELECT 1;

let $before= query_get_value(SHOW GLOBAL STATUS LIKE 'com_select',Value,1);

let $after= query_get_value(SHOW GLOBAL STATUS LIKE 'com_select',Value,1);

if ($after != $before){
  SHOW GLOBAL STATUS LIKE 'com_select';
  die The value of com_select changed during change_user;
