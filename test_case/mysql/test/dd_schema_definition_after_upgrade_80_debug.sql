  -- We must filter out unpredictable values such as root page no and ids.
  -- This simple filter will remove a bit more than strictly necessary.
--let $filter = id|root|MYSQLD_VERSION_LO
--source include/dd_schema_dd_properties.inc

--echo --#######################################################################
--echo -- Stop the running server.
--echo --#######################################################################
--let $shutdown_server_timeout= 300
--source include/shutdown_mysqld.inc

--echo --#######################################################################
--let  $VERSION = 80011
--echo -- Test upgrade from $VERSION.
--echo --#######################################################################
--source include/dd_schema_definition_after_upgrade_debug.inc

--echo --#######################################################################
--let  $VERSION = 80012
--echo -- Test upgrade from $VERSION.
--echo --#######################################################################
--source include/dd_schema_definition_after_upgrade_debug.inc

--echo --#######################################################################
--let  $VERSION = 80013
--echo -- Test upgrade from $VERSION.
--echo --#######################################################################
--source include/dd_schema_definition_after_upgrade_debug.inc

--echo --#######################################################################
--let  $VERSION = 80014
--echo -- Test upgrade from $VERSION.
--echo --#######################################################################
--source include/dd_schema_definition_after_upgrade_debug.inc

--echo --#######################################################################
--let  $VERSION = 80015
--echo -- Test upgrade from $VERSION.
--echo --#######################################################################
--source include/dd_schema_definition_after_upgrade_debug.inc

--echo --#######################################################################
--let  $VERSION = 80016
--echo -- Test upgrade from $VERSION.
--echo --#######################################################################
--source include/dd_schema_definition_after_upgrade_debug.inc

--echo --#######################################################################
--let  $VERSION = 80017
--echo -- Test upgrade from $VERSION.
--echo --#######################################################################
--source include/dd_schema_definition_after_upgrade_debug.inc

--echo --#######################################################################
--let  $VERSION = 80018
--echo -- Test upgrade from $VERSION.
--echo --#######################################################################
--source include/dd_schema_definition_after_upgrade_debug.inc

--echo --#######################################################################
--echo -- Cleanup: Remove definition files and restart with default options.
--echo --#######################################################################
--remove_file $target_table_defs
--remove_file $target_dd_props
let $restart_parameters =;
