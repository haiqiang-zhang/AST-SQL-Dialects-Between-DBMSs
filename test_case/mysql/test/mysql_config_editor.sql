
-- Note : a) mtr sets the 'MYSQL_TEST_LOGIN_FILE' environment
--           variable to "$opt_tmpdir/.mylogin.cnf".
--        b) The --password option in not tested as its
--           value cannot be specified at command line.

--echo --###############################################
--echo -- Tests for mysql_config_editor's insert command
--echo --###############################################
--echo --
--echo -- Default login path (client)
--exec $MYSQL_CONFIG_EDITOR set --user=test_user1 --host=localhost
--echo -- done..
--echo -- 'test-login-path1'
--exec $MYSQL_CONFIG_EDITOR set --login-path=test-login-path1 --user=test_user2 --host=127.0.0.1 
--echo -- done..
--echo -- 'test-login-path2'
--exec $MYSQL_CONFIG_EDITOR set --login-path=test-login-path2 --user=test_user3 --host=www.mysql.com
--echo -- done..
--echo -- 'test-login-path3'
--exec $MYSQL_CONFIG_EDITOR set --login-path=test-login-path3 --user=test_user4 --host=127.0.0.1 --socket=/tmp/configtest.sock --port=15000
--echo -- done..

--echo
--echo --###############################################
--echo -- Tests for mysql_config_editor's print command
--echo --###############################################
--echo --
--echo -- Default path
--exec $MYSQL_CONFIG_EDITOR print 2>&1
--echo
--echo --
--echo -- test-login-path1
--exec $MYSQL_CONFIG_EDITOR print --login-path=test-login-path1 2>&1
--echo
--echo --
--echo -- test-login-path2
--exec $MYSQL_CONFIG_EDITOR print --login-path=test-login-path2 2>&1
--echo
--echo --
--echo -- all the paths
--exec $MYSQL_CONFIG_EDITOR print --all 2>&1
--echo 
--echo --
--echo -- Overwrite existing paths, test-login-path2 & default
--exec $MYSQL_CONFIG_EDITOR set --user=test_user4 --login-path=test-login-path2 --skip-warn
--exec $MYSQL_CONFIG_EDITOR set --user=test_user5 --skip-warn
--echo --
--echo -- all the paths again
--exec $MYSQL_CONFIG_EDITOR print --all 2>&1

--echo 
--echo --###############################################
--echo -- Tests for mysql_config_editor's remove command
--echo --###############################################
--echo --
--echo -- Default path
--exec $MYSQL_CONFIG_EDITOR remove --skip-warn
--echo -- done..
--echo -- test-login-path1
--exec $MYSQL_CONFIG_EDITOR remove --login-path=test-login-path1
--echo -- done..
--echo -- test-login-path3
--exec $MYSQL_CONFIG_EDITOR remove --login-path=test-login-path3 --socket --port
--echo -- done..

--echo
--echo --#######################
--echo -- Printing the leftovers
--echo --#######################
--echo --
--echo -- using all
--exec $MYSQL_CONFIG_EDITOR print --all

--echo
--echo --##############################################
--echo -- Tests for mysql_config_editor's reset command
--echo --##############################################
--exec $MYSQL_CONFIG_EDITOR reset
--echo -- done..
--echo -- Print-all to check if everything got deleted.
--exec $MYSQL_CONFIG_EDITOR print --all

--echo
--echo --#############################################
--echo -- Tests for mysql_config_editor's help command
--echo --#############################################
--replace_regex /.*mysql_config_editor.*\n// /.*Output debug log.*\n// /.*This is a non.debug version.*\n//
--exec $MYSQL_CONFIG_EDITOR help 2>&1
--echo -- done..

--echo
--echo --#####################
--echo -- Testing client tools
--echo --#####################
--echo --
--echo -- Inserting login paths default & test-login-path1
--exec $MYSQL_CONFIG_EDITOR --verbose set --user=test_user1 --host=localhost 2>&1
--exec $MYSQL_CONFIG_EDITOR --verbose set --login-path=test-login-path1 --user=test_user2 --host=127.0.0.1 2>&1
--exec $MYSQL_CONFIG_EDITOR --verbose set --login-path=test-login-path2 --user=test_user3 --host=127.0.0.1 --socket=/tmp/configtest.sock --port=15000 2>&1
--echo -- done..
--echo
--echo -- Connecting using 'test_user1'
--echo --
--error 1
--exec $MYSQL 2>&1
--echo
--echo -- Connecting using 'test_user2'
--echo --
--error 1
--exec $MYSQL --login-path=test-login-path1 2>&1

--echo -- Creating user 'test_user1'
CREATE USER test_user1;
CREATE USER test_user2;

-- Cleanup
--echo
--echo -- Dropping users 'test_user1' & 'test_user2'
DROP USER test_user1, test_user2;
CREATE USER user_name_len_25_01234567@localhost;
CREATE USER user_name_len_26_012345678@localhost;

-- Cleanup
--echo
--echo -- Dropping users 'user_name_len_25_01234567@localhost' & 'CREATE USER user_name_len_26_012345678@localhost'
DROP USER user_name_len_25_01234567@localhost,user_name_len_26_012345678@localhost;

CREATE USER 'test--user1'@'localhost';
DROP USER 'test--user1'@'localhost';

CREATE USER 'test1 test1'@'localhost';
DROP USER 'test1 test1'@'localhost';
