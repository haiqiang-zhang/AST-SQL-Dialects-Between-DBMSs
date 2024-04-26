--

-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

call mtr.add_suppression('Can not read and process value of User_attributes column from mysql.user table for user');

CREATE USER foo@localhost IDENTIFIED BY 'foo';
SELECT user_attributes FROM mysql.user WHERE user='foo';

UPDATE mysql.user SET user_attributes='{"Password_locking": {"failed_login_attempts": 2, "password_lock_time_days": 2}}' WHERE user='foo';

SELECT user_attributes FROM mysql.user WHERE user='foo';

DROP USER foo@localhost;
CREATE USER foo@localhost IDENTIFIED BY 'foo' FAILED_LOGIN_ATTEMPTS 4 PASSWORD_LOCK_TIME 6;
SELECT user_attributes FROM mysql.user WHERE user='foo';
ALTER USER foo@localhost FAILED_LOGIN_ATTEMPTS 2;
SELECT user_attributes FROM mysql.user WHERE user='foo';
ALTER USER foo@localhost PASSWORD_LOCK_TIME 3;
SELECT user_attributes FROM mysql.user WHERE user='foo';

ALTER USER foo@localhost IDENTIFIED BY 'foo';
ALTER USER foo@localhost ACCOUNT UNLOCK;

CREATE USER bar@localhost IDENTIFIED BY 'bar';

-- Cleanup
connection default;

-- Wait till all disconnects are completed
--source include/wait_until_count_sessions.inc

DROP USER foo@localhost;
DROP USER bar@localhost;

CREATE USER foo@localhost FAILED_LOGIN_ATTEMPTS 2 PASSWORD_LOCK_TIME 3;
CREATE USER failed_login_attempts@localhost FAILED_LOGIN_ATTEMPTS 2;
CREATE USER password_lock_time@localhost PASSWORD_LOCK_TIME 3;
DROP USER foo@localhost;
DROP USER foo@localhost, failed_login_attempts@localhost, password_lock_time@localhost;

CREATE USER foo@localhost IDENTIFIED BY 'foo' FAILED_LOGIN_ATTEMPTS 2 PASSWORD_LOCK_TIME 3;

ALTER USER foo@localhost FAILED_LOGIN_ATTEMPTS 0;

ALTER USER foo@localhost FAILED_LOGIN_ATTEMPTS 2 PASSWORD_LOCK_TIME 0;

DROP USER foo@localhost;

CREATE USER foo@localhost IDENTIFIED BY 'foo' FAILED_LOGIN_ATTEMPTS 2 PASSWORD_LOCK_TIME 3;

ALTER USER foo@localhost FAILED_LOGIN_ATTEMPTS 2;

ALTER USER foo@localhost PASSWORD_LOCK_TIME 3;

DROP USER foo@localhost;

CREATE USER foo@localhost IDENTIFIED BY 'foo' FAILED_LOGIN_ATTEMPTS 2 PASSWORD_LOCK_TIME 3;

DROP USER foo@localhost;

CREATE USER foo@localhost;
UPDATE mysql.user SET user_attributes='{"Password_locking": 1}' WHERE user='foo';
SELECT user,host,user_attributes FROM mysql.user WHERE user='foo';
UPDATE mysql.user SET user_attributes='{"Password_locking": {"failed_login_attempts": -2, "password_lock_time_days": 2}}' WHERE user='foo';
UPDATE mysql.user SET user_attributes='{"Password_locking": {"failed_login_attempts": 2, "password_lock_time_days": -2}}' WHERE user='foo';
UPDATE mysql.user SET user_attributes='{"Password_locking": {"failed_login_attempts": "2", "password_lock_time_days": 2}}' WHERE user='foo';
UPDATE mysql.user SET user_attributes='{"Password_locking": {"failed_login_attempts": 2, "password_lock_time_days": "2"}}' WHERE user='foo';
UPDATE mysql.user SET user_attributes='{"Password_locking": {"password_lock_time_days": 2}}' WHERE user='foo';
UPDATE mysql.user SET user_attributes='{"Password_locking": {"failed_login_attempts": 2}}' WHERE user='foo';
UPDATE mysql.user SET user_attributes=NULL WHERE user='foo';
DROP USER foo@localhost;

CREATE USER foo@localhost IDENTIFIED BY 'foo' FAILED_LOGIN_ATTEMPTS 2 PASSWORD_LOCK_TIME 3 ACCOUNT LOCK;

DROP USER foo@localhost;

SET GLOBAL check_proxy_users = ON;
SET GLOBAL mysql_native_password_proxy_users = ON;
CREATE USER proxied_to_user@localhost IDENTIFIED WITH 'mysql_native_password' FAILED_LOGIN_ATTEMPTS 2 PASSWORD_LOCK_TIME 3;
CREATE USER proxy_user@localhost IDENTIFIED WITH 'mysql_native_password' FAILED_LOGIN_ATTEMPTS 2 PASSWORD_LOCK_TIME 3;
SELECT USER(), CURRENT_USER(), @@session.proxy_user;
DROP USER proxied_to_user@localhost, proxy_user@localhost;
SET GLOBAL check_proxy_users = DEFAULT;
SET GLOBAL mysql_native_password_proxy_users = DEFAULT;

CREATE USER foo@localhost IDENTIFIED BY 'foo' FAILED_LOGIN_ATTEMPTS 2 PASSWORD_LOCK_TIME 2;

ALTER USER foo@localhost ACCOUNT UNLOCK;

DROP USER foo@localhost;

SET GLOBAL partial_revokes=1;
CREATE USER u1 identified by 'pwd';
SELECT user_attributes FROM mysql.user WHERE USER = 'u1';
ALTER USER u1 FAILED_LOGIN_ATTEMPTS 2 PASSWORD_LOCK_TIME 3;
SELECT user_attributes FROM mysql.user WHERE USER = 'u1';
ALTER USER u1 FAILED_LOGIN_ATTEMPTS 0 PASSWORD_LOCK_TIME 0;
SELECT user_attributes FROM mysql.user WHERE USER = 'u1';
DROP USER u1;
SET GLOBAL partial_revokes=DEFAULT;
CREATE USER foo@localhost FAILED_LOGIN_ATTEMPTS -1;
CREATE USER goo@localhost FAILED_LOGIN_ATTEMPTS 32768;

CREATE USER foo@localhost FAILED_LOGIN_ATTEMPTS 32767;
DROP USER foo@localhost;
CREATE USER foo@localhost PASSWORD_LOCK_TIME -1;
CREATE USER goo@localhost PASSWORD_LOCK_TIME 32768;

CREATE USER foo@localhost PASSWORD_LOCK_TIME 32767;
DROP USER foo@localhost;

CREATE USER ''@localhost IDENTIFIED BY 'pwd' FAILED_LOGIN_ATTEMPTS 2 PASSWORD_LOCK_TIME 3;

DROP USER ''@localhost;
CREATE USER foo@localhost IDENTIFIED BY 'foo' PASSWORD_LOCK_TIME 3 FAILED_LOGIN_ATTEMPTS 2;
ALTER USER foo@localhost ATTRIBUTE "{ \"test\": \"account locking\" }";
ALTER USER foo@localhost COMMENT "This is a test account for verifying that password locking and user attributes won't interfer with one and another.";

SELECT user_attributes FROM mysql.user WHERE user='foo';

ALTER USER foo@localhost ACCOUNT UNLOCK;
SELECT user_attributes FROM mysql.user WHERE user='foo';

DROP USER foo@localhost;
