--    innodb_buffer_pool_size is set explicitly from mysqld_default.cnf #
--    Expected source : EXPLICIT                                        #
--#######################################################################
--echo -- Install test component
INSTALL COMPONENT "file://component_test_system_variable_source";

-- echo -- Print source value of innodb_buffer_pool_size
let $MYSQLD_DATADIR= `select @@datadir`;
--    innodb_buffer_pool_size is set from command line                  #
--    Expected source : COMMAND_LINE                                    #
--#######################################################################
let $restart_parameters = restart: --innodb_dedicated_server=OFF --innodb_buffer_pool_size=24M --skip-mysqlx;

-- echo -- Print source value of innodb_buffer_pool_size
let $MYSQLD_DATADIR= `select @@datadir`;
--    innodb_buffer_pool_size is set dynamically                        #
--    Expected source : DYNAMIC                                         #
--#######################################################################
--disable_warnings
SET GLOBAL innodb_buffer_pool_size=134217728;

-- echo -- Print source value of innodb_buffer_pool_size
let $MYSQLD_DATADIR= `select @@datadir`;
--    innodb_buffer_pool_size is set from no where                      #
--    Expected source : COMPILED                                        #
--#######################################################################
-- Set variables to be used in parameters of mysqld.
let $MYSQLD_DATADIR= `SELECT @@datadir`;
let $MYSQL_BASEDIR= `SELECT @@basedir`;
let $MYSQL_SOCKET= `SELECT @@socket`;
let $MYSQL_PIDFILE= `SELECT @@pid_file`;
let $MYSQL_PORT= `SELECT @@port`;
let $MYSQL_MESSAGESDIR= `SELECT @@lc_messages_dir`;
let $MYSQL_SERVER_ID= `SELECT @@server_id`;

-- echo -- Print source value of innodb_buffer_pool_size
let $MYSQLD_DATADIR= `select @@datadir`;

-- restore default values
let $restart_parameters = restart:;
