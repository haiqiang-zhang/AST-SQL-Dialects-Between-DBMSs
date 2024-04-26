

-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

--echo
--echo -- CREATE USER,ALTER USER,SHOW CREATE USER tests with ACCOUNT UNLOCK/LOCK
connection default;
CREATE USER user1;
SELECT USER();

ALTER USER user1;

-- Testing connection
--connect(con1, localhost, user1)
SELECT USER();

CREATE USER user2@localhost ACCOUNT UNLOCK;
SELECT USER();
ALTER USER user() IDENTIFIED BY 'auth_string' ACCOUNT LOCK;

-- Using user_name
GRANT CREATE USER ON *.* TO user2@localhost;
SELECT USER();
ALTER USER user2@localhost IDENTIFIED BY 'auth_string' ACCOUNT LOCK;
SELECT USER();

-- Testing connection
--replace_result $MASTER_MYSOCK MASTER_SOCKET $MASTER_MYPORT MASTER_PORT
--error ER_ACCOUNT_HAS_BEEN_LOCKED
--connect(con1, localhost, user2,'auth_string')
connection default;

ALTER USER user2@localhost ACCOUNT LOCK;

CREATE USER 'user8'@'localhost' IDENTIFIED WITH 'mysql_native_password'
            AS '*67092806AE91BFB6BE72DE6C7BE2B7CCA8CFA9DF'
            ACCOUNT UNLOCK;
ALTER USER 'user8'@'localhost' ACCOUNT LOCK PASSWORD EXPIRE NEVER;
CREATE USER 'user9'@'localhost' IDENTIFIED WITH 'mysql_native_password'
            AS '*67092806AE91BFB6BE72DE6C7BE2B7CCA8CFA9DF'
            ACCOUNT LOCK;
CREATE USER 'user10'@'localhost' IDENTIFIED WITH 'mysql_native_password'
            AS '*67092806AE91BFB6BE72DE6C7BE2B7CCA8CFA9DF'
            PASSWORD EXPIRE NEVER ACCOUNT UNLOCK;
ALTER USER 'user10'@'localhost' PASSWORD EXPIRE DEFAULT ACCOUNT LOCK;
CREATE USER 'user11'@'localhost' IDENTIFIED WITH 'mysql_native_password'
            AS '*67092806AE91BFB6BE72DE6C7BE2B7CCA8CFA9DF'
            ACCOUNT LOCK PASSWORD EXPIRE NEVER;
ALTER USER 'user11'@'localhost' PASSWORD EXPIRE INTERVAL 10 DAY ACCOUNT LOCK;

-- Testing invalid syntax
--error ER_PARSE_ERROR
CREATE USER ACCOUNT UNLOCK user5@localhost;
CREATE USER ACCOUNT LOCK user6@localhost;
ALTER USER ACCOUNT LOCK user2@localhost;
ALTER USER ACCOUNT UNLOCK user2@localhot;

-- CREATE/ALTER USER with  Using masks with multiple user.
CREATE USER user3,user4@localhost ACCOUNT LOCK;
CREATE USER user6@'%',user7@localhost ACCOUNT LOCK;
ALTER USER user3,user4@localhost ACCOUNT UNLOCK;
ALTER USER user7@localhost,user6@'%' ACCOUNT UNLOCK;

ALTER USER user4@localhost,user3 ACCOUNT LOCK;
SELECT * FROM INFORMATION_SCHEMA.user_privileges WHERE GRANTEE LIKE '%user%' AND GRANTEE NOT IN ("'mysql.session'@'localhost'");

-- Cleanup
DROP USER user1,user2@localhost,user3,user4@localhost,user6,user7@localhost,
          user8@localhost,user9@localhost,user10@localhost,user11@localhost;
CREATE USER u1@localhost ACCOUNT LOCK;

ALTER USER u1@localhost;

CREATE USER u2@localhost IDENTIFIED BY 'auth_string' ACCOUNT LOCK;
DROP USER u2@localhost;
CREATE USER 'u2'@'localhost' IDENTIFIED WITH 'mysql_native_password'
            AS '*67092806AE91BFB6BE72DE6C7BE2B7CCA8CFA9DF'
            REQUIRE NONE PASSWORD EXPIRE DEFAULT ACCOUNT LOCK;

ALTER USER u2@localhost IDENTIFIED BY 'auth_string' ACCOUNT UNLOCK;
SELECT USER();

CREATE USER u3@localhost IDENTIFIED WITH 'sha256_password'
                         ACCOUNT UNLOCK ACCOUNT LOCK;

-- Testing connection
--replace_result $MASTER_MYSOCK MASTER_SOCKET $MASTER_MYPORT MASTER_PORT
--error ER_ACCOUNT_HAS_BEEN_LOCKED
--connect(con1, localhost, u3,,,,,SSL)
connection default;

ALTER USER u3@localhost IDENTIFIED WITH 'sha256_password'
                        ACCOUNT LOCK ACCOUNT UNLOCK;
SELECT USER();
SET PASSWORD = 'def';

CREATE USER u4@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string'
                         PASSWORD EXPIRE DEFAULT ACCOUNT LOCK;

ALTER USER u4@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string'
                        ACCOUNT UNLOCK;

-- Testing connection
--connect(con1, localhost, u4,'auth_string',,,,SSL)
SELECT USER();
CREATE USER user4@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string'
ACCOUNT LOCK PASSWORD EXPIRE DEFAULT ACCOUNT UNLOCK PASSWORD EXPIRE INTERVAL 90 DAY;

CREATE USER user5@localhost IDENTIFIED WITH 'mysql_native_password' AS '*67092806AE91BFB6BE72DE6C7BE2B7CCA8CFA9DF'
                            ACCOUNT UNLOCK PASSWORD EXPIRE NEVER;
SELECT USER();
CREATE USER user6@localhost IDENTIFIED WITH 'mysql_native_password'
                            ACCOUNT UNLOCK ACCOUNT LOCK PASSWORD EXPIRE NEVER;
ALTER USER user6@localhost IDENTIFIED WITH 'mysql_native_password'
                           ACCOUNT LOCK ACCOUNT UNLOCK;

-- Testing connection
--connect(con1, localhost, user6)
--error ER_MUST_CHANGE_PASSWORD
SELECT USER();
CREATE USER user7@localhost IDENTIFIED WITH 'mysql_native_password' BY 'auth_string--%y'
            PASSWORD EXPIRE DEFAULT ACCOUNT LOCK PASSWORD EXPIRE NEVER ACCOUNT UNLOCK;
SELECT USER();
ALTER USER user7@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string_sha256'
           PASSWORD EXPIRE NEVER ACCOUNT LOCK;

CREATE USER user8@localhost IDENTIFIED WITH 'mysql_native_password'
AS '*67092806AE91BFB6BE72DE6C7BE2B7CCA8CFA9DF' ACCOUNT UNLOCK PASSWORD EXPIRE NEVER;
SELECT USER();
ALTER USER user8@localhost IDENTIFIED WITH 'mysql_native_password' BY 'new_auth_string'
                           ACCOUNT UNLOCK PASSWORD EXPIRE;
SELECT USER();
SET PASSWORD='auth_string';
SELECT USER();
CREATE USER u5@localhost REQUIRE SSL ACCOUNT LOCK PASSWORD EXPIRE;
ALTER USER u5@localhost REQUIRE SSL PASSWORD EXPIRE DEFAULT ACCOUNT UNLOCK;
SELECT USER();

CREATE USER u6@localhost IDENTIFIED BY 'auth_string' REQUIRE X509
                         ACCOUNT LOCK PASSWORD EXPIRE PASSWORD EXPIRE NEVER;
ALTER USER u6@localhost ACCOUNT UNLOCK;
SELECT USER();

CREATE USER u7@localhost IDENTIFIED WITH 'sha256_password'
            REQUIRE CIPHER "ECDHE-RSA-AES128-GCM-SHA256"
            PASSWORD EXPIRE NEVER PASSWORD EXPIRE NEVER;
SELECT USER();
ALTER USER u7@localhost IDENTIFIED WITH 'mysql_native_password'
                        PASSWORD EXPIRE DEFAULT ACCOUNT LOCK;

CREATE USER u8@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string'
            REQUIRE ISSUER '/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=CA'
            PASSWORD EXPIRE NEVER ACCOUNT UNLOCK;
SELECT USER();
ALTER USER u8@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string'
            REQUIRE ISSUER '/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=CA'
            PASSWORD EXPIRE NEVER ACCOUNT LOCK;

CREATE USER u9@localhost
            REQUIRE SUBJECT "/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=Client"
            ACCOUNT LOCK PASSWORD EXPIRE NEVER;
ALTER USER u9@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string' ACCOUNT UNLOCK;
SELECT USER();

CREATE USER u10@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string--y'
            REQUIRE CIPHER "ECDHE-RSA-AES128-GCM-SHA256"
            SUBJECT "/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=Client"
            ISSUER "/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=CA"
            ACCOUNT LOCK PASSWORD EXPIRE DEFAULT ACCOUNT UNLOCK;
SELECT USER();
ALTER USER u10@localhost REQUIRE CIPHER "ECDHE-RSA-AES128-GCM-SHA256"
           ACCOUNT UNLOCK PASSWORD EXPIRE DEFAULT ACCOUNT LOCK;

CREATE USER u11@localhost WITH MAX_QUERIES_PER_HOUR 2 ACCOUNT LOCK;
ALTER USER u11@localhost WITH MAX_QUERIES_PER_HOUR 6 ACCOUNT UNLOCK ACCOUNT UNLOCK;
DROP USER u11@localhost;
CREATE USER 'u11'@'localhost' IDENTIFIED WITH 'mysql_native_password'
REQUIRE NONE WITH MAX_QUERIES_PER_HOUR 6 PASSWORD EXPIRE DEFAULT ACCOUNT UNLOCK;
SELECT USER();

CREATE USER u12@localhost IDENTIFIED BY 'auth_string'
                          WITH MAX_QUERIES_PER_HOUR 4
                          ACCOUNT LOCK PASSWORD EXPIRE NEVER PASSWORD EXPIRE ACCOUNT UNLOCK;
SELECT USER();
ALTER USER USER() IDENTIFIED BY 'abc';
SELECT USER();

ALTER USER u12@localhost ACCOUNT LOCK PASSWORD EXPIRE NEVER
                         PASSWORD EXPIRE NEVER ACCOUNT UNLOCK
                         ACCOUNT LOCK ACCOUNT LOCK ACCOUNT UNLOCK;
SELECT USER();

CREATE USER u13@localhost IDENTIFIED WITH 'sha256_password'
            WITH MAX_CONNECTIONS_PER_HOUR 2 ACCOUNT LOCK;
ALTER USER u13@localhost PASSWORD EXPIRE INTERVAL 20 DAY ACCOUNT UNLOCK;
SELECT USER();

CREATE USER u14@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string'
REQUIRE CIPHER "ECDHE-RSA-AES128-GCM-SHA256"
WITH MAX_USER_CONNECTIONS 2 ACCOUNT LOCK PASSWORD EXPIRE INTERVAL 999 DAY ACCOUNT UNLOCK;
SELECT USER();

ALTER USER u14@localhost
REQUIRE SUBJECT "/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=Client"
ISSUER "/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=CA"
WITH MAX_USER_CONNECTIONS 2 ACCOUNT LOCK PASSWORD EXPIRE INTERVAL 999 DAY ACCOUNT UNLOCK;
SELECT USER();

CREATE USER u15@localhost,
            u16@localhost IDENTIFIED BY 'auth_string',
            u17@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string'
            ACCOUNT UNLOCK;
SELECT USER();
SELECT USER();
SELECT USER();

CREATE USER u18@localhost,
            u19@localhost IDENTIFIED BY 'auth_string',
            u20@localhost IDENTIFIED WITH 'sha256_password',
            u21@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string',
            u22@localhost IDENTIFIED WITH 'mysql_native_password',
            u23@localhost IDENTIFIED WITH 'mysql_native_password'
                          AS '*318C29553A414C4A571A077BC9E9A9F67D5E5634'
            REQUIRE SUBJECT '/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=Client'
            WITH MAX_QUERIES_PER_HOUR 2 MAX_USER_CONNECTIONS 2 ACCOUNT LOCK;
ALTER  USER u18@localhost,
            u19@localhost IDENTIFIED BY 'auth_string',
            u20@localhost IDENTIFIED WITH 'sha256_password',
            u21@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string',
            u22@localhost IDENTIFIED WITH 'mysql_native_password',
            u23@localhost IDENTIFIED WITH 'mysql_native_password'
                          AS '*318C29553A414C4A571A077BC9E9A9F67D5E5634'
                          REQUIRE CIPHER "ECDHE-RSA-AES128-GCM-SHA256"
                          ISSUER "/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=CA"
                          ACCOUNT UNLOCK;
SELECT USER();
SELECT USER();
SELECT USER();

-- Testing connection
--connect(con1, localhost, u21,'auth_string',,,,SSL)
SELECT USER();

-- Testing connection
--connect(con1, localhost, u22,,,,,SSL)
--error ER_MUST_CHANGE_PASSWORD
SELECT USER();

-- Testing connection
--connect(con1, localhost, u23,'auth_&string',,,,SSL)
SELECT USER();
DROP USER user4@localhost,user5@localhost,user6@localhost,user7@localhost,user8@localhost,
          u1@localhost, u2@localhost, u3@localhost, u4@localhost, u5@localhost,
          u6@localhost, u7@localhost, u8@localhost, u9@localhost, u10@localhost,
          u11@localhost, u12@localhost, u13@localhost, u14@localhost,
          u15@localhost, u16@localhost, u17@localhost, u18@localhost,
          u19@localhost, u20@localhost, u21@localhost,u22@localhost,u23@localhost;
CREATE USER u1@localhost IDENTIFIED BY 'pass';
CREATE USER u2@localhost IDENTIFIED BY 'pass';

CREATE TABLE test.t1(counter INT);
INSERT INTO test.t1 VALUES(0);
CREATE TABLE test.t2(update_count INT);
CREATE DEFINER = u1@localhost TRIGGER test.t1_update_count
BEFORE UPDATE ON test.t1 FOR EACH ROW
BEGIN
  UPDATE test.t2 SET update_count = update_count + 1;
CREATE DEFINER = u1@localhost PROCEDURE test.p1()
BEGIN
  UPDATE test.t1 SET counter= counter + 1;
  UPDATE test.t1 SET counter= counter + 1;
  UPDATE test.t1 SET counter= counter + 1;
  SELECT counter FROM test.t1;
SELECT update_count FROM test.t2;
CREATE DEFINER = u1@localhost FUNCTION test.myfunc() RETURNS CHAR(50)
BEGIN
RETURN 'wl6054_test';
ALTER USER u1@localhost ACCOUNT LOCK;
SELECT CURRENT_USER();
SELECT update_count FROM test.t2;
SELECT update_count,myfunc() FROM test.t2;
DROP PROCEDURE IF EXISTS test.p1;
DROP TRIGGER IF EXISTS t1_update_count;
DROP FUNCTION IF EXISTS test.myfunc;
DROP TABLE test.t1,test.t2;
DROP USER u1@localhost,u2@localhost;
