
-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

--echo -- Simple load test
INSTALL COMPONENT "file://component_example_component1";

-- echo -- Unload not existing
--error ER_COMPONENTS_UNLOAD_NOT_LOADED
UNINSTALL COMPONENT "file://component_example_component4";

-- echo -- Unload not loaded
--error ER_COMPONENTS_UNLOAD_NOT_LOADED
UNINSTALL COMPONENT "file://component_example_component1";

-- echo -- Load/unload group of components without dependencies
INSTALL COMPONENT "file://component_example_component1", "file://component_example_component2";

-- echo -- Load/unload group of components with dependencies
INSTALL COMPONENT "file://component_example_component1", "file://component_example_component3";
SELECT COUNT(*) FROM mysql.component;
SELECT COUNT(*) FROM mysql.component;
SELECT COUNT(*) FROM mysql.component;
SELECT COUNT(*) FROM mysql.component;
SELECT COUNT(*) FROM mysql.component;
SELECT COUNT(*) FROM mysql.component;
CREATE USER mysqltest_u1@localhost;
DROP USER mysqltest_u1@localhost;

SET @@session.insert_id=42949672950;
SET @@session.insert_id=0;
ALTER TABLE mysql.component AUTO_INCREMENT=1;
