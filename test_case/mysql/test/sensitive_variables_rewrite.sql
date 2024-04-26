
-- make sure we start with a clean slate. log_tables.test says this is OK.
TRUNCATE TABLE mysql.general_log;

LET old_log_output=          `select @@global.log_output`;
LET old_general_log=         `select @@global.general_log`;
LET old_general_log_file=    `select @@global.general_log_file`;

SELECT @@session.autocommit INTO @save_session_autocommit;
SELECT @@session.debug_sensitive_session_string INTO @save_debug_sensitive_session_string;
SET GLOBAL log_output =       'FILE,TABLE';
SET GLOBAL general_log=       'ON';

SET @@session.debug_sensitive_session_string= "haha";
SET @@session.autocommit = 0, @@session.debug_sensitive_session_string= "haha";
SET GLOBAL test_component.sensitive_string_1 = "haha";
SET PERSIST test_component.sensitive_string_2 = "haha";
SET PERSIST_ONLY test_component.sensitive_ro_string_1 = 'haha';
SET @@session.debug_sensitive_session_string = @save_debug_sensitive_session_string;
SET @@session.autocommit= @save_session_autocommit;
SELECT COUNT(*) FROM mysql.general_log WHERE argument LIKE ('%haha%');
SELECT COUNT(*) FROM mysql.general_log WHERE argument LIKE ('%REDACTED%');
SELECT argument FROM mysql.general_log WHERE argument LIKE ('SET%');
let $MYSQLD_DATADIR= `select @@datadir`;
