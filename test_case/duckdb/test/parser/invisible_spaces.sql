PRAGMA enable_verification;
SELEC ;
 ;
S;
SELECT 42;;
SELECT${unicode_space}42;;
SELECT${unicode_space}strlen('${unicode_space}')>=2;;
SELECT${unicode_space}strlen(' ''${unicode_space}')>=4;;
SELECT${unicode_space} -- ${unicode_space};
42;
SELECT${unicode_space}42${unicode_space}${unicode_space}${unicode_space}${unicode_space}${unicode_space};
SELECT a${unicode_space} FROM (SELECT 42) t(a);;
