

-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

-- Bug#8471 IP address with mask fail when skip-name-resolve is on
CREATE USER mysqltest_1@'127.0.0.1/255.255.255.255';
DROP USER mysqltest_1@'127.0.0.1/255.255.255.255';

-- End of 4.1 tests

-- Bug#13407 Remote connecting crashes server
-- Server crashed when one used USER() function in connection for which
-- was impossible to obtain peer hostname.

--source include/add_extra_root_users.inc

connect (con1, localhost, root, , test, $MASTER_MYPORT, );
SELECT USER();

-- Wait till all disconnects are completed
--source include/wait_until_count_sessions.inc

-- Restore original content of mysql.user
--source include/remove_extra_root_users.inc

--echo --
--echo -- Bug #37168: Missing variable - skip_name_resolve
--echo --

SHOW VARIABLES LIKE 'skip_name_resolve';

SELECT @@skip_name_resolve;
SELECT @@LOCAL.skip_name_resolve;
SELECT @@GLOBAL.skip_name_resolve;
SET @@skip_name_resolve=0;
SET @@LOCAL.skip_name_resolve=0;
SET @@GLOBAL.skip_name_resolve=0;

CREATE USER b20438524@'%' IDENTIFIED BY 'pwd';
UPDATE mysql.user SET host='localhost1' WHERE user='b20438524';
DELETE FROM mysql.user WHERE user='b20438524';

CREATE USER b20438524@'%' IDENTIFIED BY 'pwd';
UPDATE mysql.user SET host='localhost' WHERE user='b20438524';

DELETE FROM mysql.user WHERE user='b20438524';
