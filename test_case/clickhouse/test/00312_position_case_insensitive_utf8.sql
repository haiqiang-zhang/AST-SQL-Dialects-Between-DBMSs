SELECT positionCaseInsensitiveUTF8(concat('ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat(' ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('  ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('   ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('    ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('     ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('      ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('       ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('        ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('         ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('          ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('           ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('            ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('             ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('              ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('               ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('                ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('                 ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('                  ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('                   ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('                    ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('                     ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('                      ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat(' ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('  ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('   ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('    ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('     ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('      ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('       ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('        ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('         ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('          ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('           ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('            ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('             ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('              ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('               ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('                ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('                 ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('                  ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('                   ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('                    ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('                     ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('                      ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionUTF8(concat('ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionUTF8(concat(' ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionUTF8(concat('  ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionUTF8(concat('   ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionUTF8(concat('    ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionUTF8(concat('     ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionUTF8(concat('      ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionUTF8(concat('       ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionUTF8(concat('        ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionUTF8(concat('         ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionUTF8(concat('          ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionUTF8(concat('           ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionUTF8(concat('            ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionUTF8(concat('             ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionUTF8(concat('              ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionUTF8(concat('               ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionUTF8(concat('                ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionUTF8(concat('                 ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionUTF8(concat('                  ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionUTF8(concat('                   ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionUTF8(concat('                    ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionUTF8(concat('                     ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionUTF8(concat('                      ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT position(concat('ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT position(concat(' ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT position(concat('  ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT position(concat('   ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT position(concat('    ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT position(concat('     ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT position(concat('      ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT position(concat('       ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT position(concat('        ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT position(concat('         ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT position(concat('          ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT position(concat('           ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT position(concat('            ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT position(concat('             ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT position(concat('              ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT position(concat('               ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT position(concat('                ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT position(concat('                 ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT position(concat('                  ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT position(concat('                   ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT position(concat('                    ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT position(concat('                     ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT position(concat('                      ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂ¸ÃÂ³ÃÂ¾ÃÂ»ÃÂºÃÂ°.ÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(materialize('test ÃÂ test'), 'ÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(materialize('test AaÃÂAa test'), 'aÃÂa') AS res;
SELECT positionCaseInsensitiveUTF8(materialize('test A1ÃÂ2a test'), '1ÃÂ2') AS res;
SELECT positionCaseInsensitiveUTF8(materialize('xÃ¡ÂºÂyyaa1Ã¡ÂºÂ1yzÃ¡ÂºÂXÃ¡ÂºÂÃ¡ÂºÂ1Ã¡ÂºÂÃ¡ÂºÂ1bctest'), 'aa1Ã¡ÂºÂ1YzÃÂxÃÂÃÂ1ÃÂÃÂ1BC') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('test a1ÃÂAa test', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'a1Ã¡ÂºÂaa') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat(' test a1ÃÂAa test', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'a1Ã¡ÂºÂaa') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('  test a1ÃÂAa test', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'a1Ã¡ÂºÂaa') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('   test a1ÃÂAa test', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'a1Ã¡ÂºÂaa') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('    test a1ÃÂAa test', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'a1Ã¡ÂºÂaa') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('     test a1ÃÂAa test', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'a1Ã¡ÂºÂaa') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('      test a1ÃÂAa test', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'a1Ã¡ÂºÂaa') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('       test a1ÃÂAa test', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'a1Ã¡ÂºÂaa') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('        test a1ÃÂAa test', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'a1Ã¡ÂºÂaa') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('         test a1ÃÂAa test', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'a1Ã¡ÂºÂaa') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('          test a1ÃÂAa test', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'a1Ã¡ÂºÂaa') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('           test a1ÃÂAa test', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'a1Ã¡ÂºÂaa') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('xÃ¡ÂºÂyyaa1Ã¡ÂºÂ1yzÃ¡ÂºÂXÃ¡ÂºÂÃ¡ÂºÂ1Ã¡ÂºÂÃ¡ÂºÂ1bctest', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'aa1Ã¡ÂºÂ1YzÃÂxÃÂÃÂ1ÃÂÃÂ1BC') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat(' xÃ¡ÂºÂyyaa1Ã¡ÂºÂ1yzÃ¡ÂºÂXÃ¡ÂºÂÃ¡ÂºÂ1Ã¡ÂºÂÃ¡ÂºÂ1bctest', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'aa1Ã¡ÂºÂ1YzÃÂxÃÂÃÂ1ÃÂÃÂ1BC') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('  xÃ¡ÂºÂyyaa1Ã¡ÂºÂ1yzÃ¡ÂºÂXÃ¡ÂºÂÃ¡ÂºÂ1Ã¡ÂºÂÃ¡ÂºÂ1bctest', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'aa1Ã¡ÂºÂ1YzÃÂxÃÂÃÂ1ÃÂÃÂ1BC') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('   xÃ¡ÂºÂyyaa1Ã¡ÂºÂ1yzÃ¡ÂºÂXÃ¡ÂºÂÃ¡ÂºÂ1Ã¡ÂºÂÃ¡ÂºÂ1bctest', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'aa1Ã¡ÂºÂ1YzÃÂxÃÂÃÂ1ÃÂÃÂ1BC') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('    xÃ¡ÂºÂyyaa1Ã¡ÂºÂ1yzÃ¡ÂºÂXÃ¡ÂºÂÃ¡ÂºÂ1Ã¡ÂºÂÃ¡ÂºÂ1bctest', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'aa1Ã¡ÂºÂ1YzÃÂxÃÂÃÂ1ÃÂÃÂ1BC') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('     xÃ¡ÂºÂyyaa1Ã¡ÂºÂ1yzÃ¡ÂºÂXÃ¡ÂºÂÃ¡ÂºÂ1Ã¡ÂºÂÃ¡ÂºÂ1bctest', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'aa1Ã¡ÂºÂ1YzÃÂxÃÂÃÂ1ÃÂÃÂ1BC') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('      xÃ¡ÂºÂyyaa1Ã¡ÂºÂ1yzÃ¡ÂºÂXÃ¡ÂºÂÃ¡ÂºÂ1Ã¡ÂºÂÃ¡ÂºÂ1bctest', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'aa1Ã¡ÂºÂ1YzÃÂxÃÂÃÂ1ÃÂÃÂ1BC') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('       xÃ¡ÂºÂyyaa1Ã¡ÂºÂ1yzÃ¡ÂºÂXÃ¡ÂºÂÃ¡ÂºÂ1Ã¡ÂºÂÃ¡ÂºÂ1bctest', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'aa1Ã¡ÂºÂ1YzÃÂxÃÂÃÂ1ÃÂÃÂ1BC') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('        xÃ¡ÂºÂyyaa1Ã¡ÂºÂ1yzÃ¡ÂºÂXÃ¡ÂºÂÃ¡ÂºÂ1Ã¡ÂºÂÃ¡ÂºÂ1bctest', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'aa1Ã¡ÂºÂ1YzÃÂxÃÂÃÂ1ÃÂÃÂ1BC') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('         xÃ¡ÂºÂyyaa1Ã¡ÂºÂ1yzÃ¡ÂºÂXÃ¡ÂºÂÃ¡ÂºÂ1Ã¡ÂºÂÃ¡ÂºÂ1bctest', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'aa1Ã¡ÂºÂ1YzÃÂxÃÂÃÂ1ÃÂÃÂ1BC') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('          xÃ¡ÂºÂyyaa1Ã¡ÂºÂ1yzÃ¡ÂºÂXÃ¡ÂºÂÃ¡ÂºÂ1Ã¡ÂºÂÃ¡ÂºÂ1bctest', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'aa1Ã¡ÂºÂ1YzÃÂxÃÂÃÂ1ÃÂÃÂ1BC') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('           xÃ¡ÂºÂyyaa1Ã¡ÂºÂ1yzÃ¡ÂºÂXÃ¡ÂºÂÃ¡ÂºÂ1Ã¡ÂºÂÃ¡ÂºÂ1bctest', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'aa1Ã¡ÂºÂ1YzÃÂxÃÂÃÂ1ÃÂÃÂ1BC') AS res;
