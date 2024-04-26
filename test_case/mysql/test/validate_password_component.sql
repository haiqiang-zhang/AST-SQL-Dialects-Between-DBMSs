
-- Warning is generated when default file (NULL) is used
CALL mtr.add_suppression("Dictionary file not specified");

-- Warning is generated when dictionary file is not loaded
CALL mtr.add_suppression("Dictionary file open failed");

-- Warning is generated when dictionary file is not provided with
-- PASSWORD_POLICY_STRONG
CALL mtr.add_suppression("Since the validate_password_policy is mentioned ");

-- Warning is generated when dictionary file size exceeded
-- MAX_DICTIONARY_FILE_LENGTH
CALL mtr.add_suppression("Dictionary file size exceeded");

-- Warning is generated when validate_password.length is chaged
-- as a result of changing value of system variables listed below:
-- VALIDATE_PASSWORD.NUMBER_COUNT
-- VALIDATE_PASSWORD.MIXED_CASE_COUNT
-- VALIDATE_PASSWORD.SPECIAL_CHAR_COUNT
CALL mtr.add_suppression("Effective value of validate_password.length is changed.");

let $MYSQL_ERRMSG_BASEDIR=`select @@lc_messages_dir`;

-- component is not installed so even 'pass' (very weak) is accepted as
-- a password
CREATE USER 'base_user'@'localhost' IDENTIFIED BY 'pass';
CREATE USER 'user1'@'localhost' IDENTIFIED BY 'pass';

-- test for all the three password policy
-- policy: LOW, MEDIUM, STRONG

--echo -- password policy LOW (which only check for password length)
--echo -- default case: password length should be minimum 8

SET @@global.validate_password.policy=LOW;
CREATE USER 'user'@'localhost' IDENTIFIED BY '';
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'aweg';
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'password3';
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'password';
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'passwor';
SET @@global.validate_password.length= 12;
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'afrgtyhlp98';
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'iuyt567nbvfA';
SET @@global.validate_password.mixed_case_count= 0;
SET @@global.validate_password.number_count= 0;
SET @@global.validate_password.special_char_count= 0;
SET @@global.validate_password.length= 0;
ALTER USER 'base_user'@'localhost' IDENTIFIED BY '';
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'p';
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'password';
SET @@global.validate_password.length= -2;
SET @@global.validate_password.length= 3.5;

-- test to check maximum value of password_length

SET @@global.validate_password.length= 2147483647;
SET @@global.validate_password.length= 2147483648;
SET @a = REPEAT('a',2147483647);
SET @b = 'user@localhost';
SET @@global.validate_password.length= 4294967295;
SET @@global.validate_password.length= 8;
SET @a = REPEAT('a',1048576);
SET @b = 'user@localhost';

SET @@global.validate_password.mixed_case_count= 1;
SET @@global.validate_password.number_count= 1;
SET @@global.validate_password.special_char_count= 1;
SET @@global.validate_password.policy=MEDIUM;
SET @@global.validate_password.number_count= 0;
CREATE USER 'user'@'localhost' IDENTIFIED BY 'aedfoiASE$%';
ALTER USER 'user'@'localhost' IDENTIFIED BY 'foiuiuytd78';
ALTER USER 'user'@'localhost' IDENTIFIED BY 'abcdefgh';
ALTER USER 'user'@'localhost' IDENTIFIED BY 'abcdeFGH';
ALTER USER 'user'@'localhost' IDENTIFIED BY 'pasretryFRGH&^98';
SET @@global.validate_password.mixed_case_count= 0;
CREATE USER 'user'@'localhost' IDENTIFIED BY 'aedSWEhjui';
ALTER USER 'user'@'localhost' IDENTIFIED BY 'gruyuHOIU&*(';
ALTER USER 'user'@'localhost' IDENTIFIED BY 'passwor0987**&';
SET @@global.validate_password.special_char_count= 0;
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'piufgklol';
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'password1A--';
SET @@global.validate_password.special_char_count= 1;
SET @@global.validate_password.number_count= 1;
SET @@global.validate_password.mixed_case_count= 1;
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'erftuiik';
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'erftuIIK';
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'erftu123';
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'password1A--';
SET @@global.validate_password.number_count= 2;
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'password1A--';
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'password12A--';
SET @@global.validate_password.number_count= 1;
SET @@global.validate_password.mixed_case_count= 2;
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'password1A--';
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'password1AB--';
SET @@global.validate_password.mixed_case_count= 1;
SET @@global.validate_password.special_char_count= 2;
SET @@global.validate_password.special_char_count= 1;
SET @@global.validate_password.policy=STRONG;
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'password1A--';

-- file should contain 1 word per line
-- error if substring of password is a dictionary word

SET @@global.validate_password.policy=STRONG;
CREATE USER 'user'@'localhost' IDENTIFIED BY 'password';
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'password1A--';
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'pass12345A--';
ALTER USER 'base_user'@'localhost' IDENTIFIED BY 'pass0000A--';
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

-- default policy is set, all other component variables set to default Test to
-- ensure that only the privileged user can access the component variables
SET @@global.validate_password.policy=MEDIUM;

-- New connection
connect (plug_con,localhost,user1,pass);
SET @@global.validate_password.policy=LOW;
SET @@global.validate_password.length= 4;
SET @@global.validate_password.special_char_count= 0;
SET @@global.validate_password.mixed_case_count= 0;
CREATE USER 'user2'@'localhost' IDENTIFIED BY 'password';
CREATE USER 'user2'@'localhost' IDENTIFIED BY 'PA00wrd!--';
ALTER USER 'user2'@'localhost' IDENTIFIED BY 'password';
ALTER USER 'user2'@'localhost' IDENTIFIED BY 'PA00wrd!--';
DROP USER 'user2'@'localhost';
DROP USER 'base_user'@'localhost';
DROP USER 'user1'@'localhost';
DROP USER 'user'@'localhost';
SET @@global.validate_password.length=default;
SET @@global.validate_password.number_count=default;
SET @@global.validate_password.mixed_case_count=default;
SET @@global.validate_password.special_char_count=default;
SET @@global.validate_password.policy=default;
SET @@global.validate_password.dictionary_file=default;

SELECT @@validate_password.length,
       @@validate_password.number_count,
       @@validate_password.mixed_case_count,
       @@validate_password.special_char_count,
       @@validate_password.policy,
       @@validate_password.dictionary_file;

SET @@global.validate_password.policy=STRONG;
EOF

--write_file $MYSQLTEST_VARDIR/tmp/dictionary2.txt
password
validate
monkey
EOF

--echo -- No dictionary file, password is accepted
CREATE USER 'user1'@'localhost' IDENTIFIED BY 'passWORD123--';
SELECT VARIABLE_VALUE FROM performance_schema.global_status
  WHERE VARIABLE_NAME = 'validate_password.dictionary_file_words_count';

SELECT VARIABLE_VALUE into @ts1 FROM performance_schema.global_status
  WHERE VARIABLE_NAME = "validate_password.dictionary_file_last_parsed";
SELECT @ts1;
SELECT LENGTH(@ts1);
SELECT VARIABLE_VALUE FROM performance_schema.global_status
  WHERE VARIABLE_NAME = 'validate_password.dictionary_file_words_count';

SELECT VARIABLE_VALUE into @ts2 FROM performance_schema.global_status
  WHERE VARIABLE_NAME = "validate_password.dictionary_file_last_parsed";
SELECT @ts1 <> @ts2;
CREATE USER 'user2'@'localhost' IDENTIFIED BY 'passWORD123--';

SET @@global.validate_password.dictionary_file=NULL;
CREATE USER 'user2'@'localhost' IDENTIFIED BY 'passWORD123--';
SELECT NAME FROM performance_schema.setup_instruments WHERE NAME LIKE '%validate%';
SELECT NAME FROM performance_schema.rwlock_instances WHERE NAME LIKE '%validate%';
DROP USER 'user1'@'localhost', 'user2'@'localhost';
SET @@global.validate_password.policy=DEFAULT;
CREATE ROLE r1;
DROP ROLE r1;

SELECT @@global.session_track_system_variables;
SELECT @@session.session_track_system_variables;

SET @@session.session_track_system_variables='validate_password.policy,autocommit';

SELECT @@session.session_track_system_variables;
SET @@session.session_track_system_variables='validate_password.policy,autocommit';

SELECT VALIDATE_PASSWORD_STRENGTH(REPEAT("aA1--", 26));

SELECT VALIDATE_PASSWORD_STRENGTH(NULL);
SELECT VALIDATE_PASSWORD_STRENGTH('NULL');

-- Write file to make mysql-test-run.pl wait for the server to stop
--exec echo "wait" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect

-- Request shutdown
-- send_shutdown

-- Call script that will poll the server waiting for it to disapear
-- source include/wait_until_disconnected.inc

----echo # Restart server with unknown dictionary file.
--exec echo "restart:--loose-validate_password.dictionary_file=dict.txt" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect

-- Turn on reconnect
--enable_reconnect

-- Call script that will poll the server waiting for it to be back online again
--source include/wait_until_connected_again.inc

-- Turn off reconnect again
--disable_reconnect

-- Generate file of size greater than MAX_DICTIONARY_FILE_LENGTH
--perl EOF
  my $dict_file= "$ENV{MYSQLTEST_VARDIR}/tmp/dict.txt";
  my $outer = 100000;
      print DICT_FILE "validate_password_plugin\n";
  }

  close DICT_FILE;
EOF

-- restarting server second time

-- Write file to make mysql-test-run.pl wait for the server to stop
--exec echo "wait" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect

-- Request shutdown
-- send_shutdown

-- Call script that will poll the server waiting for it to disapear
-- source include/wait_until_disconnected.inc

--echo -- Restart server with file of size greater than MAX_DICTIONARY_FILE_LENGTH
--exec echo "restart:--loose-validate_password.dictionary_file=$MYSQLTEST_VARDIR/tmp/dict.txt" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect

-- Turn on reconnect
--enable_reconnect

-- Call script that will poll the server waiting for it to be back online again
--source include/wait_until_connected_again.inc

-- Turn off reconnect again
--disable_reconnect


--echo --
--echo -- Bug#14850601 - VALIDATE_PASSWORD.LENGTH SHOULD NOT ACCEPT BELOW
--echo --   4 AS ANY WAY NOT ABLE TO SET IT
--echo --

--echo -- default values
SELECT @@GLOBAL.VALIDATE_PASSWORD.LENGTH;
SELECT @@GLOBAL.VALIDATE_PASSWORD.NUMBER_COUNT;
SELECT @@GLOBAL.VALIDATE_PASSWORD.MIXED_CASE_COUNT;
SELECT @@GLOBAL.VALIDATE_PASSWORD.SPECIAL_CHAR_COUNT;
SET @@GLOBAL.VALIDATE_PASSWORD.LENGTH=16;
SELECT @@GLOBAL.VALIDATE_PASSWORD.LENGTH;
SET @@GLOBAL.VALIDATE_PASSWORD.LENGTH=3;
SELECT @@GLOBAL.VALIDATE_PASSWORD.LENGTH;
SET @@GLOBAL.VALIDATE_PASSWORD.MIXED_CASE_COUNT=2;
SELECT @@GLOBAL.VALIDATE_PASSWORD.LENGTH;
SET @@GLOBAL.VALIDATE_PASSWORD.NUMBER_COUNT=3;
SELECT @@GLOBAL.VALIDATE_PASSWORD.LENGTH;
SET @@GLOBAL.VALIDATE_PASSWORD.SPECIAL_CHAR_COUNT=4;
SELECT @@GLOBAL.VALIDATE_PASSWORD.LENGTH;
SET @@GLOBAL.VALIDATE_PASSWORD.MIXED_CASE_COUNT=1;
SELECT @@GLOBAL.VALIDATE_PASSWORD.LENGTH;
SET @@GLOBAL.VALIDATE_PASSWORD.NUMBER_COUNT=1;
SELECT @@GLOBAL.VALIDATE_PASSWORD.LENGTH;
SET @@GLOBAL.VALIDATE_PASSWORD.SPECIAL_CHAR_COUNT=1;
SELECT @@GLOBAL.VALIDATE_PASSWORD.LENGTH;
SET @@GLOBAL.VALIDATE_PASSWORD.LENGTH=8;
SELECT @@GLOBAL.VALIDATE_PASSWORD.LENGTH;
SELECT @@GLOBAL.VALIDATE_PASSWORD.NUMBER_COUNT;
SELECT @@GLOBAL.VALIDATE_PASSWORD.MIXED_CASE_COUNT;
SELECT @@GLOBAL.VALIDATE_PASSWORD.SPECIAL_CHAR_COUNT;
SET @a='Aaaaaaaaa1!';
SELECT VALIDATE_PASSWORD_STRENGTH(@a);
SET PASSWORD= '';
SET PASSWORD='';

-- checking for empty password string in sha256 mode
--error ER_NOT_VALID_PASSWORD
CREATE USER 'sha256user'@'localhost' IDENTIFIED WITH sha256_password;
CREATE USER passtest@localhost;
CREATE TABLE test.t1 (a int);
CREATE USER 'passtest'@'localhost' IDENTIFIED WITH 'caching_sha2_password' AS '';
DROP TABLE test.t1;

SET @@global.validate_password.policy=STRONG;
EOF

--replace_result $MYSQLTEST_VARDIR MYSQLTEST_VARDIR
eval SET @@global.validate_password.dictionary_file="$MYSQLTEST_VARDIR/tmp/dictionary.txt";

SELECT VALIDATE_PASSWORD_STRENGTH( 0x6E616E646F73617135234552 );
SELECT VALIDATE_PASSWORD_STRENGTH( 0xae4fb3774143790d0036033d6e );

SET @@global.validate_password.policy=DEFAULT;

CREATE USER 'passtest'@'localhost' IDENTIFIED BY 'My!Complex@Passw0rd';
DROP USER 'passtest'@'localhost';

SET NAMES utf8mb3;

SELECT VALIDATE_PASSWORD_STRENGTH(CAST(0xd2 AS CHAR(10)));
SELECT VALIDATE_PASSWORD_STRENGTH(CAST(0xd2 AS BINARY(10)));
SELECT export_set('a','a','a','a','a');
SELECT isnull(export_set('a','a','a','a','a'));

SET @@GLOBAL.VALIDATE_PASSWORD.POLICY=STRONG;
SET @@GLOBAL.VALIDATE_PASSWORD.NUMBER_COUNT= 1;
SET @@GLOBAL.VALIDATE_PASSWORD.MIXED_CASE_COUNT= 1;
SET @@GLOBAL.VALIDATE_PASSWORD.SPECIAL_CHAR_COUNT= 1;
SET @@GLOBAL.VALIDATE_PASSWORD.LENGTH= 8;
create user user@localhost identified by 'ABCabc1!';
SET @@GLOBAL.VALIDATE_PASSWORD.POLICY=MEDIUM;
DROP USER 'user'@'localhost';
