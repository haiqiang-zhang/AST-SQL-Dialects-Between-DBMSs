SELECT VALIDATE_PASSWORD_STRENGTH('');
SELECT VALIDATE_PASSWORD_STRENGTH('pass');
SELECT VALIDATE_PASSWORD_STRENGTH('password');
SELECT VALIDATE_PASSWORD_STRENGTH('password0000');
SELECT VALIDATE_PASSWORD_STRENGTH('password1A#');
SELECT VALIDATE_PASSWORD_STRENGTH('PA12wrd!#');
SELECT VALIDATE_PASSWORD_STRENGTH('PA00wrd!#');
SELECT VALIDATE_PASSWORD_STRENGTH('PA12wrd!#');
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
SELECT VALIDATE_PASSWORD_STRENGTH(REPEAT("aA1#", 26));
SELECT VALIDATE_PASSWORD_STRENGTH(NULL);
SELECT VALIDATE_PASSWORD_STRENGTH('NULL');
SELECT VALIDATE_PASSWORD_STRENGTH(@a);
SELECT VALIDATE_PASSWORD_STRENGTH( 0x6E616E646F73617135234552 );
SELECT VALIDATE_PASSWORD_STRENGTH( 0xae4fb3774143790d0036033d6e );
SELECT VALIDATE_PASSWORD_STRENGTH(CAST(0xd2 AS CHAR(10)));
SELECT VALIDATE_PASSWORD_STRENGTH(CAST(0xd2 AS BINARY(10)));
SELECT export_set('a','a','a','a','a');
SELECT isnull(export_set('a','a','a','a','a'));
