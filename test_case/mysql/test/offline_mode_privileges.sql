
SET @original_offline_mode = @@global.offline_mode;
CREATE USER base@localhost IDENTIFIED BY 'base';
CREATE USER regular@localhost IDENTIFIED BY 'regular';
CREATE USER power@localhost IDENTIFIED BY 'power';
CREATE USER super@localhost IDENTIFIED BY 'super';
CREATE USER admin@localhost IDENTIFIED BY 'admin';
CREATE USER superadmin@localhost IDENTIFIED BY 'superadmin';
CREATE USER sysadmin@localhost IDENTIFIED BY 'sysadmin';
SET GLOBAL OFFLINE_MODE=ON;
SET GLOBAL OFFLINE_MODE=ON;
SET GLOBAL OFFLINE_MODE=ON;
SET GLOBAL OFFLINE_MODE=ON;
SET GLOBAL OFFLINE_MODE=OFF;
SET GLOBAL OFFLINE_MODE=ON;
SET GLOBAL OFFLINE_MODE=OFF;

--# Cleanup
--echo
--echo -- CLEAN UP
--echo
connection default;
DROP USER base@localhost;
DROP USER regular@localhost;
DROP USER power@localhost;
DROP USER super@localhost;
DROP USER admin@localhost;
DROP USER superadmin@localhost;
DROP USER sysadmin@localhost;
SET @@global.offline_mode = @original_offline_mode;
