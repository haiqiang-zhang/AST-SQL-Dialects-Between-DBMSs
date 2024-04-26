

-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

--echo --
--echo -- WL#6409: CREATE/ALTER USER
--echo --

--echo -- CREATE USER

CREATE USER u1@localhost;

CREATE USER u2@localhost IDENTIFIED BY 'auth_string';

CREATE USER u3@localhost IDENTIFIED WITH 'sha256_password';

CREATE USER u4@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string';

CREATE USER u5@localhost REQUIRE SSL;

CREATE USER u6@localhost IDENTIFIED BY 'auth_string' REQUIRE X509;

CREATE USER u7@localhost IDENTIFIED WITH 'sha256_password'
            REQUIRE CIPHER "ECDHE-RSA-AES128-GCM-SHA256" PASSWORD EXPIRE NEVER;
            ssl_cipher,x509_issuer,x509_subject,password_expired,password_lifetime FROM mysql.user WHERE USER='u7';

CREATE USER u8@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string'
            REQUIRE ISSUER 'issuer';

CREATE USER u9@localhost REQUIRE SUBJECT 'sub';

CREATE USER u10@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string'
            REQUIRE CIPHER "ECDHE-RSA-AES128-GCM-SHA256" AND
            SUBJECT "/C=SE/ST=Uppsala/O=MySQL AB"
            ISSUER "/C=SE/ST=Uppsala/L=Uppsala/O=MySQL AB";

CREATE USER u11@localhost WITH MAX_QUERIES_PER_HOUR 2;

CREATE USER u12@localhost IDENTIFIED BY 'auth_string'  WITH MAX_QUERIES_PER_HOUR 2;

CREATE USER u13@localhost IDENTIFIED WITH 'sha256_password'
            WITH MAX_CONNECTIONS_PER_HOUR 2;

CREATE USER u14@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string'
            WITH MAX_USER_CONNECTIONS 2 PASSWORD EXPIRE INTERVAL 6 DAY;
          password_expired,password_lifetime FROM mysql.user WHERE USER='u14';

CREATE USER u15@localhost,
            u16@localhost IDENTIFIED BY 'auth_string',
            u17@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string' PASSWORD EXPIRE;

CREATE USER u18@localhost,
            u19@localhost IDENTIFIED BY 'auth_string',
            u20@localhost IDENTIFIED WITH 'sha256_password',
            u21@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string'
            REQUIRE SUBJECT '/C=SE/ST=Uppsala/O=MySQL AB' WITH MAX_QUERIES_PER_HOUR 2 MAX_USER_CONNECTIONS 2
            PASSWORD EXPIRE NEVER;
       max_questions,max_user_connections,password_expired,password_lifetime
       FROM mysql.user WHERE USER BETWEEN 'u18' AND 'u21' ORDER BY User;

drop user u1@localhost, u2@localhost, u3@localhost, u4@localhost, u5@localhost,
          u6@localhost, u7@localhost, u8@localhost, u9@localhost, u10@localhost,
          u11@localhost, u12@localhost, u13@localhost, u14@localhost,
          u15@localhost, u16@localhost, u17@localhost, u18@localhost,
          u19@localhost, u20@localhost, u21@localhost;

CREATE USER u1@localhost;
ALTER USER u1@localhost;

CREATE USER u2@localhost IDENTIFIED BY 'auth_string';
ALTER USER u2@localhost IDENTIFIED BY 'new_auth_string';

CREATE USER u3@localhost IDENTIFIED WITH 'sha256_password';
ALTER USER u3@localhost IDENTIFIED WITH 'mysql_native_password';

CREATE USER u4@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string';
ALTER USER u4@localhost IDENTIFIED WITH 'mysql_native_password'
           BY 'auth_string';

CREATE USER u5@localhost REQUIRE SSL;
ALTER USER u5@localhost IDENTIFIED WITH 'sha256_password';

CREATE USER u6@localhost IDENTIFIED BY 'auth_string' REQUIRE X509;
ALTER USER u6@localhost IDENTIFIED BY 'new_auth_string' REQUIRE SSL;

CREATE USER u7@localhost IDENTIFIED WITH 'sha256_password'
            BY 'auth_string' REQUIRE CIPHER 'cipher';
ALTER USER u7@localhost IDENTIFIED WITH 'mysql_native_password'
            REQUIRE ISSUER 'issuer';

CREATE USER u8@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string'
            REQUIRE ISSUER 'issuer';
ALTER USER u8@localhost IDENTIFIED WITH 'mysql_native_password'
            REQUIRE CIPHER "ECDHE-RSA-AES128-GCM-SHA256";

CREATE USER u9@localhost REQUIRE SUBJECT 'sub';
ALTER USER u9@localhost REQUIRE ISSUER "/C=SE/ST=Uppsala/L=Uppsala/O=MySQL AB";

CREATE USER u10@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string'
            REQUIRE CIPHER "ECDHE-RSA-AES128-GCM-SHA256" AND
            SUBJECT "/C=SE/ST=Uppsala/O=MySQL AB"
            ISSUER "/C=SE/ST=Uppsala/L=Uppsala/O=MySQL AB";
ALTER USER u10@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string'
            REQUIRE SSL;

CREATE USER u11@localhost WITH MAX_QUERIES_PER_HOUR 2;
ALTER USER u11@localhost WITH MAX_QUERIES_PER_HOUR 6;

CREATE USER u12@localhost IDENTIFIED BY 'auth_string'  WITH MAX_QUERIES_PER_HOUR 2;
ALTER USER u12@localhost IDENTIFIED WITH 'sha256_password' WITH MAX_QUERIES_PER_HOUR 8;

CREATE USER u13@localhost IDENTIFIED WITH 'sha256_password'
            WITH MAX_CONNECTIONS_PER_HOUR 2;
ALTER USER u13@localhost PASSWORD EXPIRE;

CREATE USER u14@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string'
            WITH MAX_USER_CONNECTIONS 2;
ALTER USER u14@localhost WITH MAX_USER_CONNECTIONS 12 PASSWORD EXPIRE INTERVAL 365 DAY;

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
            u21@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string'
            REQUIRE SUBJECT '/C=SE/ST=Uppsala/O=MySQL AB' WITH MAX_QUERIES_PER_HOUR 2 MAX_USER_CONNECTIONS 2;
ALTER USER u18@localhost, u19@localhost,
           u20@localhost, u21@localhost
           REQUIRE SUBJECT '/C=SE/ST=Uppsala/O=MySQL AB'
           WITH MAX_QUERIES_PER_HOUR 2 MAX_USER_CONNECTIONS 2
           PASSWORD EXPIRE NEVER;

drop user u1@localhost, u2@localhost, u3@localhost, u4@localhost, u5@localhost,
          u6@localhost, u7@localhost, u8@localhost, u9@localhost, u10@localhost,
          u11@localhost, u12@localhost, u13@localhost, u14@localhost,
          u15@localhost, u16@localhost, u17@localhost, u18@localhost,
          u19@localhost, u20@localhost, u21@localhost;

CREATE USER u1@localhost PASSWORD EXPIRE NEVER;
SELECT password_lifetime FROM mysql.user where user='u1';
DROP USER u1@localhost;

CREATE USER u1@localhost PASSWORD EXPIRE DEFAULT;
SELECT password_expired,password_lifetime FROM mysql.user where user='u1';
DROP USER u1@localhost;

CREATE USER u1@localhost PASSWORD EXPIRE INTERVAL 4 DAY;
SELECT password_lifetime FROM mysql.user where user='u1';
DROP USER u1@localhost;

CREATE USER u1@localhost PASSWORD EXPIRE;
SELECT password_expired FROM mysql.user where user='u1';
DROP USER u1@localhost;
CREATE USER '' PASSWORD EXPIRE;
CREATE USER '' PASSWORD EXPIRE NEVER;
CREATE USER '' PASSWORD EXPIRE INTERVAL 4 DAY;

CREATE USER u1@localhost IDENTIFIED BY 'abc';
SELECT USER();
ALTER USER u1@localhost PASSWORD EXPIRE;
SELECT USER();
SET PASSWORD = 'def';
SELECT USER();
ALTER USER u1@localhost PASSWORD EXPIRE;
SELECT USER();
ALTER USER user() IDENTIFIED BY 'abc';
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
DROP USER u1@localhost, u2@localhost;

-- Wait till all disconnects are completed
--source include/wait_until_count_sessions.inc


--echo -- SHOW CREATE USER

CREATE USER u1@localhost;
ALTER USER u1@localhost IDENTIFIED BY 'auth_string';

CREATE USER u2@localhost IDENTIFIED BY 'auth_string';
ALTER USER u2@localhost IDENTIFIED WITH 'sha256_password';

CREATE USER u3@localhost IDENTIFIED WITH 'sha256_password';
ALTER USER u3@localhost PASSWORD EXPIRE NEVER;

CREATE USER u4@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string';
ALTER USER u4@localhost PASSWORD EXPIRE INTERVAL 365 DAY;

CREATE USER u5@localhost REQUIRE SSL;
ALTER USER u5@localhost REQUIRE CIPHER "ECDHE-RSA-AES128-GCM-SHA256";

CREATE USER u6@localhost IDENTIFIED BY 'auth_string' REQUIRE X509;
ALTER USER u6@localhost REQUIRE CIPHER "ECDHE-RSA-AES128-GCM-SHA256" WITH MAX_QUERIES_PER_HOUR 2;

CREATE USER u7@localhost IDENTIFIED WITH 'sha256_password'
            REQUIRE CIPHER 'ECDHE-RSA-AES128-GCM-SHA256';
ALTER USER u7@localhost REQUIRE NONE WITH MAX_USER_CONNECTIONS 12;

CREATE USER u8@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string'
            REQUIRE ISSUER 'issuer';
ALTER USER u8@localhost IDENTIFIED WITH 'mysql_native_password' BY 'auth_string';

CREATE USER u9@localhost REQUIRE SUBJECT 'sub';
ALTER USER u9@localhost;

CREATE USER u10@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string'
            REQUIRE CIPHER "ECDHE-RSA-AES128-GCM-SHA256" AND
            SUBJECT "/C=SE/ST=Uppsala/O=MySQL AB"
            ISSUER "/C=SE/ST=Uppsala/L=Uppsala/O=MySQL AB";
ALTER USER u10@localhost PASSWORD EXPIRE NEVER;

CREATE USER u11@localhost WITH MAX_QUERIES_PER_HOUR 2;
ALTER USER u11@localhost WITH MAX_QUERIES_PER_HOUR 10;

CREATE USER u12@localhost IDENTIFIED BY 'auth_string'  WITH MAX_QUERIES_PER_HOUR 2;
ALTER USER u12@localhost REQUIRE SUBJECT '/C=SE/ST=Uppsala/O=MySQL AB' WITH MAX_QUERIES_PER_HOUR 10;

CREATE USER u13@localhost IDENTIFIED WITH 'sha256_password'
            WITH MAX_CONNECTIONS_PER_HOUR 2;
ALTER USER u13@localhost REQUIRE SUBJECT '/C=SE/ST=Uppsala/O=MySQL AB' WITH MAX_QUERIES_PER_HOUR 10;

CREATE USER u14@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string'
            WITH MAX_USER_CONNECTIONS 2;
ALTER USER u14@localhost REQUIRE SUBJECT '/C=SE/ST=Uppsala/O=MySQL AB' WITH MAX_QUERIES_PER_HOUR 10
           PASSWORD EXPIRE;

CREATE USER u15@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string'
            REQUIRE SUBJECT '/C=SE/ST=Uppsala/O=MySQL AB' ISSUER "/C=SE/ST=Uppsala/L=Uppsala/O=MySQL AB"
            CIPHER 'ECDHE-RSA-AES128-GCM-SHA256' WITH MAX_QUERIES_PER_HOUR 2 MAX_USER_CONNECTIONS 2;
ALTER USER u15@localhost REQUIRE X509 PASSWORD EXPIRE INTERVAL 365 DAY;

CREATE USER u16@localhost IDENTIFIED BY 'auth_string' PASSWORD EXPIRE;
ALTER USER u16@localhost REQUIRE X509 PASSWORD EXPIRE INTERVAL 365 DAY;

CREATE USER u17@localhost WITH MAX_QUERIES_PER_HOUR 200
                               MAX_USER_CONNECTIONS 2 PASSWORD EXPIRE NEVER;
ALTER USER u17@localhost REQUIRE X509 PASSWORD EXPIRE INTERVAL 365 DAY;

CREATE USER u18@localhost IDENTIFIED WITH 'sha256_password' PASSWORD EXPIRE INTERVAL 365 DAY;
ALTER USER u18@localhost PASSWORD EXPIRE NEVER;

CREATE USER u19@localhost REQUIRE SUBJECT '/C=SE/ST=Uppsala/O=MySQL AB'
                          ISSUER "/C=SE/ST=Uppsala/L=Uppsala/O=MySQL AB"
                          PASSWORD EXPIRE DEFAULT;
ALTER USER u19@localhost WITH MAX_QUERIES_PER_HOUR 200
                         MAX_USER_CONNECTIONS 2 PASSWORD EXPIRE NEVER;

drop user u1@localhost, u2@localhost, u3@localhost, u4@localhost, u5@localhost,
          u6@localhost, u7@localhost, u8@localhost, u9@localhost, u10@localhost,
          u11@localhost, u12@localhost, u13@localhost, u14@localhost,
          u15@localhost, u16@localhost, u17@localhost, u18@localhost,
          u19@localhost;

CREATE USER 20553132_u1@localhost;
CREATE USER 20553132_u2@localhost;
CREATE USER '20553132_u3'@'%';
ALTER USER 20553132_u1@localhost PASSWORD EXPIRE;
ALTER USER '20553132_u3'@'%' PASSWORD EXPIRE;
ALTER USER 20553132_u1@localhost PASSWORD EXPIRE NEVER;
ALTER USER 20553132_u1@localhost PASSWORD EXPIRE DEFAULT;
ALTER USER 20553132_u1@localhost, 20553132_u2@localhost IDENTIFIED BY 'abcd' PASSWORD EXPIRE NEVER;

-- Must succeed
--disable_ps_protocol
ALTER USER 20553132_u2@localhost IDENTIFIED BY 'abcd', 20553132_u1@localhost IDENTIFIED BY 'defg' PASSWORD EXPIRE NEVER;
ALTER USER 20553132_u1@localhost PASSWORD EXPIRE;
ALTER USER 20553132_u2@localhost IDENTIFIED BY 'abcd', 20553132_u1@localhost IDENTIFIED WITH 'mysql_native_password' BY 'hijk' PASSWORD EXPIRE DEFAULT;
SELECT USER();
ALTER USER CURRENT_USER() IDENTIFIED BY 'abcd';
SELECT CURRENT_USER();
ALTER USER '20553132_u3'@'%' PASSWORD EXPIRE;
ALTER USER '20553132_u3'@'%' IDENTIFIED BY 'abcd';
SELECT CURRENT_USER();
DROP USER 20553132_u1@localhost;
DROP USER 20553132_u2@localhost;
DROP USER '20553132_u3'@'%';

CREATE USER u1;
ALTER USER u1 IDENTIFIED BY PASSWORD '*67092806AE91BFB6BE72DE6C7BE2B7CCA8CFA9DF';
ALTER USER u1 IDENTIFIED BY PASSWORD '*67092806AE91BFB6BE72DE6C7BE2B7CCA8CFA9DF'
      PASSWORD EXPIRE;
ALTER USER u1 IDENTIFIED BY PASSWORD '*67092806AE91BFB6BE72DE6C7BE2B7CCA8CFA9DF'
      WITH MAX_QUERIES_PER_HOUR 2 MAX_USER_CONNECTIONS 2;
ALTER USER u1 IDENTIFIED BY PASSWORD '*67092806AE91BFB6BE72DE6C7BE2B7CCA8CFA9DF'
      REQUIRE CIPHER "ECDHE-RSA-AES128-GCM-SHA256" AND
      SUBJECT "/C=SE/ST=Stockholm/L=Stockholm/O=Oracle/OU=MySQL/CN=Client";
ALTER USER u1 IDENTIFIED BY PASSWORD '*67092806AE91BFB6BE72DE6C7BE2B7CCA8CFA9DF'
      PASSWORD EXPIRE DEFAULT;
DROP USER u1;

CREATE USER bug20634154@localhost IDENTIFIED BY 'abc';
SELECT CURRENT_USER();
ALTER USER bug20634154@localhost PASSWORD EXPIRE;
SELECT CURRENT_USER();
SELECT CURRENT_USER();
ALTER USER bug20634154@localhost;
SELECT CURRENT_USER();
ALTER USER bug20634154@localhost IDENTIFIED BY 'def';
SELECT CURRENT_USER();
ALTER USER bug20634154@localhost IDENTIFIED BY 'abc' PASSWORD EXPIRE;
SELECT CURRENT_USER();
ALTER USER bug20634154@localhost IDENTIFIED BY 'def' PASSWORD EXPIRE INTERVAL 10 DAY;
SELECT CURRENT_USER();
DROP USER bug20634154@localhost;

CREATE USER bug22205360@localhost;
SET PASSWORD FOR bug22205360@localhost= 'abc';
EOF

--echo -- shutdown the server
--exec echo "wait" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--shutdown_server
--source include/wait_until_disconnected.inc

--echo -- Restart server with init-file option
--exec echo "restart:--init-file=$MYSQLTEST_VARDIR/tmp/set_password.sql" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--enable_reconnect
--source include/wait_until_connected_again.inc

--connect(con1, localhost, bug22205360, abc)
SELECT 1;
ALTER USER bug22205360@localhost IDENTIFIED BY 'def';
EOF

--echo -- shutdown the server
--exec echo "wait" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--shutdown_server
--source include/wait_until_disconnected.inc

--echo -- Restart server with init-file option
--exec echo "restart:--init-file=$MYSQLTEST_VARDIR/tmp/alter_password.sql" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--enable_reconnect
--source include/wait_until_connected_again.inc

--connect(con2, localhost, bug22205360, def)
SELECT 1;
DROP USER bug22205360@localhost;
