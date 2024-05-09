select '------ grant/revoke/drop affects a parallel session test ------'
  as test_sequence;
create database mysqltest;
select current_user();
drop database mysqltest;
prepare stmt3 from ' grant all on test.t1 to drop_user@localhost ';
prepare stmt3 from ' revoke all privileges on test.t1 from 
drop_user@localhost ';
prepare stmt3 from ' drop user drop_user@localhost ';
