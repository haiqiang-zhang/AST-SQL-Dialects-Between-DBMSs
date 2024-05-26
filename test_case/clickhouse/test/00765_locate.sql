SELECT '-- negative tests';
SELECT '-- test mysql compatibility setting';
SELECT locate('abcabc', 'ca');
SELECT locate('abcabc', 'ca') SETTINGS function_locate_has_mysql_compatible_argument_order = true;
SELECT locate('abcabc', 'ca') SETTINGS function_locate_has_mysql_compatible_argument_order = false;
SELECT '-- the function name needs to be case-insensitive for historical reasons';
SELECT LoCaTe('abcabc', 'ca');
