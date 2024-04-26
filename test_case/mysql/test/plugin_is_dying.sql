
SELECT PLUGIN_NAME, PLUGIN_STATUS, LOAD_OPTION from INFORMATION_SCHEMA.PLUGINS
  WHERE PLUGIN_NAME like 'pfs_example%';

SET DEBUG_SYNC='in_plugin_initialize WAIT_FOR go_init';

-- Wait for INSTALL PLUGIN to hit in_plugin_initialize
let $wait_condition= SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PLUGINS
                     WHERE PLUGIN_NAME like 'pfs_example%' and
                     PLUGIN_STATUS='INACTIVE';

-- Observe the INACTIVE status

--disable_result_log
SHOW PLUGINS;

SELECT PLUGIN_NAME, PLUGIN_STATUS, LOAD_OPTION from INFORMATION_SCHEMA.PLUGINS
  WHERE PLUGIN_NAME like 'pfs_example%';

SET DEBUG_SYNC='now SIGNAL go_init';

-- Wait for INSTALL PLUGIN to complete
let $wait_condition= SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PLUGINS
                     WHERE PLUGIN_NAME like 'pfs_example%' and
                     PLUGIN_STATUS='ACTIVE';

-- Observe the ACTIVE status

--disable_result_log
SHOW PLUGINS;

SELECT PLUGIN_NAME, PLUGIN_STATUS, LOAD_OPTION from INFORMATION_SCHEMA.PLUGINS
  WHERE PLUGIN_NAME like 'pfs_example%';

SET DEBUG_SYNC='in_plugin_check_uninstall WAIT_FOR go_deinit';

-- Wait for UNINSTALL PLUGIN to hit in_plugin_check_uninstall
let $wait_condition= SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PLUGINS
                     WHERE PLUGIN_NAME like 'pfs_example%' and
                     PLUGIN_STATUS ='DELETING';

-- Observe the DELETING status

--disable_result_log
SHOW PLUGINS;

SELECT PLUGIN_NAME, PLUGIN_STATUS, LOAD_OPTION from INFORMATION_SCHEMA.PLUGINS
  WHERE PLUGIN_NAME like 'pfs_example%';

SET DEBUG_SYNC='now SIGNAL go_deinit';

-- Observe the plugin is gone

--disable_result_log
SHOW PLUGINS;

SELECT PLUGIN_NAME, PLUGIN_STATUS, LOAD_OPTION from INFORMATION_SCHEMA.PLUGINS
  WHERE PLUGIN_NAME like 'pfs_example%';
