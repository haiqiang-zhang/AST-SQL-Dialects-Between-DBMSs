
let $MYSQL_ERRMSG_BASEDIR=`select @@lc_messages_dir`;

-- component is not installed so even 'pass' (very weak) is accepted as
-- a password
--replace_column 3 --#####
CREATE USER 'usr1'@'localhost' IDENTIFIED BY RANDOM PASSWORD;
CREATE USER 'usr2'@'localhost' IDENTIFIED BY RANDOM PASSWORD;

-- test for all the three password policy
-- policy: LOW, MEDIUM, STRONG

--echo -- password policy LOW (which only check for password length)
--echo -- default case: password length should be minimum 8

SET @@global.validate_password.policy=LOW;

SET @@global.generated_random_password_length = 5;
CREATE USER 'usr3'@'localhost' IDENTIFIED BY RANDOM PASSWORD;
ALTER USER 'usr1'@'localhost' IDENTIFIED BY RANDOM PASSWORD;
SET PASSWORD FOR 'usr1'@'localhost' TO RANDOM;
DROP USER 'usr3'@'localhost';

SET @@global.generated_random_password_length = 8;
CREATE USER 'usr3'@'localhost' IDENTIFIED BY RANDOM PASSWORD;
ALTER USER 'usr1'@'localhost' IDENTIFIED BY RANDOM PASSWORD;
SET PASSWORD FOR 'usr1'@'localhost' TO RANDOM;
DROP USER 'usr3'@'localhost';

SET @@global.validate_password.length= 12;
CREATE USER 'usr3'@'localhost' IDENTIFIED BY RANDOM PASSWORD;
ALTER USER 'usr1'@'localhost' IDENTIFIED BY RANDOM PASSWORD;
SET PASSWORD FOR 'usr1'@'localhost' TO RANDOM;
DROP USER 'usr3'@'localhost';

SET @@global.validate_password.mixed_case_count= 0;
SET @@global.validate_password.number_count= 0;
SET @@global.validate_password.special_char_count= 0;
SET @@global.validate_password.length= 0;
SET @@global.validate_password.length= DEFAULT;
CREATE USER 'usr3'@'localhost' IDENTIFIED BY RANDOM PASSWORD;
ALTER USER 'usr1'@'localhost' IDENTIFIED BY RANDOM PASSWORD;
SET PASSWORD FOR 'usr1'@'localhost' TO RANDOM;
DROP USER 'usr3'@'localhost';

SET @@global.validate_password.mixed_case_count= 1;
SET @@global.validate_password.number_count= 1;
SET @@global.validate_password.special_char_count= 1;
SET @@global.validate_password.policy=MEDIUM;
SET @@global.validate_password.number_count= 0;
CREATE USER 'usr3'@'localhost' IDENTIFIED BY RANDOM PASSWORD;
ALTER USER 'usr1'@'localhost' IDENTIFIED BY RANDOM PASSWORD;
SET PASSWORD FOR 'usr1'@'localhost' TO RANDOM;
DROP USER 'usr3'@'localhost';

SET @@global.validate_password.mixed_case_count= 0;
CREATE USER 'usr3'@'localhost' IDENTIFIED BY RANDOM PASSWORD;
ALTER USER 'usr1'@'localhost' IDENTIFIED BY RANDOM PASSWORD;
SET PASSWORD FOR 'usr1'@'localhost' TO RANDOM;
DROP USER 'usr3'@'localhost';

SET @@global.validate_password.special_char_count= 0;
CREATE USER 'usr3'@'localhost' IDENTIFIED BY RANDOM PASSWORD;
ALTER USER 'usr1'@'localhost' IDENTIFIED BY RANDOM PASSWORD;
SET PASSWORD FOR 'usr1'@'localhost' TO RANDOM;
DROP USER 'usr3'@'localhost';

SET @@global.validate_password.special_char_count= 1;
SET @@global.validate_password.number_count= 1;
SET @@global.validate_password.mixed_case_count= 1;
CREATE USER 'usr3'@'localhost' IDENTIFIED BY RANDOM PASSWORD;
ALTER USER 'usr1'@'localhost' IDENTIFIED BY RANDOM PASSWORD;
SET PASSWORD FOR 'usr1'@'localhost' TO RANDOM;
DROP USER 'usr3'@'localhost';

SET @@global.validate_password.number_count= 2;
CREATE USER 'usr3'@'localhost' IDENTIFIED BY RANDOM PASSWORD;
ALTER USER 'usr1'@'localhost' IDENTIFIED BY RANDOM PASSWORD;
SET PASSWORD FOR 'usr1'@'localhost' TO RANDOM;
DROP USER 'usr3'@'localhost';

SET @@global.validate_password.number_count= 1;
SET @@global.validate_password.mixed_case_count= 2;
CREATE USER 'usr3'@'localhost' IDENTIFIED BY RANDOM PASSWORD;
ALTER USER 'usr1'@'localhost' IDENTIFIED BY RANDOM PASSWORD;
SET PASSWORD FOR 'usr1'@'localhost' TO RANDOM;
DROP USER 'usr3'@'localhost';

SET @@global.validate_password.mixed_case_count= 1;
SET @@global.validate_password.special_char_count= 2;
SET @@global.validate_password.special_char_count= 1;
SET @@global.validate_password.policy=STRONG;
CREATE USER 'usr3'@'localhost' IDENTIFIED BY RANDOM PASSWORD;
ALTER USER 'usr1'@'localhost' IDENTIFIED BY RANDOM PASSWORD;
SET PASSWORD FOR 'usr1'@'localhost' TO RANDOM;
DROP USER 'usr3'@'localhost';

-- file should contain 1 word per line
-- error if substring of password is a dictionary word

SET @@global.validate_password.policy=STRONG;
CREATE USER 'usr3'@'localhost' IDENTIFIED BY RANDOM PASSWORD;
ALTER USER 'usr1'@'localhost' IDENTIFIED BY RANDOM PASSWORD;
SET PASSWORD FOR 'usr1'@'localhost' TO RANDOM;
DROP USER 'usr3'@'localhost';
DROP USER 'usr1'@'localhost';
DROP USER 'usr2'@'localhost';
SET @@global.validate_password.length=default;
SET @@global.validate_password.number_count=default;
SET @@global.validate_password.mixed_case_count=default;
SET @@global.validate_password.special_char_count=default;
SET @@global.validate_password.policy=default;
SET @@global.validate_password.dictionary_file=default;
SET @@global.generated_random_password_length=default;

SELECT @@validate_password.length,
       @@validate_password.number_count,
       @@validate_password.mixed_case_count,
       @@validate_password.special_char_count,
       @@validate_password.policy,
       @@validate_password.dictionary_file;
