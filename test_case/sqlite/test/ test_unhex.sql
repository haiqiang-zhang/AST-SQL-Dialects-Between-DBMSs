SELECT typeof( unhex('') ), length( unhex('') );
SELECT typeof( unhex(' ', ' -') ), length( unhex('-', ' -') );
SELECT hex( unhex('ÃÂÃÂ ÃÂÃÂ¸ÃÂÃÂABCDÃÂÃÂ ÃÂÃÂ¸ÃÂÃÂ', 'ÃÂÃÂ ÃÂÃÂ¸ÃÂÃÂÃÂÃÂ ÃÂÃÂ¸ÃÂÃÂ') );
SELECT typeof( unhex('ÃÂÃÂ ÃÂÃÂ¸ÃÂÃÂABCDÃÂÃÂ ÃÂÃÂ¸ÃÂÃÂ', 'ÃÂÃÂ ÃÂÃÂ¸ÃÂÃÂÃÂÃÂ ÃÂÃÂ¸ÃÂÃÂ') );
SELECT hex( unhex('ÃÂÃÂ ÃÂÃÂ¸ÃÂÃÂAB CDÃÂÃÂ ÃÂÃÂ¸ÃÂÃÂÃÂÃÂ ÃÂÃÂ¸ÃÂÃÂ', 'ÃÂÃÂ ÃÂÃÂ¸ÃÂÃÂ ÃÂÃÂ ÃÂÃÂ¸ÃÂÃÂ') );
SELECT typeof(unhex(NULL));
SELECT typeof(unhex(NULL, ' '));
SELECT typeof(unhex('1234', NULL));
