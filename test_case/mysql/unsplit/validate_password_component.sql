SELECT VALIDATE_PASSWORD_STRENGTH('');
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
SELECT @@global.session_track_system_variables;
SELECT @@session.session_track_system_variables;
SELECT @@session.session_track_system_variables;
SELECT export_set('a','a','a','a','a');
SELECT isnull(export_set('a','a','a','a','a'));
