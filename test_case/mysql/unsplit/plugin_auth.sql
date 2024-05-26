select USER(),CURRENT_USER();
CREATE DATABASE test_grant_db;
DROP DATABASE test_grant_db;
SELECT @@global.check_proxy_users;
SELECT @@global.mysql_native_password_proxy_users;
SELECT @@global.sha256_password_proxy_users;
SELECT @@LOCAL.proxy_user;
SELECT @@LOCAL.proxy_user;
SELECT @@LOCAL.proxy_user;
SELECT @@LOCAL.external_user;
SELECT @@LOCAL.external_user;
SELECT @@LOCAL.external_user;
CREATE DATABASE confidential_db;
SELECT user(),current_user(),@@proxy_user;
DROP DATABASE confidential_db;
CREATE DATABASE shared;
DROP DATABASE shared;
SELECT IS_NULLABLE, COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE
  COLUMN_NAME IN ('authentication_string', 'plugin') AND
  TABLE_NAME='user' AND
  TABLE_SCHEMA='mysql'
ORDER BY COLUMN_NAME;
SELECT IS_NULLABLE, COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA= 'mysql' AND TABLE_NAME= 'user' AND
    COLUMN_NAME IN ('plugin', 'authentication_string')
  ORDER BY COLUMN_NAME;
SELECT IS_NULLABLE, COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA= 'mysql' AND TABLE_NAME= 'user' AND
    COLUMN_NAME IN ('plugin', 'authentication_string')
  ORDER BY COLUMN_NAME;
SELECT USER(), CURRENT_USER, @@PROXY_USER;
SELECT CURRENT_USER();
