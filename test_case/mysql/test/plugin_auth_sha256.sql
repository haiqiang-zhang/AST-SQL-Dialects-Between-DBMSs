
-- This test will intentionally generate errors in the server error log
-- when a broken password is inserted into the mysql.user table.
-- The below suppression is to clear those errors.
--disable_query_log
call mtr.add_suppression(".*Password salt for user.*");

CREATE USER 'kristofer' IDENTIFIED WITH 'sha256_password';
ALTER USER 'kristofer' IDENTIFIED BY 'secret';
SELECT user, plugin FROM mysql.user ORDER BY user;
SELECT USER(),CURRENT_USER();
DROP USER 'kristofer';

CREATE USER 'kristofer'@'localhost' IDENTIFIED WITH 'sha256_password' BY '123';
CREATE USER 'kristofer2'@'localhost' IDENTIFIED WITH 'sha256_password' BY '123';
ALTER USER 'kristofer'@'localhost' IDENTIFIED BY 'secret2';
ALTER USER 'kristofer2'@'localhost' IDENTIFIED BY 'secret2';
SELECT USER(),CURRENT_USER();
SELECT USER(),CURRENT_USER();
DROP USER 'kristofer'@'localhost';
DROP USER 'kristofer2'@'localhost';

CREATE USER 'kristofer'@'localhost' IDENTIFIED WITH 'sha256_password' BY '123';
ALTER USER 'kristofer'@'localhost' IDENTIFIED BY '';
SELECT USER(),CURRENT_USER();
DROP USER 'kristofer'@'localhost';

CREATE USER 'kristofer'@'33.33.33.33' IDENTIFIED WITH 'sha256_password' BY '123';
ALTER USER 'kristofer'@'33.33.33.33' IDENTIFIED BY '';
DROP USER 'kristofer'@'33.33.33.33';

--
-- test bad password formats
--
CREATE USER 'kristofer' IDENTIFIED WITH 'sha256_password';
ALTER USER 'kristofer' IDENTIFIED BY 'secret';
SELECT user, plugin FROM mysql.user ORDER BY user;
SELECT USER(),CURRENT_USER();
UPDATE mysql.user SET authentication_string= '$' WHERE user='kristofer';
SELECT user,authentication_string,plugin FROM mysql.user WHERE user='kristofer';

UPDATE mysql.user SET authentication_string= '$5$asd' WHERE user='kristofer';
SELECT user,authentication_string,plugin FROM mysql.user WHERE user='kristofer';
DROP USER kristofer;
