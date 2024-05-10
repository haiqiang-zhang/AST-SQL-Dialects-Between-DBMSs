SELECT VALIDATE_PASSWORD_STRENGTH('');
SELECT VALIDATE_PASSWORD_STRENGTH('pass');
SELECT VALIDATE_PASSWORD_STRENGTH('password');
SELECT VALIDATE_PASSWORD_STRENGTH('password0000');
SELECT VALIDATE_PASSWORD_STRENGTH('password1A#');
SELECT VALIDATE_PASSWORD_STRENGTH('PA12wrd!#');
SELECT VALIDATE_PASSWORD_STRENGTH('PA00wrd!#');
SELECT VALIDATE_PASSWORD_STRENGTH('PA12wrd!#');
SELECT VARIABLE_VALUE FROM performance_schema.global_status
  WHERE VARIABLE_NAME = 'validate_password_dictionary_file_words_count';
SELECT VARIABLE_VALUE into @ts1 FROM performance_schema.global_status
  WHERE VARIABLE_NAME = "validate_password_dictionary_file_last_parsed";
SELECT @ts1;
SELECT LENGTH(@ts1);
SELECT VARIABLE_VALUE FROM performance_schema.global_status
  WHERE VARIABLE_NAME = 'validate_password_dictionary_file_words_count';
SELECT VARIABLE_VALUE into @ts2 FROM performance_schema.global_status
  WHERE VARIABLE_NAME = "validate_password_dictionary_file_last_parsed";
SELECT @ts1 <> @ts2;
