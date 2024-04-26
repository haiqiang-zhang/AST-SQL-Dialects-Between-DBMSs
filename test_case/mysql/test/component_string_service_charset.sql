SET character_set_client= 'utf8mb3';
SET character_set_connection= 'utf8mb3';
SET character_set_results= 'utf8mb3';

SET character_set_client= 'latin1';
SET character_set_connection= 'latin1';
SET character_set_results= 'latin1';
SET NAMES 'latin1';

-- Write the test results in "test_string_service_charset.log" into the result file of this test
--echo --######### test_string_service_charset.log: 
let $MYSQLD_DATADIR= `select @@datadir`;
