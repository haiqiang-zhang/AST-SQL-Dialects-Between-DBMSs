
SET @original_offline_mode = @@global.offline_mode;
create user regular@localhost identified by 'regular';
create user power@localhost identified by 'power';
create user super@localhost identified by 'super';
create user sysadmin@localhost identified by 'sysadmin';
SET GLOBAL OFFLINE_MODE=ON;
SELECT USER();
SELECT USER();
SELECT USER();
SELECT USER();
SELECT USER();
SET GLOBAL OFFLINE_MODE=OFF;
SET GLOBAL OFFLINE_MODE=ON;
SELECT USER();
SELECT USER();
SELECT USER();
SELECT USER();

--# Cleanup
--echo
--echo -- CLEAN UP
--echo
connection default;
DROP USER regular@localhost;
DROP USER power@localhost;
DROP USER super@localhost;
DROP USER sysadmin@localhost;
SET @@global.offline_mode = @original_offline_mode;
