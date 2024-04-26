
-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

--echo -- FR 1.2, FR 2.2 Test a user with password history checks off

CREATE USER no_pwd_history@localhost
  PASSWORD HISTORY 0 PASSWORD REUSE INTERVAL 0 DAY;
SELECT Password_reuse_history, Password_reuse_time
  FROM mysql.user
  WHERE Host='localhost' AND User='no_pwd_history';
SELECT COUNT(*) FROM mysql.password_history WHERE
  User='no_pwd_history' AND Host='localhost';

SET PASSWORD FOR no_pwd_history@localhost = 'changeme';
SELECT COUNT(*) FROM mysql.password_history WHERE
  User='no_pwd_history' AND Host='localhost';

ALTER USER no_pwd_history@localhost IDENTIFIED BY 'changemeagain';
SELECT COUNT(*) FROM mysql.password_history WHERE
User='no_pwd_history' AND Host='localhost';

-- 4.1 hash of 'hihi'
ALTER USER no_pwd_history@localhost IDENTIFIED WITH "mysql_native_password"
  AS '*C40F578E1A9D8D1146AFD04AFCB0228EED9D45FB';
SELECT COUNT(*) FROM mysql.password_history WHERE
  User='no_pwd_history' AND Host='localhost';
SELECT COUNT(*) FROM mysql.password_history WHERE
  User='no_pwd_history' AND Host='localhost';
SET GLOBAL password_history= 1;
SET PASSWORD FOR no_pwd_history@localhost = 'tracked';
SELECT COUNT(*) FROM mysql.password_history WHERE
  User='no_pwd_history' AND Host='localhost';
SET PASSWORD FOR no_pwd_history@localhost = 'tracked';
SELECT COUNT(*) FROM mysql.password_history WHERE
  User='no_pwd_history' AND Host='localhost';

SET GLOBAL password_history= default;
SET GLOBAL password_reuse_interval= 100;
SET PASSWORD FOR no_pwd_history@localhost = 'tracked';
SELECT COUNT(*) FROM mysql.password_history WHERE
  User='no_pwd_history' AND Host='localhost';
SET PASSWORD FOR no_pwd_history@localhost = 'tracked';
SELECT COUNT(*) FROM mysql.password_history WHERE
  User='no_pwd_history' AND Host='localhost';
SELECT Password_reuse_history, Password_reuse_time FROM mysql.user
  WHERE User='no_pwd_history' AND Host='localhost';

SET GLOBAL password_reuse_interval= DEFAULT;
DROP USER no_pwd_history@localhost;
CREATE USER default_def@localhost IDENTIFIED BY 'haha';
SELECT Password_reuse_history, Password_reuse_time FROM mysql.user
  WHERE User='default_def' AND Host='localhost';
SELECT COUNT(*) FROM mysql.password_history WHERE
  User='default_def' AND Host='localhost';
SET GLOBAL password_history=1;
ALTER USER default_def@localhost IDENTIFIED BY 'haha';
SELECT COUNT(*) FROM mysql.password_history WHERE
  User='default_def' AND Host='localhost';
ALTER USER default_def@localhost IDENTIFIED BY 'haha';

SET GLOBAL password_history=default;
ALTER USER default_def@localhost IDENTIFIED BY 'haha';
SELECT COUNT(*) FROM mysql.password_history WHERE
  User='default_def' AND Host='localhost';
SET GLOBAL password_history=1;
ALTER USER default_def@localhost IDENTIFIED BY 'haha';
SELECT COUNT(*) FROM mysql.password_history WHERE
  User='default_def' AND Host='localhost';

DROP USER default_def@localhost;
SELECT COUNT(*) FROM mysql.password_history WHERE
  User='default_def' AND Host='localhost';

SET GLOBAL password_history=default;
SET GLOBAL password_history=1;

CREATE USER method_alter@localhost IDENTIFIED BY 'haha';
SELECT COUNT(*) FROM mysql.password_history WHERE
  User='method_alter' AND Host='localhost';
SELECT COUNT(*) FROM mysql.password_history, mysql.user WHERE
  mysql.user.User='method_alter' AND mysql.user.host='localhost' AND
  mysql.user.User=mysql.password_history.user AND
  mysql.user.host=mysql.password_history.host;

ALTER USER method_alter@localhost IDENTIFIED WITH 'sha256_password';
SELECT COUNT(*) FROM mysql.password_history WHERE
  User='method_alter' AND Host='localhost';

DROP USER method_alter@localhost;
SET GLOBAL password_history=default;
CREATE USER to_be_renamed@localhost IDENTIFIED BY 'haha' PASSWORD HISTORY 1;
SELECT COUNT(*) FROM mysql.password_history WHERE
  User='to_be_renamed' AND Host='localhost';
SELECT COUNT(*) FROM mysql.password_history WHERE
  User='to_be_renamed' AND Host='localhost';
SELECT COUNT(*) FROM mysql.password_history WHERE
  User='now_renamed' AND Host='localhost';
SET PASSWORD FOR now_renamed@localhost = 'haha';
DELETE FROM mysql.password_history WHERE
  User='now_renamed' AND Host='localhost';
SET PASSWORD FOR now_renamed@localhost = 'haha';
SELECT COUNT(*) FROM mysql.password_history WHERE
  User='now_renamed' AND Host='localhost';

DROP USER now_renamed@localhost;

CREATE USER no_pwd_history@localhost IDENTIFIED BY 'haha';
CREATE USER no_pwd_history_err@localhost IDENTIFIED BY 'haha'
  PASSWORD HISTORY 0 PASSWORD REUSE INTERVAL 0 DAY;
SET PASSWORD FOR no_pwd_history@localhost = 'hehe';
ALTER USER no_pwd_history@localhost IDENTIFIED BY 'hihi';
ALTER USER no_pwd_history@localhost IDENTIFIED WITH 'sha256_password';
DROP USER no_pwd_history@localhost;

DROP USER no_pwd_history@localhost;
CREATE USER dup_history@localhost IDENTIFIED BY 'haha'
  PASSWORD HISTORY 1 PASSWORD HISTORY DEFAULT;
SELECT COUNT(*) FROM mysql.password_history WHERE
  User='dup_history' AND Host='localhost';

DROP USER dup_history@localhost;
CREATE USER dup_interval@localhost IDENTIFIED BY 'haha'
  PASSWORD REUSE INTERVAL 10 DAY PASSWORD REUSE INTERVAL DEFAULT;
SELECT COUNT(*) FROM mysql.password_history WHERE
  User='dup_interval' AND Host='localhost';

DROP USER dup_interval@localhost;

CREATE USER empty_pwd@localhost IDENTIFIED BY ''
  PASSWORD HISTORY 1;
SELECT COUNT(*) FROM mysql.password_history WHERE
  User='empty_pwd' AND Host='localhost';
SET PASSWORD FOR empty_pwd@localhost = '';
SELECT COUNT(*) FROM mysql.password_history WHERE
  User='empty_pwd' AND Host='localhost';

DROP USER empty_pwd@localhost;
SET SESSION password_reuse_interval= 0;

SET GLOBAL password_history=0;
SET GLOBAL password_reuse_interval=1;
CREATE USER def_interval@localhost IDENTIFIED BY 'haha';
SELECT COUNT(*) FROM mysql.password_history WHERE
  User='def_interval' AND Host='localhost';
SET PASSWORD FOR def_interval@localhost = 'haha';
UPDATE mysql.password_history
  SET Password_timestamp = TIMESTAMPADD(DAY, -1, Password_timestamp)
  WHERE User='def_interval' AND Host='localhost';
SET PASSWORD FOR def_interval@localhost = 'haha';
SELECT COUNT(*) FROM mysql.password_history WHERE
  User='def_interval' AND Host='localhost' AND
  TO_DAYS(Password_timestamp)=TO_DAYS(NOW());

SET PASSWORD FOR def_interval@localhost = 'hihi';
SELECT COUNT(*) FROM mysql.password_history WHERE
  User='def_interval' AND Host='localhost' AND
  TO_DAYS(Password_timestamp)=TO_DAYS(NOW());
UPDATE mysql.password_history
  SET Password_timestamp = TIMESTAMPADD(MONTH, -1, Password_timestamp)
  WHERE User='def_interval' AND Host='localhost';
SET PASSWORD FOR def_interval@localhost = 'hoho';
SELECT COUNT(*) FROM mysql.password_history WHERE
  User='def_interval' AND Host='localhost' AND
  TO_DAYS(Password_timestamp)=TO_DAYS(NOW());

SET GLOBAL password_reuse_interval = default;
DROP USER def_interval@localhost;
SET GLOBAL password_history=5;
SET GLOBAL password_reuse_interval=5;
CREATE USER mohit@localhost IDENTIFIED BY 'mohit'
  PASSWORD HISTORY 1 PASSWORD REUSE INTERVAL 2 DAY;
ALTER USER mohit@localhost IDENTIFIED BY 'mohit';
ALTER USER mohit@localhost IDENTIFIED BY 'mohit1';

DROP USER mohit@localhost;

SET GLOBAL password_reuse_interval= default;

CREATE USER mohit@localhost IDENTIFIED BY 'mohit' PASSWORD HISTORY 1;
SELECT COUNT(*) FROM mysql.password_history WHERE
  User='mohit' AND Host='localhost';
ALTER USER mohit@localhost IDENTIFIED BY 'mohit';
ALTER USER mohit@localhost IDENTIFIED BY 'mohit1';
SELECT COUNT(*) FROM mysql.password_history WHERE
  User='mohit' AND Host='localhost';
ALTER USER mohit@localhost IDENTIFIED BY 'mohit';

DROP USER mohit@localhost;
SET GLOBAL password_history= default;
SET GLOBAL password_reuse_interval= default;

CREATE USER mohit@localhost
  IDENTIFIED WITH sha256_password BY 'mohit' PASSWORD HISTORY 1;
SELECT COUNT(*) FROM mysql.password_history WHERE
  User='mohit' AND Host='localhost';
CREATE TABLE pwd_history_backup AS
  SELECT * FROM mysql.password_history
    WHERE User='mohit' AND Host='localhost';
ALTER USER mohit@localhost IDENTIFIED WITH mysql_native_password BY 'mohit';
SELECT COUNT(*) FROM mysql.password_history WHERE
  User='mohit' AND Host='localhost';
UPDATE mysql.password_history
  SET Password=(
                SELECT Password FROM pwd_history_backup
                WHERE User='mohit' AND Host='localhost')
  WHERE User='mohit' AND Host='localhost';
ALTER USER mohit@localhost IDENTIFIED WITH mysql_native_password BY 'mohit';

DROP TABLE pwd_history_backup;
DROP USER mohit@localhost;

CREATE USER mohit_sha@localhost IDENTIFIED WITH sha256_password BY 'mohit_sha'
  PASSWORD HISTORY 1;
ALTER USER mohit_sha@localhost IDENTIFIED BY 'mohit_sha';
ALTER USER mohit_sha@localhost IDENTIFIED BY 'mohit_sha2';

DROP USER mohit_sha@localhost;

SET GLOBAL password_history=0;
SET GLOBAL password_reuse_interval= 1;

CREATE USER amar@localhost IDENTIFIED BY 'amar'
  PASSWORD REUSE INTERVAL 1 DAY;
SELECT COUNT(*) FROM mysql.password_history WHERE
  User='amar' AND Host='localhost';
ALTER USER amar@localhost IDENTIFIED BY 'amar';
SELECT COUNT(*) FROM mysql.password_history WHERE
  User='amar' AND Host='localhost';

DROP USER amar@localhost;
SET GLOBAL password_history=default;
SET GLOBAL password_reuse_interval=default;

CREATE USER mohit_sha@localhost IDENTIFIED WITH caching_sha2_password BY 'mohit_sha'
  PASSWORD HISTORY 1;
ALTER USER mohit_sha@localhost IDENTIFIED BY 'mohit_sha';
ALTER USER mohit_sha@localhost IDENTIFIED BY 'mohit_sha2';

ALTER USER mohit_sha@localhost PASSWORD HISTORY 2;
ALTER USER mohit_sha@localhost IDENTIFIED BY 'mohit_sha';
ALTER USER mohit_sha@localhost IDENTIFIED BY 'mohit_sha';
ALTER USER mohit_sha@localhost IDENTIFIED BY 'mohit_sha2';
ALTER USER mohit_sha@localhost IDENTIFIED BY 'mohit_sha3';

DROP USER mohit_sha@localhost;
