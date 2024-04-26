--


--source include/have_debug.inc

call mtr.add_suppression('Can not read and process value of User_attributes column from mysql.user table for user');

CREATE USER foo@localhost IDENTIFIED BY 'foo' FAILED_LOGIN_ATTEMPTS 2 PASSWORD_LOCK_TIME 3;

SET GLOBAL DEBUG = '+d,account_lock_daynr_add_one';

SET GLOBAL DEBUG = '-d,account_lock_daynr_add_one';

SET GLOBAL DEBUG = '+d,account_lock_daynr_add_ten';

SET GLOBAL DEBUG = '-d,account_lock_daynr_add_ten';

DROP USER foo@localhost;

CREATE USER foo@localhost IDENTIFIED BY 'foo' FAILED_LOGIN_ATTEMPTS 2 PASSWORD_LOCK_TIME UNBOUNDED;

SET GLOBAL DEBUG = '+d,account_lock_daynr_add_ten';

SET GLOBAL DEBUG = '-d,account_lock_daynr_add_ten';

DROP USER foo@localhost;
