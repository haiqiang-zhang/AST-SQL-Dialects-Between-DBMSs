SELECT positionCaseInsensitiveUTF8(concat('ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat(' ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('  ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('   ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('    ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('     ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('      ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('       ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('        ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('         ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('          ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('           ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('            ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('             ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('              ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('               ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('                ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('                 ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('                  ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('                   ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('                    ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('                     ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(concat('                      ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat(' ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('  ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('   ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('    ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('     ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('      ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('       ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('        ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('         ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('          ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('           ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('            ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('             ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('              ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('               ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('                ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('                 ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('                  ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('                   ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('                    ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('                     ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitive(concat('                      ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionUTF8(concat('ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionUTF8(concat(' ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionUTF8(concat('  ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionUTF8(concat('   ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionUTF8(concat('    ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionUTF8(concat('     ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionUTF8(concat('      ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionUTF8(concat('       ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionUTF8(concat('        ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionUTF8(concat('         ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionUTF8(concat('          ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionUTF8(concat('           ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionUTF8(concat('            ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionUTF8(concat('             ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionUTF8(concat('              ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionUTF8(concat('               ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionUTF8(concat('                ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionUTF8(concat('                 ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionUTF8(concat('                  ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionUTF8(concat('                   ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionUTF8(concat('                    ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionUTF8(concat('                     ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionUTF8(concat('                      ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT position(concat('ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT position(concat(' ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT position(concat('  ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT position(concat('   ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT position(concat('    ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT position(concat('     ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT position(concat('      ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT position(concat('       ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT position(concat('        ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT position(concat('         ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT position(concat('          ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT position(concat('           ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT position(concat('            ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT position(concat('             ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT position(concat('              ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT position(concat('               ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT position(concat('                ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT position(concat('                 ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT position(concat('                  ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT position(concat('                   ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT position(concat('                    ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT position(concat('                     ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT position(concat('                      ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ', arrayStringConcat(arrayMap(x -> ' ', range(20000)))), 'ÃÂÃÂ¸ÃÂÃÂ³ÃÂÃÂ¾ÃÂÃÂ»ÃÂÃÂºÃÂÃÂ°.ÃÂÃÂÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(materialize('test ÃÂÃÂ test'), 'ÃÂÃÂ') AS res;
SELECT positionCaseInsensitiveUTF8(materialize('test AaÃÂÃÂAa test'), 'aÃÂÃÂa') AS res;
SELECT positionCaseInsensitiveUTF8(materialize('test A1ÃÂÃÂ2a test'), '1ÃÂÃÂ2') AS res;
SELECT positionCaseInsensitiveUTF8(materialize('xÃÂ¡ÃÂºÃÂyyaa1ÃÂ¡ÃÂºÃÂ1yzÃÂ¡ÃÂºÃÂXÃÂ¡ÃÂºÃÂÃÂ¡ÃÂºÃÂ1ÃÂ¡ÃÂºÃÂÃÂ¡ÃÂºÃÂ1bctest'), 'aa1ÃÂ¡ÃÂºÃÂ1YzÃÂÃÂxÃÂÃÂÃÂÃÂ1ÃÂÃÂÃÂÃÂ1BC') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('test a1ÃÂÃÂAa test', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'a1ÃÂ¡ÃÂºÃÂaa') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat(' test a1ÃÂÃÂAa test', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'a1ÃÂ¡ÃÂºÃÂaa') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('  test a1ÃÂÃÂAa test', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'a1ÃÂ¡ÃÂºÃÂaa') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('   test a1ÃÂÃÂAa test', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'a1ÃÂ¡ÃÂºÃÂaa') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('    test a1ÃÂÃÂAa test', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'a1ÃÂ¡ÃÂºÃÂaa') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('     test a1ÃÂÃÂAa test', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'a1ÃÂ¡ÃÂºÃÂaa') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('      test a1ÃÂÃÂAa test', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'a1ÃÂ¡ÃÂºÃÂaa') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('       test a1ÃÂÃÂAa test', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'a1ÃÂ¡ÃÂºÃÂaa') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('        test a1ÃÂÃÂAa test', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'a1ÃÂ¡ÃÂºÃÂaa') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('         test a1ÃÂÃÂAa test', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'a1ÃÂ¡ÃÂºÃÂaa') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('          test a1ÃÂÃÂAa test', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'a1ÃÂ¡ÃÂºÃÂaa') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('           test a1ÃÂÃÂAa test', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'a1ÃÂ¡ÃÂºÃÂaa') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('xÃÂ¡ÃÂºÃÂyyaa1ÃÂ¡ÃÂºÃÂ1yzÃÂ¡ÃÂºÃÂXÃÂ¡ÃÂºÃÂÃÂ¡ÃÂºÃÂ1ÃÂ¡ÃÂºÃÂÃÂ¡ÃÂºÃÂ1bctest', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'aa1ÃÂ¡ÃÂºÃÂ1YzÃÂÃÂxÃÂÃÂÃÂÃÂ1ÃÂÃÂÃÂÃÂ1BC') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat(' xÃÂ¡ÃÂºÃÂyyaa1ÃÂ¡ÃÂºÃÂ1yzÃÂ¡ÃÂºÃÂXÃÂ¡ÃÂºÃÂÃÂ¡ÃÂºÃÂ1ÃÂ¡ÃÂºÃÂÃÂ¡ÃÂºÃÂ1bctest', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'aa1ÃÂ¡ÃÂºÃÂ1YzÃÂÃÂxÃÂÃÂÃÂÃÂ1ÃÂÃÂÃÂÃÂ1BC') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('  xÃÂ¡ÃÂºÃÂyyaa1ÃÂ¡ÃÂºÃÂ1yzÃÂ¡ÃÂºÃÂXÃÂ¡ÃÂºÃÂÃÂ¡ÃÂºÃÂ1ÃÂ¡ÃÂºÃÂÃÂ¡ÃÂºÃÂ1bctest', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'aa1ÃÂ¡ÃÂºÃÂ1YzÃÂÃÂxÃÂÃÂÃÂÃÂ1ÃÂÃÂÃÂÃÂ1BC') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('   xÃÂ¡ÃÂºÃÂyyaa1ÃÂ¡ÃÂºÃÂ1yzÃÂ¡ÃÂºÃÂXÃÂ¡ÃÂºÃÂÃÂ¡ÃÂºÃÂ1ÃÂ¡ÃÂºÃÂÃÂ¡ÃÂºÃÂ1bctest', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'aa1ÃÂ¡ÃÂºÃÂ1YzÃÂÃÂxÃÂÃÂÃÂÃÂ1ÃÂÃÂÃÂÃÂ1BC') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('    xÃÂ¡ÃÂºÃÂyyaa1ÃÂ¡ÃÂºÃÂ1yzÃÂ¡ÃÂºÃÂXÃÂ¡ÃÂºÃÂÃÂ¡ÃÂºÃÂ1ÃÂ¡ÃÂºÃÂÃÂ¡ÃÂºÃÂ1bctest', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'aa1ÃÂ¡ÃÂºÃÂ1YzÃÂÃÂxÃÂÃÂÃÂÃÂ1ÃÂÃÂÃÂÃÂ1BC') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('     xÃÂ¡ÃÂºÃÂyyaa1ÃÂ¡ÃÂºÃÂ1yzÃÂ¡ÃÂºÃÂXÃÂ¡ÃÂºÃÂÃÂ¡ÃÂºÃÂ1ÃÂ¡ÃÂºÃÂÃÂ¡ÃÂºÃÂ1bctest', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'aa1ÃÂ¡ÃÂºÃÂ1YzÃÂÃÂxÃÂÃÂÃÂÃÂ1ÃÂÃÂÃÂÃÂ1BC') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('      xÃÂ¡ÃÂºÃÂyyaa1ÃÂ¡ÃÂºÃÂ1yzÃÂ¡ÃÂºÃÂXÃÂ¡ÃÂºÃÂÃÂ¡ÃÂºÃÂ1ÃÂ¡ÃÂºÃÂÃÂ¡ÃÂºÃÂ1bctest', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'aa1ÃÂ¡ÃÂºÃÂ1YzÃÂÃÂxÃÂÃÂÃÂÃÂ1ÃÂÃÂÃÂÃÂ1BC') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('       xÃÂ¡ÃÂºÃÂyyaa1ÃÂ¡ÃÂºÃÂ1yzÃÂ¡ÃÂºÃÂXÃÂ¡ÃÂºÃÂÃÂ¡ÃÂºÃÂ1ÃÂ¡ÃÂºÃÂÃÂ¡ÃÂºÃÂ1bctest', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'aa1ÃÂ¡ÃÂºÃÂ1YzÃÂÃÂxÃÂÃÂÃÂÃÂ1ÃÂÃÂÃÂÃÂ1BC') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('        xÃÂ¡ÃÂºÃÂyyaa1ÃÂ¡ÃÂºÃÂ1yzÃÂ¡ÃÂºÃÂXÃÂ¡ÃÂºÃÂÃÂ¡ÃÂºÃÂ1ÃÂ¡ÃÂºÃÂÃÂ¡ÃÂºÃÂ1bctest', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'aa1ÃÂ¡ÃÂºÃÂ1YzÃÂÃÂxÃÂÃÂÃÂÃÂ1ÃÂÃÂÃÂÃÂ1BC') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('         xÃÂ¡ÃÂºÃÂyyaa1ÃÂ¡ÃÂºÃÂ1yzÃÂ¡ÃÂºÃÂXÃÂ¡ÃÂºÃÂÃÂ¡ÃÂºÃÂ1ÃÂ¡ÃÂºÃÂÃÂ¡ÃÂºÃÂ1bctest', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'aa1ÃÂ¡ÃÂºÃÂ1YzÃÂÃÂxÃÂÃÂÃÂÃÂ1ÃÂÃÂÃÂÃÂ1BC') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('          xÃÂ¡ÃÂºÃÂyyaa1ÃÂ¡ÃÂºÃÂ1yzÃÂ¡ÃÂºÃÂXÃÂ¡ÃÂºÃÂÃÂ¡ÃÂºÃÂ1ÃÂ¡ÃÂºÃÂÃÂ¡ÃÂºÃÂ1bctest', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'aa1ÃÂ¡ÃÂºÃÂ1YzÃÂÃÂxÃÂÃÂÃÂÃÂ1ÃÂÃÂÃÂÃÂ1BC') AS res;
SELECT positionCaseInsensitiveUTF8(materialize(concat('           xÃÂ¡ÃÂºÃÂyyaa1ÃÂ¡ÃÂºÃÂ1yzÃÂ¡ÃÂºÃÂXÃÂ¡ÃÂºÃÂÃÂ¡ÃÂºÃÂ1ÃÂ¡ÃÂºÃÂÃÂ¡ÃÂºÃÂ1bctest', arrayStringConcat(arrayMap(x -> ' ', range(20000))))), 'aa1ÃÂ¡ÃÂºÃÂ1YzÃÂÃÂxÃÂÃÂÃÂÃÂ1ÃÂÃÂÃÂÃÂ1BC') AS res;