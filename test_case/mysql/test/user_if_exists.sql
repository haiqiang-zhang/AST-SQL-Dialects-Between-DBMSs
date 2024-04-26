
-- cleanup
DELETE FROM mysql.user WHERE user = 'wl8540';

SELECT COUNT(*) FROM mysql.user WHERE user = 'wl8540';
CREATE USER wl8540@host1;
SELECT COUNT(*) FROM mysql.user WHERE user = 'wl8540';
CREATE USER wl8540@host1;
CREATE USER IF NOT EXISTS wl8540@host1;
SELECT COUNT(*) FROM mysql.user WHERE user = 'wl8540';
CREATE USER IF NOT EXISTS wl8540@host1, wl8540@host2;
SELECT COUNT(*) FROM mysql.user WHERE user = 'wl8540';
CREATE USER IF NOT EXISTS wl8540@host1, wl8540@host2;
SELECT COUNT(*) FROM mysql.user WHERE user = 'wl8540';

SELECT COUNT(*) FROM mysql.user WHERE user = 'wl8540' AND account_locked = 'Y';
ALTER USER wl8540@host3 ACCOUNT LOCK;
SELECT COUNT(*) FROM mysql.user WHERE user = 'wl8540' AND account_locked = 'Y';
ALTER USER IF EXISTS wl8540@host3, wl8540@host4, wl8540@host1 ACCOUNT LOCK;
SELECT COUNT(*) FROM mysql.user WHERE user = 'wl8540' AND account_locked = 'Y';
ALTER USER IF EXISTS wl8540@host2 ACCOUNT LOCK;
SELECT COUNT(*) FROM mysql.user WHERE user = 'wl8540' AND account_locked = 'Y';

SELECT COUNT(*) FROM mysql.user WHERE user = 'wl8540';
DROP USER wl8540@host3;
SELECT COUNT(*) FROM mysql.user WHERE user = 'wl8540';
DROP USER IF EXISTS wl8540@host3;
SELECT COUNT(*) FROM mysql.user WHERE user = 'wl8540';
DROP USER IF EXISTS wl8540@host3,wl8540@host2,wl8540@host4;
SELECT COUNT(*) FROM mysql.user WHERE user = 'wl8540';

-- No users exist:

DROP USER IF EXISTS wl8540@nohost1, wl8540@nohost2;
SELECT COUNT(*) FROM mysql.user WHERE user = 'wl8540';
ALTER USER IF EXISTS wl8540@nohost1, wl8540@nohost2 ACCOUNT LOCK;
SELECT COUNT(*) FROM mysql.user WHERE user = 'wl8540';
CREATE USER IF NOT EXISTS wl8540@nohost1, wl8540@nohost2;
SELECT COUNT(*) FROM mysql.user WHERE user = 'wl8540';

-- All users exist:

ALTER USER IF EXISTS wl8540@nohost1, wl8540@nohost2 ACCOUNT LOCK;
SELECT COUNT(*) FROM mysql.user WHERE user = 'wl8540';
CREATE USER IF NOT EXISTS wl8540@nohost1, wl8540@nohost2;
SELECT COUNT(*) FROM mysql.user WHERE user = 'wl8540';
DROP USER IF EXISTS wl8540@nohost1, wl8540@nohost2;
SELECT COUNT(*) FROM mysql.user WHERE user = 'wl8540';

CREATE USER wl8540@nohost1;

-- One of two users exist:

DROP USER IF EXISTS wl8540@nohost1, wl8540@nohost2;
SELECT COUNT(*) FROM mysql.user WHERE user = 'wl8540';
ALTER USER IF EXISTS wl8540@nohost1, wl8540@nohost2 ACCOUNT LOCK;
SELECT COUNT(*) FROM mysql.user WHERE user = 'wl8540';
CREATE USER IF NOT EXISTS wl8540@nohost1, wl8540@nohost2;
SELECT COUNT(*) FROM mysql.user WHERE user = 'wl8540';

-- cleanup
DELETE FROM mysql.user WHERE user = 'wl8540';

-- CRAETE USER IF NOT EXISTS , ALTER USER IF EXISTS testing
-- with --log-row=off (By default it's OFF).

--
--echo
CREATE USER user1@localhost
            IDENTIFIED WITH 'mysql_native_password' BY 'auth_string--%y';

CREATE USER IF NOT EXISTS user2@localhost
            IDENTIFIED WITH 'mysql_native_password'
            AS '*67092806AE91BFB6BE72DE6C7BE2B7CCA8CFA9DF';

CREATE USER IF NOT EXISTS user2@localhost
            IDENTIFIED WITH 'sha256_password';

ALTER USER IF EXISTS user2@localhost
IDENTIFIED WITH 'mysql_native_password'
            AS '*67092806AE91BFB6BE72DE6C7BE2B7CCA8CFA9DF';

-- CREATE USER IF NOT EXISTS statements with plain-text passwords will work
CREATE USER IF NOT EXISTS user1@localhost
            IDENTIFIED WITH 'mysql_native_password' BY 'auth_string--%y';

-- Operation CREATE USER works but triggers a warning
CREATE USER IF NOT EXISTS ne_user1@localhost,user1@localhost
            IDENTIFIED WITH 'mysql_native_password' BY 'auth_string';

-- Operation ALTER USER works with a password too
ALTER USER IF EXISTS ne_user2@localhost
            IDENTIFIED WITH 'mysql_native_password' BY 'auth_string--%y';
ALTER USER IF EXISTS user1@localhost,ne_user3@localhost
            IDENTIFIED WITH 'mysql_native_password' BY 'auth_string--%y';

-- Cleanup
DROP USER IF EXISTS user1@localhost,user2@localhost,ne_user1@localhost,
                    ne_user2@localhost,ne_user3@localhost;

-- Write file to make mysql-test-run.pl wait for the server to stop.
let $expect_file= $MYSQLTEST_VARDIR/tmp/mysqld.1.expect;

-- Request shutdown
--send_shutdown
----sleep 1
-- Call script that will poll the server waiting for it to disapear
--source include/wait_until_disconnected.inc

--echo -- Restart server.
--exec echo "restart:--log-raw=ON " > $expect_file

-- Turn on reconnect
--enable_reconnect

-- Call script that will poll the server waiting for it to be back online again
--source include/wait_until_connected_again.inc

-- CREATE USER IF NOT EXISTS statements with plain-text passwords should not
-- trigger an error if the user does exist and --log_raw=ON.
CREATE USER user1@localhost
            IDENTIFIED WITH 'mysql_native_password';

CREATE USER IF NOT EXISTS user2@localhost
            IDENTIFIED WITH 'mysql_native_password'
            AS '*67092806AE91BFB6BE72DE6C7BE2B7CCA8CFA9DF';

CREATE USER IF NOT EXISTS user1@localhost
            IDENTIFIED WITH 'mysql_native_password' BY 'auth_string--%y';

CREATE USER IF NOT EXISTS ne_user1@localhost,user1@localhost
            IDENTIFIED WITH 'mysql_native_password' BY 'auth_string';

-- ALTER USER IF EXISTS statements with plain-text passwords should not trigger
-- an error if the user does not exist and --log_raw=ON
ALTER USER IF EXISTS ne_user2@localhost
            IDENTIFIED WITH 'mysql_native_password' BY 'auth_string--%y';
ALTER USER IF EXISTS user1@localhost,ne_user3@localhost
            IDENTIFIED WITH 'mysql_native_password' BY 'auth_string--%y';

-- Cleanup
DROP USER IF EXISTS user1@localhost,user2@localhost,ne_user1@localhost,
                    ne_user2@localhost,ne_user3@localhost;

-- restore --log-raw option
let $restart_parameters = restart:;

CREATE USER IF NOT EXISTS b21807286@localhost IDENTIFIED BY 'xyz';
CREATE USER IF NOT EXISTS b21807286@localhost IDENTIFIED BY 'xyz';
DROP USER b21807286@localhost;
ALTER USER IF EXISTS b21807286@localhost IDENTIFIED BY 'xyz';

SET GLOBAL password_history = 5;
CREATE USER IF NOT EXISTS b34906592@localhost IDENTIFIED BY 'password';
SELECT User,Host FROM mysql.password_history WHERE User = 'b34906592';
CREATE USER IF NOT EXISTS b34906592@localhost IDENTIFIED BY 'password';
SELECT User,Host FROM mysql.password_history WHERE User = 'b34906592';
DROP USER b34906592@localhost;
SET GLOBAL password_history = default;
