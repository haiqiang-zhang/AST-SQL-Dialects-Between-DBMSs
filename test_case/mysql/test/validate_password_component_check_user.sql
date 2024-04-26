
-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

INSTALL COMPONENT "file://component_validate_password";

-- check the default for validate_password.check_user_name
SELECT @@global.validate_password.check_user_name;
SET @@session.validate_password.check_user_name= ON;
SET validate_password.check_user_name= ON;

-- turn other policies off so they don't stand in the way
SET @@global.validate_password.policy=LOW;
SET @@global.validate_password.mixed_case_count=0;
SET @@global.validate_password.number_count=0;
SET @@global.validate_password.special_char_count=0;
SET @@global.validate_password.length=0;


-- check_user_name=ON tests. No need to check with off since it's covered.
SET @@global.validate_password.check_user_name= ON;
CREATE USER "base_user"@localhost IDENTIFIED BY 'base_user';
SET PASSWORD FOR "base_user"@localhost = 'base_user';
ALTER USER "base_user"@localhost IDENTIFIED BY 'base_user';
CREATE USER foo@localhost IDENTIFIED BY 'root';
SELECT VALIDATE_PASSWORD_STRENGTH('root') = 0;
SELECT VALIDATE_PASSWORD_STRENGTH('toor') = 0;
SELECT VALIDATE_PASSWORD_STRENGTH('Root') <> 0;
SELECT VALIDATE_PASSWORD_STRENGTH('Toor') <> 0;
SELECT VALIDATE_PASSWORD_STRENGTH('fooHoHo%1') <> 0;
SET PASSWORD='base_user';
SET PASSWORD='base_User';
ALTER USER "base_user"@localhost IDENTIFIED BY 'base_user';
SELECT VALIDATE_PASSWORD_STRENGTH('base_user') = 0;
SELECT VALIDATE_PASSWORD_STRENGTH('resu_esab') = 0;
SET PASSWORD='';
DROP USER "base_user"@localhost;

-- echo -- test effective user name
CREATE USER ""@localhost;
SELECT USER(),CURRENT_USER();
SELECT VALIDATE_PASSWORD_STRENGTH('login_user') = 0;
SELECT VALIDATE_PASSWORD_STRENGTH('resu_nigol') = 0;
DROP USER ""@localhost;

SET @@global.validate_password.policy=default;
SET @@global.validate_password.length=default;
SET @@global.validate_password.mixed_case_count=default;
SET @@global.validate_password.number_count=default;
SET @@global.validate_password.special_char_count=default;
SET @@global.validate_password.check_user_name= default;
