CREATE USER wl13469_no_privilege;
SELECT @@global.test_component.sensitive_string_1;
SELECT @@session.test_component.sensitive_string_1;
SELECT @@global.test_component.sensitive_ro_string_1;
SELECT @@session.test_component.sensitive_ro_string_1;

SELECT @@session.session_track_system_variables INTO @save_session_track_system_variables;
SELECT @@session.autocommit INTO @save_session_autocommit;
SET @@session.session_track_system_variables='autocommit, debug_sensitive_session_string';
SET @@session.autocommit= 1;
SET @@session.autocommit= 0;
SET @@session.debug_sensitive_session_string= "haha";
SET @@session.autocommit= @save_session_autocommit;
SET @@session.session_track_system_variables= @save_session_track_system_variables;
DROP USER wl13469_no_privilege;

CREATE USER wl13469_with_privilege;

SELECT @@global.test_component.sensitive_string_1;
SELECT @@session.test_component.sensitive_string_1;

SELECT @@global.test_component.sensitive_ro_string_1;
SELECT @@session.test_component.sensitive_ro_string_1;
SET GLOBAL test_component.sensitive_string_1 = 'haha';
SET GLOBAL test_component.sensitive_string_2 = 'hoho';
SET GLOBAL test_component.sensitive_string_3 = 'hehe';
SET GLOBAL debug_sensitive_session_string = 'hehe';
SET PERSIST test_component.sensitive_string_1 = 'haha';
SET PERSIST test_component.sensitive_string_2 = 'hoho';
SET PERSIST test_component.sensitive_string_3 = 'hehe';
SET PERSIST debug_sensitive_session_string = 'hehe';
SET PERSIST_ONLY test_component.sensitive_string_1 = 'haha';
SET PERSIST_ONLY test_component.sensitive_string_2 = 'hoho';
SET PERSIST_ONLY test_component.sensitive_string_3 = 'hehe';
SET PERSIST_ONLY debug_sensitive_session_string = 'hehe';
SET PERSIST_ONLY test_component.sensitive_ro_string_1 = 'haha';
SET PERSIST_ONLY test_component.sensitive_ro_string_2 = 'hoho';
SET PERSIST_ONLY test_component.sensitive_ro_string_3 = 'hehe';
SELECT @@session.session_track_system_variables INTO @save_session_track_system_variables;
SELECT @@session.autocommit INTO @save_session_autocommit;
SELECT @@session.debug_sensitive_session_string INTO @save_debug_sensitive_session_string;
SET @@session.session_track_system_variables='autocommit, debug_sensitive_session_string';
SET @@session.autocommit= 1;
SET @@session.autocommit= 0;

SET @@session.debug_sensitive_session_string= "haha";
SET @@session.debug_sensitive_session_string= "hoho";
SET @@session.debug_sensitive_session_string = @save_debug_sensitive_session_string;
SET @@session.autocommit= @save_session_autocommit;
SET @@session.session_track_system_variables= @save_session_track_system_variables;
DROP USER wl13469_with_privilege;
