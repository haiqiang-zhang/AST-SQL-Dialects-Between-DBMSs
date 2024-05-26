SELECT * FROM VARCHAR_TBL;
SELECT c.*
   FROM VARCHAR_TBL c
   WHERE c.f1 <> 'a';
SELECT c.*
   FROM VARCHAR_TBL c
   WHERE c.f1 = 'a';
SELECT c.*
   FROM VARCHAR_TBL c
   WHERE c.f1 < 'a';
SELECT c.*
   FROM VARCHAR_TBL c
   WHERE c.f1 <= 'a';
SELECT c.*
   FROM VARCHAR_TBL c
   WHERE c.f1 > 'a';
SELECT c.*
   FROM VARCHAR_TBL c
   WHERE c.f1 >= 'a';
DROP TABLE VARCHAR_TBL;
SELECT pg_input_is_valid('abcd  ', 'varchar(4)');
SELECT * FROM pg_input_error_info('abcde', 'varchar(4)');
