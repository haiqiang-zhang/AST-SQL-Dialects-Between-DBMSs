--               code of t/handler.test and t/innodb_handler.test united
--               main testing code put into include/handler.inc
--               rename t/innodb_handler.test to t/handler_innodb.test
--

-- Need MyISAM to support assign_to_keycache
--source include/force_myisam_default.inc
--source include/have_myisam.inc


let $engine_type= InnoDB;
let $other_engine_type= MEMORY;
let $other_handler_engine_type= MyISAM;
