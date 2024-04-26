
let $MYSQL_ERRMSG_BASEDIR=`select @@lc_messages_dir`;

-- plugin is not installed so even 'pass' (very weak)
-- is accepted as a password
CREATE USER 'base_user'@'localhost' IDENTIFIED BY 'pass',
  'user1'@'localhost' IDENTIFIED BY 'pass';

-- test for all the three password policy
-- policy: LOW, MEDIUM, STRONG

--echo -- password policy LOW (which only check for password length)
--echo -- default case: password length should be minimum 8

SET @@global.validate_password_policy=LOW;
CREATE USER 'user'@'localhost' IDENTIFIED BY '';
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'aweg';
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'password3';
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'password';
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'passwor';
SET @@global.validate_password_length= 12;
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'afrgtyhlp98';
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'iuyt567nbvfA';
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'password1234';
SET @@global.validate_password_mixed_case_count= 0;
SET @@global.validate_password_number_count= 0;
SET @@global.validate_password_special_char_count= 0;
SET @@global.validate_password_length= 0;
ALTER USER 'base_user'@'localhost' IDENTIFIED BY '';
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'p';
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'password';
SET @@global.validate_password_length= -2;
SET @@global.validate_password_length= 3.5;

-- test to check maximum value of password_length

SET @@global.validate_password_length= 2147483647;
SET @@global.validate_password_length= 2147483648;
SET @a = REPEAT('a',2147483647);
SET @b = 'user@localhost';
SET @@global.validate_password_length= 4294967295;
SET @@global.validate_password_length= 8;
SET @a = REPEAT('a',1048576);
SET @b = 'user@localhost';

SET @@global.validate_password_mixed_case_count= 1;
SET @@global.validate_password_number_count= 1;
SET @@global.validate_password_special_char_count= 1;
SET @@global.validate_password_policy=MEDIUM;
SET @@global.validate_password_number_count= 0;
CREATE USER 'user'@'localhost' IDENTIFIED BY 'aedfoiASE$%';
ALTER USER 'user'@'localhost' IDENTIFIED BY 'foiuiuytd78';
ALTER USER 'user'@'localhost' IDENTIFIED BY 'pasretryFRGH&^98';
SET @@global.validate_password_mixed_case_count= 0;
CREATE USER 'user'@'localhost' IDENTIFIED BY 'aedSWEhjui';
ALTER USER 'user'@'localhost' IDENTIFIED BY 'gruyuHOIU&*(';
ALTER USER 'user'@'localhost' IDENTIFIED BY 'passwor0987**&';
SET @@global.validate_password_special_char_count= 0;
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'piufgklol';
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'password1A--';
SET @@global.validate_password_special_char_count= 1;
SET @@global.validate_password_number_count= 1;
SET @@global.validate_password_mixed_case_count= 1;
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'erftuiik';
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'password1A--';
SET @@global.validate_password_number_count= 2;
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'password1A--';
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'password12A--';
SET @@global.validate_password_number_count= 1;
SET @@global.validate_password_mixed_case_count= 2;
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'password1A--';
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'password1AB--';
SET @@global.validate_password_mixed_case_count= 1;
SET @@global.validate_password_special_char_count= 2;
SET @@global.validate_password_special_char_count= 1;
SET @@global.validate_password_policy=STRONG;
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'password1A--';

-- file should contain 1 word per line
-- error if substring of password is a dictionary word

SET @@global.validate_password_policy=STRONG;
CREATE USER 'user'@'localhost' IDENTIFIED BY 'password';
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'password1A--';
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'pass12345A--';
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'pass0000A--';
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'PA00wrd!--';
SELECT VALIDATE_PASSWORD_STRENGTH('password', 0);
SELECT VALIDATE_PASSWORD_STRENGTH();
SELECT VALIDATE_PASSWORD_STRENGTH('');
SELECT VALIDATE_PASSWORD_STRENGTH('pass');
SELECT VALIDATE_PASSWORD_STRENGTH('password');
SELECT VALIDATE_PASSWORD_STRENGTH('password0000');
SELECT VALIDATE_PASSWORD_STRENGTH('password1A--');
SELECT VALIDATE_PASSWORD_STRENGTH('PA12wrd!--');
SELECT VALIDATE_PASSWORD_STRENGTH('PA00wrd!--');

-- Test for multibyte character set that have greater size when converted
-- from uppercase to lowercase.
SET NAMES 'ujis';
SELECT VALIDATE_PASSWORD_STRENGTH('PA12wrd!--');

-- default policy is set, all other plugin variables set to default
-- Test to ensure that only the privileged user can access the plugin variables
SET @@global.validate_password_policy=MEDIUM;

-- New connection
connect (plug_con,localhost,user1,pass);
SET @@global.validate_password_policy=LOW;
SET @@global.validate_password_length= 4;
SET @@global.validate_password_special_char_count= 0;
SET @@global.validate_password_mixed_case_count= 0;
CREATE USER 'user2'@'localhost' IDENTIFIED BY 'password';
CREATE USER 'user2'@'localhost' IDENTIFIED BY 'PA00wrd!--';
ALTER USER 'user2'@'localhost' IDENTIFIED BY 'password';
ALTER USER 'user2'@'localhost' IDENTIFIED BY 'PA00wrd!--';
DROP USER 'user2'@'localhost';
DROP USER 'base_user'@'localhost';
DROP USER 'user1'@'localhost';
DROP USER 'user'@'localhost';
SET @@global.validate_password_length=default;
SET @@global.validate_password_number_count=default;
SET @@global.validate_password_mixed_case_count=default;
SET @@global.validate_password_special_char_count=default;
SET @@global.validate_password_policy=default;
SET @@global.validate_password_dictionary_file=default;

SELECT @@validate_password_length,
       @@validate_password_number_count,
       @@validate_password_mixed_case_count,
       @@validate_password_special_char_count,
       @@validate_password_policy,
       @@validate_password_dictionary_file;

SET @@global.validate_password_policy=STRONG;
EOF

--write_file $MYSQLTEST_VARDIR/tmp/dictionary2.txt
password
validate
monkey
EOF

--echo -- No dictionary file, password is accepted
CREATE USER 'user1'@'localhost' IDENTIFIED BY 'passWORD123--';
SELECT VARIABLE_VALUE FROM performance_schema.global_status
  WHERE VARIABLE_NAME = 'validate_password_dictionary_file_words_count';

SELECT VARIABLE_VALUE into @ts1 FROM performance_schema.global_status
  WHERE VARIABLE_NAME = "validate_password_dictionary_file_last_parsed";
SELECT @ts1;
SELECT LENGTH(@ts1);
SELECT VARIABLE_VALUE FROM performance_schema.global_status
  WHERE VARIABLE_NAME = 'validate_password_dictionary_file_words_count';

SELECT VARIABLE_VALUE into @ts2 FROM performance_schema.global_status
  WHERE VARIABLE_NAME = "validate_password_dictionary_file_last_parsed";
SELECT @ts1 <> @ts2;
CREATE USER 'user2'@'localhost' IDENTIFIED BY 'passWORD123--';

SET @@global.validate_password_dictionary_file=NULL;
CREATE USER 'user2'@'localhost' IDENTIFIED BY 'passWORD123--';
SELECT NAME FROM performance_schema.setup_instruments WHERE NAME LIKE '%validate%';
SELECT NAME FROM performance_schema.rwlock_instances WHERE NAME LIKE '%validate%';
DROP USER 'user1'@'localhost', 'user2'@'localhost';
SET @@global.validate_password_policy=DEFAULT;
CREATE ROLE r1;
DROP ROLE r1;
