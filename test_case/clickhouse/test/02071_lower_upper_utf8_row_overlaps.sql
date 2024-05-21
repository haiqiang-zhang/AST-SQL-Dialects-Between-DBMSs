drop table if exists utf8_overlap;
create table utf8_overlap (str String) engine=Memory();
-- NOTE: total string size should be > 16 (sizeof(__m128i))
insert into utf8_overlap values ('\xe2'), ('FooÃ¢ÂÂBarBazBam'), ('\xe2'), ('FooÃ¢ÂÂBarBazBam');
-- https://github.com/ClickHouse/ClickHouse/issues/42756
SELECT lowerUTF8('ÃÂÃÂ ÃÂÃÂ ÃÂ ÃÂ¡ÃÂ');
SELECT upperUTF8('ÃÂºÃÂ² ÃÂ°ÃÂ¼ ÃÂ¸ ÃÂÃÂ¶');
SELECT lowerUTF8('ÃÂÃÂ ÃÂÃÂ ÃÂ ÃÂ¡ÃÂ ÃÂÃÂ ÃÂÃÂ ÃÂ ÃÂ¡ÃÂ');
SELECT upperUTF8('ÃÂºÃÂ² ÃÂ°ÃÂ¼ ÃÂ¸ ÃÂÃÂ¶ ÃÂºÃÂ² ÃÂ°ÃÂ¼ ÃÂ¸ ÃÂÃÂ¶');
SELECT lowerUTF8(repeat('0', 16) || 'ÃÂÃÂ ÃÂÃÂ ÃÂ ÃÂ¡ÃÂ');
SELECT upperUTF8(repeat('0', 16) || 'ÃÂºÃÂ² ÃÂ°ÃÂ¼ ÃÂ¸ ÃÂÃÂ¶');
SELECT lowerUTF8(repeat('0', 48) || 'ÃÂÃÂ ÃÂÃÂ ÃÂ ÃÂ¡ÃÂ');
SELECT upperUTF8(repeat('0', 48) || 'ÃÂºÃÂ² ÃÂ°ÃÂ¼ ÃÂ¸ ÃÂÃÂ¶');
