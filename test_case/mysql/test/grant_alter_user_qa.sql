--                                                                                     #
-- Test for WL#6409                                                                    #
-- Created : 2014-12-15                                                                #
-- Modified: 2014-02-02  WL#6054                                                       #
-- Author  : Lalit Choudhary                                                           #
--######################################################################################

-- Save the initial number of concurrent sessions
--source include/count_sessions.inc
--source include/have_plugin_auth.inc
--source include/have_log_bin.inc
--echo --
--echo -- WL#6409: CREATE/ALTER USER
--echo --

call mtr.add_suppression("\\[Warning\\] \\[[^]]*\\] Server shutdown in progress");

-- Official builds include separate debug enabled plugins to be used by
-- the debug enabled server. But the non-debug *client* should not use them.

let PLUGIN_AUTH_OPT=`SELECT TRIM(TRAILING '/debug' FROM '$PLUGIN_AUTH_OPT')`;
CREATE USER user1;
CREATE USER user3@%;

-- Sequence of the attributes. provide password first and auth_plugin later on
--error ER_PARSE_ERROR
CREATE USER user3@localhost BY 'auth_string' WITH 'sha_256_password';

CREATE USER "user2"@'%';

-- IDENTIFIED WITH 'mysql_native_password' AS with plaintest
--error ER_PASSWORD_FORMAT
CREATE USER user9@localhost IDENTIFIED WITH 'mysql_native_password' AS 'auth_string';
CREATE USER user10@localhost
            IDENTIFIED WITH 'caching_sha2_password' AS '$A$005$ABCDEFGHIJKLMNOPQRSTabcdefgh01234567ijklmnop89012345ABCDEFGH678';
CREATE USER u1@localhost;

CREATE USER u2@localhost IDENTIFIED BY 'auth_string';
CREATE USER user5@localhost IDENTIFIED  AS 'auth_string';

CREATE USER u3@localhost IDENTIFIED WITH 'sha256_password';

CREATE USER u4@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string';

-- Testing connection
--connect(con1, localhost, u4,'auth_string',,,,SSL)
SELECT USER();
CREATE USER user4@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string';
CREATE USER user6@localhost IDENTIFIED WITH 'mysql_native_password';
CREATE USER user7@localhost
            IDENTIFIED WITH 'mysql_native_password' BY 'auth_string--%y';
SELECT USER();

CREATE USER user8@localhost
            IDENTIFIED WITH 'mysql_native_password'
            AS '*67092806AE91BFB6BE72DE6C7BE2B7CCA8CFA9DF'
            PASSWORD EXPIRE NEVER;

-- Testing connection
--connect(con1, localhost, user8,'auth_string')
SELECT USER();
CREATE USER tu1@localhost IDENTIFIED WITH 'test_plugin_server';

CREATE USER tu2@localhost IDENTIFIED WITH 'test_plugin_server'
            BY 'auth_@13*' PASSWORD EXPIRE;
CREATE USER tu3@localhost IDENTIFIED WITH 'test_plugin_server' AS '%auth_O0s-tring';
CREATE USER u5@localhost REQUIRE SSL;

CREATE USER u6@localhost IDENTIFIED BY 'auth_string' REQUIRE X509;

CREATE USER tu4@localhost IDENTIFIED WITH 'test_plugin_server' BY 'djgsj743$'
                          REQUIRE SSL;

CREATE USER tu5@localhost IDENTIFIED WITH 'test_plugin_server' AS 'dwh@--ghd$!'
                          REQUIRE X509;

CREATE USER u7@localhost IDENTIFIED WITH 'sha256_password' REQUIRE CIPHER 'cipher';

CREATE USER u8@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string'
REQUIRE ISSUER '/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=CA'
PASSWORD EXPIRE NEVER;

-- Testing connection
--connect(con1, localhost, u8,'auth_string',,,,SSL)
SELECT USER();

CREATE USER u9@localhost REQUIRE SUBJECT 'sub';

CREATE USER u10@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string--y'
REQUIRE CIPHER "ECDHE-RSA-AES128-GCM-SHA256" AND
SUBJECT "/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=Client"
ISSUER "/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=CA"
PASSWORD EXPIRE DEFAULT;

-- Testing connection
--connect(con1, localhost, u10,'auth_string--y',,,,SSL)
SELECT USER();

CREATE USER tu6@localhost IDENTIFIED WITH 'test_plugin_server' AS '--hGrt0O6'
REQUIRE CIPHER "ECDHE-RSA-AES128-GCM-SHA256" AND
SUBJECT "/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=Client"
ISSUER "/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=CA"
WITH MAX_QUERIES_PER_HOUR 2 MAX_USER_CONNECTIONS 2;

CREATE USER u11@localhost WITH MAX_QUERIES_PER_HOUR 2;

CREATE USER u12@localhost IDENTIFIED BY 'auth_string'
                          WITH MAX_QUERIES_PER_HOUR 2 PASSWORD EXPIRE NEVER;

CREATE USER u13@localhost IDENTIFIED WITH 'sha256_password'
                          WITH MAX_CONNECTIONS_PER_HOUR 2;

CREATE USER u14@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string'
                          WITH MAX_USER_CONNECTIONS 2  PASSWORD EXPIRE INTERVAL 999 DAY;

CREATE USER u15@localhost,
            u16@localhost IDENTIFIED BY 'auth_string',
            u17@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string';

CREATE USER u18@localhost,
            u19@localhost IDENTIFIED BY 'auth_string',
            u20@localhost IDENTIFIED WITH 'sha256_password',
            u21@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string',
            u22@localhost IDENTIFIED WITH 'test_plugin_server',
            u23@localhost IDENTIFIED WITH 'mysql_native_password' BY 'auth_&string'
            REQUIRE SUBJECT '/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=Client'
            WITH MAX_QUERIES_PER_HOUR 2 MAX_USER_CONNECTIONS 2;

DROP USER tu1@localhost,tu2@localhost,tu3@localhost,tu4@localhost,tu5@localhost,
          tu6@localhost,user1@'%',user2@'%',user4@localhost,user6@localhost,
          user7@localhost,user8@localhost,user10@localhost,u1@localhost,u2@localhost,
          u3@localhost,u4@localhost,u5@localhost,u6@localhost,u7@localhost,u8@localhost,
          u9@localhost,u10@localhost,u11@localhost,u12@localhost,u13@localhost,
          u14@localhost,u15@localhost,u16@localhost,u17@localhost,u18@localhost,
          u19@localhost,u20@localhost,u21@localhost,u22@localhost,u23@localhost;

CREATE USER u1@localhost;
ALTER USER u1@localhost;

CREATE USER u2@localhost IDENTIFIED WITH 'mysql_native_password';
ALTER USER u2@localhost IDENTIFIED WITH 'mysql_native_password' PASSWORD EXPIRE NEVER;

-- Testing connection
--connect(con1, localhost, u2)
--error ER_MUST_CHANGE_PASSWORD
SELECT USER();
ALTER USER USER() IDENTIFIED BY 'abc';
CREATE USER u3@localhost IDENTIFIED WITH 'sha256_password';

ALTER USER u3@localhost IDENTIFIED WITH 'mysql_native_password'
                        AS '*67092806AE91BFB6BE72DE6C7BE2B7CCA8CFA9DF';

-- Testing connection
--connect(con1, localhost, u3, 'auth_string')
SELECT USER();

ALTER USER u3@localhost IDENTIFIED WITH 'test_plugin_server' BY 'auth_string';

ALTER USER u3@localhost
           REQUIRE SUBJECT '/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=Client'
           WITH MAX_QUERIES_PER_HOUR 2 MAX_USER_CONNECTIONS 2
           PASSWORD EXPIRE NEVER;

CREATE USER u4@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string';
ALTER USER u4@localhost IDENTIFIED WITH 'mysql_native_password' BY 'auth_string';

CREATE USER u5@localhost REQUIRE SSL;

ALTER USER u5@localhost IDENTIFIED WITH 'sha256_password';

-- Testing connection
--connect(con1, localhost, u5,,,,,SSL)
SET PASSWORD='new_auth_string';
SELECT USER();

CREATE USER u6@localhost IDENTIFIED BY 'auth_string' REQUIRE X509;
ALTER USER u6@localhost IDENTIFIED WITH 'test_plugin_server'
                        AS 'new_auth_string' REQUIRE SSL;

CREATE USER u7@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string'
                         REQUIRE CIPHER 'ECDHE-RSA-AES128-GCM-SHA256';
ALTER USER u7@localhost IDENTIFIED WITH 'sha256_password' BY 'new_auth_string'
                        REQUIRE ISSUER '/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=CA';

-- Testing connection
--connect(con1, localhost, u7,'new_auth_string',,,,SSL)
SELECT USER();

CREATE USER u8@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string'
                         REQUIRE ISSUER '/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=CA';
ALTER USER u8@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string'
                        REQUIRE CIPHER "ECDHE-RSA-AES128-GCM-SHA256";
SELECT USER();

CREATE USER tu1@localhost IDENTIFIED WITH 'mysql_native_password'
                          BY 'auth_string' REQUIRE ISSUER 'issuer';
ALTER USER tu1@localhost IDENTIFIED WITH 'sha256_password'
                         REQUIRE CIPHER "ECDHE-RSA-AES128-GCM-SHA256";

CREATE USER u9@localhost REQUIRE SUBJECT 'sub';
ALTER USER u9@localhost
           REQUIRE ISSUER "/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=CA";

ALTER USER u9@localhost IDENTIFIED WITH 'test_plugin_server' BY 'auth_string77hg'
                        REQUIRE ISSUER "/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=CA";

CREATE USER u10@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string'
                          REQUIRE CIPHER "ECDHE-RSA-AES128-GCM-SHA256" AND
                          SUBJECT "/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=Client"
                          ISSUER "/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=CA";
ALTER USER u10@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string'
                         REQUIRE SSL;

-- Testing connection
--connect(con1, localhost, u10,'auth_string',,,,SSL)
SELECT USER();

CREATE USER u11@localhost WITH MAX_QUERIES_PER_HOUR 2;
ALTER USER u11@localhost WITH MAX_QUERIES_PER_HOUR 6;

CREATE USER u12@localhost IDENTIFIED BY 'auth_string'
                          WITH MAX_QUERIES_PER_HOUR 2;
ALTER USER u12@localhost IDENTIFIED WITH 'sha256_password'
                         WITH MAX_QUERIES_PER_HOUR 8;

ALTER USER u12@localhost IDENTIFIED WITH 'test_plugin_server'
                         WITH MAX_QUERIES_PER_HOUR 1000;


CREATE USER u13@localhost IDENTIFIED WITH 'sha256_password'
                          WITH MAX_CONNECTIONS_PER_HOUR 2;
ALTER USER u13@localhost PASSWORD EXPIRE;

-- Testing connection
--connect(con1, localhost, u13,,,,,SSL)
--error ER_MUST_CHANGE_PASSWORD
SELECT USER();
ALTER USER USER() IDENTIFIED BY 'new_pwd_string';
SELECT USER();


CREATE USER u14@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string'
                          WITH MAX_USER_CONNECTIONS 2;
ALTER USER u14@localhost WITH MAX_USER_CONNECTIONS 12 PASSWORD EXPIRE INTERVAL 365 DAY;

CREATE USER tu2@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string'
                          WITH MAX_USER_CONNECTIONS 2 ;
ALTER USER tu2@localhost WITH MAX_USER_CONNECTIONS 12 MAX_QUERIES_PER_HOUR 543
                         PASSWORD EXPIRE INTERVAL 365 DAY;

-- Testing connection
--connect(con1, localhost, tu2,'auth_string',,,,SSL)
SELECT USER();

CREATE USER u15@localhost,
            u16@localhost IDENTIFIED WITH 'sha256_password',
            u17@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string';

ALTER USER u15@localhost IDENTIFIED WITH 'sha256_password',
           u16@localhost,
           u17@localhost IDENTIFIED BY 'new_auth_string'
                         PASSWORD EXPIRE DEFAULT;

CREATE USER u18@localhost,
            u19@localhost IDENTIFIED BY 'auth_string',
            u20@localhost IDENTIFIED WITH 'sha256_password',
            u21@localhost IDENTIFIED WITH 'sha256_password' BY '!Y_TOdh6)',
            u22@localhost IDENTIFIED WITH 'sha256_password',
            u23@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_&string'
            REQUIRE SUBJECT '/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=Client'
            WITH MAX_QUERIES_PER_HOUR 2 MAX_USER_CONNECTIONS 2;
ALTER USER u18@localhost,
           u19@localhost,
           u20@localhost,
           u21@localhost,
           u22@localhost,
           u23@localhost
           REQUIRE SUBJECT '/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=Client'
           WITH MAX_QUERIES_PER_HOUR 2 MAX_USER_CONNECTIONS 2
           PASSWORD EXPIRE NEVER;

DROP USER tu1@localhost,tu2@localhost,u1@localhost, u2@localhost, u3@localhost,
          u4@localhost, u5@localhost,u6@localhost, u7@localhost, u8@localhost,
          u9@localhost, u10@localhost,u11@localhost, u12@localhost, u13@localhost,
          u14@localhost,u15@localhost, u16@localhost, u17@localhost, u18@localhost,
          u19@localhost, u20@localhost, u21@localhost,u22@localhost,u23@localhost;

CREATE USER u1@localhost IDENTIFIED BY 'abc';
SELECT USER();
ALTER USER u1@localhost PASSWORD EXPIRE;
SELECT USER();
SET PASSWORD = 'def';
SELECT USER();
ALTER USER u1@localhost PASSWORD EXPIRE;
SELECT USER();
ALTER USER IDENTIFIED BY 'npwd';
ALTER USER USER() IDENTIFIED BY 'abc';
SELECT USER();
ALTER USER u1@localhost PASSWORD EXPIRE;
SELECT USER();
ALTER USER u1@localhost IDENTIFIED BY 'def';
SELECT USER();
DROP USER u1@localhost;

CREATE USER u1@localhost, u2@localhost IDENTIFIED BY 'abc';
ALTER USER USER() IDENTIFIED WITH 'sha256_password';
ALTER USER USER() IDENTIFIED BY 'def', u2@localhost PASSWORD EXPIRE;
ALTER USER USER() IDENTIFIED BY 'def' PASSWORD EXPIRE;
ALTER USER ;
ALTER USER u2@localhost IDENTIFIED BY 'auth_string'
                        PASSWORD EXPIRE INTERVAL 45 DAY;
DROP USER u1@localhost, u2@localhost;

-- Wait till all disconnects are completed
--source include/wait_until_count_sessions.inc

--echo -- SHOW CREATE USER

CREATE USER u1@localhost;

CREATE USER u2@localhost IDENTIFIED BY 'auth_string';
DROP USER u2@localhost;
CREATE USER 'u2'@'localhost' IDENTIFIED WITH 'mysql_native_password'
                             AS '*67092806AE91BFB6BE72DE6C7BE2B7CCA8CFA9DF'
                             REQUIRE NONE;
SELECT USER();

CREATE USER u3@localhost IDENTIFIED WITH 'sha256_password';
ALTER USER u3@localhost IDENTIFIED BY 'auth_string';

CREATE USER u4@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string';


CREATE USER user1@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string';
CREATE USER user2@localhost IDENTIFIED WITH 'mysql_native_password' BY 'auth_string';
CREATE USER u5@localhost REQUIRE SSL;
ALTER USER u5@localhost REQUIRE X509;

CREATE USER u6@localhost IDENTIFIED BY 'auth_string'
                         REQUIRE X509 PASSWORD EXPIRE INTERVAL 5 DAY;

ALTER USER u6@localhost IDENTIFIED BY 'auth_string'
                        REQUIRE X509 PASSWORD EXPIRE INTERVAL 19 DAY;
DROP USER u6@localhost;
CREATE USER 'u6'@'localhost' IDENTIFIED WITH 'mysql_native_password'
                             AS '*67092806AE91BFB6BE72DE6C7BE2B7CCA8CFA9DF'
                             REQUIRE X509 PASSWORD EXPIRE INTERVAL 19 DAY;

CREATE USER u7@localhost IDENTIFIED WITH 'sha256_password'
                         REQUIRE CIPHER 'cipher';

CREATE USER u8@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string'
                         REQUIRE ISSUER 'issuer';

CREATE USER u9@localhost REQUIRE SUBJECT 'sub';

CREATE USER u10@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string'
            REQUIRE CIPHER "ECDHE-RSA-AES128-GCM-SHA256" AND
            SUBJECT "/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=Client"
            ISSUER "/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=CA";

ALTER USER u10@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string'
           REQUIRE CIPHER "ECDHE-RSA-AES128-GCM-SHA256" AND
           SUBJECT "/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=Client"
           ISSUER "/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=CA"
           WITH MAX_CONNECTIONS_PER_HOUR 1000
           MAX_USER_CONNECTIONS 20 MAX_QUERIES_PER_HOUR 60
           MAX_UPDATES_PER_HOUR 100;


CREATE USER u11@localhost WITH MAX_QUERIES_PER_HOUR 2;

CREATE USER u12@localhost IDENTIFIED BY 'auth_string'
                          WITH MAX_QUERIES_PER_HOUR 2;

CREATE USER u13@localhost IDENTIFIED WITH 'sha256_password'
                          WITH MAX_CONNECTIONS_PER_HOUR 2;

CREATE USER u14@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string'
                          WITH MAX_USER_CONNECTIONS 2;

CREATE USER u15@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string'
            REQUIRE SUBJECT '/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=Client'
            ISSUER "/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=CA"
            CIPHER 'cipher' WITH MAX_QUERIES_PER_HOUR 2 MAX_USER_CONNECTIONS 2;

ALTER USER u15@localhost IDENTIFIED WITH 'mysql_native_password' BY 'auth_string'
                         WITH MAX_CONNECTIONS_PER_HOUR 1000
                              MAX_USER_CONNECTIONS 20 MAX_QUERIES_PER_HOUR 60
                              MAX_UPDATES_PER_HOUR 100;
DROP USER u15@localhost;
CREATE USER 'u15'@'localhost' IDENTIFIED WITH 'mysql_native_password'
            AS '*67092806AE91BFB6BE72DE6C7BE2B7CCA8CFA9DF'
            REQUIRE SUBJECT '/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=Client'
            ISSUER '/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=CA'
            CIPHER 'cipher'
            WITH MAX_QUERIES_PER_HOUR 60 MAX_UPDATES_PER_HOUR 100
            MAX_CONNECTIONS_PER_HOUR 1000 MAX_USER_CONNECTIONS 20
            PASSWORD EXPIRE DEFAULT;

DROP USER user1@localhost,u1@localhost, u2@localhost, u3@localhost, u4@localhost,
          u5@localhost,u6@localhost, u7@localhost, u8@localhost, u9@localhost,
          u10@localhost,u11@localhost, u12@localhost, u13@localhost,
          u14@localhost,u15@localhost;

CREATE USER user1@localhost IDENTIFIED WITH 'mysql_native_password'
            AS '*67092806AE91BFB6BE72DE6C7BE2B7CCA8CFA9DF'
            REQUIRE SUBJECT '/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=Client'
            ISSUER "/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=CA"
            WITH MAX_CONNECTIONS_PER_HOUR 1000 MAX_USER_CONNECTIONS 20
                 MAX_QUERIES_PER_HOUR 60 MAX_UPDATES_PER_HOUR 100;

CREATE USER user3@localhost IDENTIFIED BY 'auth_string';
DROP USER user1@localhost,user2@localhost,user3@localhost;
CREATE USER user1@localhost IDENTIFIED BY 'auth_string';
CREATE USER user2@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string1';

SET PASSWORD FOR user1@localhost='auth_xyz@';
SET PASSWORD FOR user2@localhost='gd636@gj';
CREATE USER user4@localhost;
ALTER USER user4@localhost PASSWORD EXPIRE;
SET PASSWORD FOR user4@localhost='';

CREATE USER user3@localhost IDENTIFIED  BY 'auth_string';
CREATE USER user5@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string1';

SET PASSWORD FOR user3@localhost='auth_abc';
SELECT USER();
SET PASSWORD='auth_xyz';
SET PASSWORD FOR user4@localhost='auth_xyz';
SET PASSWORD FOR user5@localhost='auth_dhsga5';


-- Resetting password with a non-ssl connection using mysqladmin,it should throw warning.
GRANT ALL ON *.* TO user4@localhost;
SELECT USER();

-- With ssl connection
--exec $MYSQLADMIN --no-defaults -S $MASTER_MYSOCK -P $MASTER_MYPORT -uuser4 --password=new_auth password new_auth_ssl --ssl-mode=REQUIRED 2>&1

-- Testing connection
--connect(con1, localhost, user4, new_auth_ssl)
SELECT USER();
CREATE USER user6@localhost IDENTIFIED BY 'auth_string';

ALTER USER user6@localhost IDENTIFIED WITH 'sha256_password';

SET PASSWORD FOR user6@localhost='plaintext_password';

-- Testing connection
--connect(con1, localhost, user6, 'plaintext_password',,,,SSL)
SELECT USER();
DROP USER user1@localhost,user2@localhost,user3@localhost,
          user4@localhost,user5@localhost,user6@localhost;

-- Write file to make mysql-test-run.pl wait for the server to stop
let $expect_file= $MYSQLTEST_VARDIR/tmp/mysqld.1.expect;

-- Request shutdown
--send_shutdown

-- Call script that will poll the server waiting for it to disapear
--source include/wait_until_disconnected.inc

--echo -- Restart server.
--exec echo "restart:" > $expect_file

-- Turn on reconnect
--enable_reconnect

-- Call script that will poll the server waiting for it to be back online again
--source include/wait_until_connected_again.inc

SHOW GLOBAL VARIABLES LIKE 'log_bin';

-- Get rid of previous tests binlog
--disable_query_log
reset binary logs and gtids;

CREATE USER u1 IDENTIFIED WITH 'mysql_native_password' BY 'azundris1';
CREATE USER user8@localhost IDENTIFIED WITH 'mysql_native_password'
                            AS '*67092806AE91BFB6BE72DE6C7BE2B7CCA8CFA9DF';
CREATE USER user1@localhost IDENTIFIED WITH 'sha256_password'
                            REQUIRE SSL;
CREATE USER user11@localhost IDENTIFIED WITH 'mysql_native_password'
                             PASSWORD EXPIRE NEVER ACCOUNT LOCK;
CREATE USER user12@localhost IDENTIFIED WITH 'sha256_password'
                             PASSWORD EXPIRE NEVER;

CREATE USER u2@localhost IDENTIFIED BY 'meow';
CREATE USER u10@localhost IDENTIFIED WITH 'sha256_password'
                          REQUIRE CIPHER "ECDHE-RSA-AES128-GCM-SHA256" AND
                          SUBJECT "/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=Client"
                          ISSUER "/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=CA"
                          WITH MAX_QUERIES_PER_HOUR 2 MAX_USER_CONNECTIONS 2;
ALTER USER u10@localhost IDENTIFIED WITH 'mysql_native_password' BY 'auth_string'
                         REQUIRE SSL;
ALTER USER user11@localhost IDENTIFIED WITH 'sha256_password'
                            REQUIRE CIPHER "ECDHE-RSA-AES128-GCM-SHA256" AND
                            SUBJECT "/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=Client"
                            ISSUER "/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=CA"
                            PASSWORD EXPIRE  DEFAULT ACCOUNT UNLOCK;
ALTER USER user12@localhost IDENTIFIED WITH 'mysql_native_password'
                            AS '*67092806AE91BFB6BE72DE6C7BE2B7CCA8CFA9DF'
                            ACCOUNT UNLOCK PASSWORD  EXPIRE INTERVAL 90 DAY;
CREATE USER user13@localhost IDENTIFIED BY 'auth_string' ACCOUNT UNLOCK;
ALTER USER user13@localhost WITH MAX_QUERIES_PER_HOUR 22
                            MAX_USER_CONNECTIONS 4 ACCOUNT LOCK PASSWORD EXPIRE NEVER;
CREATE USER user14@localhost IDENTIFIED WITH 'mysql_native_password' AS '*67092806AE91BFB6BE72DE6C7BE2B7CCA8CFA9DF'
                             ACCOUNT LOCK;
CREATE USER user15@localhost IDENTIFIED WITH 'mysql_native_password' BY 'azundris1'
                             PASSWORD EXPIRE NEVER ACCOUNT UNLOCK;
ALTER USER user15@localhost PASSWORD EXPIRE DEFAULT ACCOUNT LOCK;
CREATE USER user16@localhost IDENTIFIED WITH 'mysql_native_password' AS  '*67092806AE91BFB6BE72DE6C7BE2B7CCA8CFA9DF'
                             ACCOUNT LOCK PASSWORD EXPIRE NEVER;
ALTER USER user16@localhost PASSWORD EXPIRE INTERVAL 10 DAY ACCOUNT LOCK;
SELECT USER();
ALTER USER USER() IDENTIFIED BY 'new-auth';

CREATE USER user10@localhost
            IDENTIFIED WITH 'mysql_native_password' AS '*67092806AE91BFB6BE72DE6C7BE2B7CCA8CFA9DF';

-- Cleanup
DROP USER user1@localhost,user8@localhost,user10@localhost,user11@localhost,
          user12@localhost,user13@localhost,user14@localhost,user15@localhost,
          user16@localhost,u10@localhost,u1,u2@localhost;

-- Make sure we start with a clean slate. log_tables.test says this is OK.
TRUNCATE TABLE mysql.general_log;

SET @old_log_output=    @@global.log_output;
SET @old_general_log=         @@global.general_log;
SET @old_general_log_file=    @@global.general_log_file;

let $general_file_off = $MYSQLTEST_VARDIR/log/create_or_alter_user.log;
SET GLOBAL log_output =       'FILE,TABLE';
SET GLOBAL general_log=       'ON';

CREATE USER u1 IDENTIFIED WITH 'mysql_native_password' BY 'azundris1';
CREATE USER user8@localhost IDENTIFIED WITH 'mysql_native_password'
                            AS '*67092806AE91BFB6BE72DE6C7BE2B7CCA8CFA9DF';
CREATE USER user1@localhost IDENTIFIED WITH 'sha256_password' REQUIRE SSL;
CREATE USER user11@localhost IDENTIFIED WITH 'mysql_native_password'
                             PASSWORD EXPIRE NEVER ACCOUNT LOCK;
CREATE USER user12@localhost IDENTIFIED WITH 'sha256_password'
                             PASSWORD EXPIRE NEVER;

CREATE USER u2@localhost IDENTIFIED BY 'meow';
CREATE USER u10@localhost IDENTIFIED WITH 'sha256_password'
            REQUIRE CIPHER "ECDHE-RSA-AES128-GCM-SHA256" AND
            SUBJECT "/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=Client"
            ISSUER "/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=CA"
            WITH MAX_QUERIES_PER_HOUR 2 MAX_USER_CONNECTIONS 2;
ALTER USER u10@localhost IDENTIFIED WITH 'mysql_native_password' BY 'auth_string'
                         REQUIRE SSL;
ALTER USER user11@localhost IDENTIFIED WITH 'sha256_password'
           REQUIRE CIPHER "ECDHE-RSA-AES128-GCM-SHA256" AND
           SUBJECT "/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=Client"
           ISSUER "/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=CA"
           PASSWORD EXPIRE  DEFAULT ACCOUNT UNLOCK;
ALTER USER user12@localhost IDENTIFIED WITH 'mysql_native_password'
           AS '*67092806AE91BFB6BE72DE6C7BE2B7CCA8CFA9DF'
           ACCOUNT UNLOCK PASSWORD  EXPIRE INTERVAL 90 DAY;
CREATE USER user13@localhost IDENTIFIED BY 'auth_string' ACCOUNT UNLOCK;
ALTER USER user13@localhost WITH MAX_QUERIES_PER_HOUR 22
                            MAX_USER_CONNECTIONS 4 ACCOUNT LOCK PASSWORD EXPIRE NEVER;
CREATE USER user14@localhost IDENTIFIED WITH 'mysql_native_password' AS '*67092806AE91BFB6BE72DE6C7BE2B7CCA8CFA9DF'
                             ACCOUNT LOCK;
CREATE USER user15@localhost IDENTIFIED WITH 'mysql_native_password' BY 'azundris1'
                             PASSWORD EXPIRE NEVER ACCOUNT UNLOCK;
ALTER USER user15@localhost PASSWORD EXPIRE DEFAULT ACCOUNT LOCK;
CREATE USER user16@localhost IDENTIFIED WITH 'mysql_native_password' AS '*67092806AE91BFB6BE72DE6C7BE2B7CCA8CFA9DF'
                             ACCOUNT LOCK PASSWORD EXPIRE NEVER;
ALTER USER user16@localhost PASSWORD EXPIRE INTERVAL 10 DAY ACCOUNT LOCK;
SELECT USER();
ALTER USER USER() IDENTIFIED BY 'new-auth';

CREATE USER user10@localhost IDENTIFIED WITH 'mysql_native_password' AS '*67092806AE91BFB6BE72DE6C7BE2B7CCA8CFA9DF';
SELECT argument FROM mysql.general_log WHERE argument LIKE 'CREATE USER %' AND
                                             command_type NOT LIKE 'Prepare';
SELECT argument FROM mysql.general_log WHERE argument LIKE 'ALTER USER %' AND
                                             command_type NOT LIKE 'Prepare';
SELECT argument FROM mysql.general_log WHERE argument LIKE 'SET PASSWORD %';
SELECT argument FROM mysql.general_log WHERE argument LIKE 'GRANT %'AND
                                             command_type NOT LIKE 'Prepare';

-- Cleanup
DROP USER user1@localhost,user8@localhost,user10@localhost,user11@localhost,
          user12@localhost,user13@localhost,user14@localhost,user15@localhost,
          user16@localhost,u10@localhost,u1,u2@localhost;

SET GLOBAL general_log_file=  @old_general_log_file;
SET GLOBAL general_log=       @old_general_log;
SET GLOBAL log_output=        @old_log_output;

CREATE USER u1;
ALTER USER u1 IDENTIFIED WITH 'invalid_plugin';
ALTER USER u1 IDENTIFIED WITH 'invalid_plugin' BY 'secret';
ALTER USER u1 IDENTIFIED WITH 'invalid_plugin' AS 'secret';
DROP USER u1;
CREATE USER bug20364862_user@localhost IDENTIFIED WITH test_plugin_server AS 'bug20364862_dest';
CREATE USER bug20364862_dest@localhost IDENTIFIED BY 'dest_password';
CREATE DATABASE db1;

-- An unprivileged user trying to alter credentials through ALTER USER should get error
-- if plugin puts restriction over who can alter credentials
--error 1
--exec $MYSQL $PLUGIN_AUTH_OPT -h localhost -P $MASTER_MYPORT -u bug20364862_user --password=bug20364862_dest -e "ALTER USER USER() IDENTIFIED BY 'qa_test_2_dest';

-- SET PASSWORD does not make any sense if mysql.user.authentication_string is
-- not used as password store
--error 1
--exec $MYSQL $PLUGIN_AUTH_OPT -h localhost -P $MASTER_MYPORT -u bug20364862_user --password=bug20364862_dest -e "SET PASSWORD = 'qa_test_2_dest'" 2>&1

connection default;
SELECT USER, AUTHENTICATION_STRING FROM mysql.user WHERE user like 'bug20364862_user';

-- Grant a user ability to update mysql.*
GRANT UPDATE ON mysql.* TO bug20364862_dest@localhost;

-- ALTER should work now
--exec $MYSQL $PLUGIN_AUTH_OPT -h localhost -P $MASTER_MYPORT -u bug20364862_user --password=bug20364862_dest -e "ALTER USER USER() IDENTIFIED BY 'qa_test_2_dest';

-- SET PASSWORD should still return an error
--error 1
--exec $MYSQL $PLUGIN_AUTH_OPT -h localhost -P $MASTER_MYPORT -u bug20364862_user --password=bug20364862_dest -e "SET PASSWORD = 'qa_test_2_dest';
SELECT USER, AUTHENTICATION_STRING FROM mysql.user WHERE user like 'bug20364862_user';

-- Grant a user ability to create user
REVOKE UPDATE ON mysql.* FROM bug20364862_dest@localhost;

-- ALTER should work now
--exec $MYSQL $PLUGIN_AUTH_OPT -h localhost -P $MASTER_MYPORT -u bug20364862_user --password=bug20364862_dest -e "ALTER USER USER() IDENTIFIED BY 'qa_test_2_dest';
SELECT USER, AUTHENTICATION_STRING FROM mysql.user WHERE user like 'bug20364862_user';

DROP DATABASE db1;
DROP USER bug20364862_user@localhost;
DROP USER bug20364862_dest@localhost;

-- Write file to make mysql-test-run.pl wait for the server to stop
let $expect_file= $MYSQLTEST_VARDIR/tmp/mysqld.1.expect;

-- Request shutdown
--send_shutdown

-- Call script that will poll the server waiting for it to disapear
--source include/wait_until_disconnected.inc

--echo -- Restart server.
--exec echo "restart:" > $expect_file

-- Turn on reconnect
--enable_reconnect

-- Call script that will poll the server waiting for it to be back online again
--source include/wait_until_connected_again.inc

CREATE USER user1@localhost;
CREATE USER user1@47.9.9.9 IDENTIFIED BY 'pass1';
CREATE USER user2 IDENTIFIED BY 'pass2';
SELECT USER(), CURRENT_USER();
SELECT USER(), CURRENT_USER();
SELECT USER(), CURRENT_USER();
SELECT USER(), CURRENT_USER();
CREATE USER bug20625566_user@localhost IDENTIFIED WITH test_plugin_server
         AS 'bug20625566_dest';
CREATE USER bug20625566_dest@localhost IDENTIFIED BY 'dest_password';
SELECT USER(), CURRENT_USER();

-- cleanup
DROP USER user1@localhost, user1@47.9.9.9, user2,
          bug20625566_user@localhost, bug20625566_dest@localhost;
