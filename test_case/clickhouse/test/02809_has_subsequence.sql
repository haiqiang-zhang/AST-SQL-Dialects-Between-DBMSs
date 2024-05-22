select 'hasSubsequence';
select hasSubsequence('garbage', '');
select hasSubsequence('garbage', 'g');
select hasSubsequence('garbage', 'G');
select hasSubsequence('garbage', 'a');
select hasSubsequence('garbage', 'e');
select hasSubsequence('garbage', 'gr');
select hasSubsequence('garbage', 'ab');
select hasSubsequence('garbage', 'be');
select hasSubsequence('garbage', 'arg');
select hasSubsequence('garbage', 'gra');
select hasSubsequence('garbage', 'rga');
select hasSubsequence('garbage', 'garbage');
select hasSubsequence('garbage', 'garbage1');
select hasSubsequence('garbage', 'arbw');
select hasSubsequence('garbage', 'ARG');
select hasSubsequence('garbage', materialize(''));
select hasSubsequence('garbage', materialize('arg'));
select hasSubsequence('garbage', materialize('arbw'));
select hasSubsequence(materialize('garbage'), '');
select hasSubsequence(materialize('garbage'), 'arg');
select hasSubsequence(materialize('garbage'), 'arbw');
select hasSubsequence(materialize('garbage'), materialize(''));
select hasSubsequence(materialize('garbage'), materialize('arg'));
select hasSubsequence(materialize('garbage'), materialize('garbage1'));
select 'hasSubsequenceCaseInsensitive';
select hasSubsequenceCaseInsensitive('garbage', 'w');
select hasSubsequenceCaseInsensitive('garbage', 'ARG');
select hasSubsequenceCaseInsensitive('GARGAGE', 'arg');
select hasSubsequenceCaseInsensitive(materialize('garbage'), materialize('w'));
select hasSubsequenceCaseInsensitive(materialize('garbage'), materialize('ARG'));
select hasSubsequenceCaseInsensitive(materialize('GARGAGE'), materialize('arg'));
select 'hasSubsequenceUTF8';
select hasSubsequence('ClickHouse - ÃÂÃÂÃÂ¾ÃÂ»ÃÂ±ÃÂÃÂ¾ÃÂ²ÃÂ°ÃÂ ÃÂÃÂ¸ÃÂÃÂÃÂµÃÂ¼ÃÂ° ÃÂÃÂ¿ÃÂÃÂ°ÃÂ²ÃÂ»ÃÂµÃÂ½ÃÂ¸ÃÂ ÃÂ±ÃÂ°ÃÂ·ÃÂ°ÃÂ¼ÃÂ¸ ÃÂ´ÃÂ°ÃÂ½ÃÂ½ÃÂÃÂ', '');
select hasSubsequence('ClickHouse - ÃÂÃÂÃÂ¾ÃÂ»ÃÂ±ÃÂÃÂ¾ÃÂ²ÃÂ°ÃÂ ÃÂÃÂ¸ÃÂÃÂÃÂµÃÂ¼ÃÂ° ÃÂÃÂ¿ÃÂÃÂ°ÃÂ²ÃÂ»ÃÂµÃÂ½ÃÂ¸ÃÂ ÃÂ±ÃÂ°ÃÂ·ÃÂ°ÃÂ¼ÃÂ¸ ÃÂ´ÃÂ°ÃÂ½ÃÂ½ÃÂÃÂ', 'C');
select hasSubsequence('ClickHouse - ÃÂÃÂÃÂ¾ÃÂ»ÃÂ±ÃÂÃÂ¾ÃÂ²ÃÂ°ÃÂ ÃÂÃÂ¸ÃÂÃÂÃÂµÃÂ¼ÃÂ° ÃÂÃÂ¿ÃÂÃÂ°ÃÂ²ÃÂ»ÃÂµÃÂ½ÃÂ¸ÃÂ ÃÂ±ÃÂ°ÃÂ·ÃÂ°ÃÂ¼ÃÂ¸ ÃÂ´ÃÂ°ÃÂ½ÃÂ½ÃÂÃÂ', 'ÃÂ¡');
select hasSubsequence('ClickHouse - ÃÂÃÂÃÂ¾ÃÂ»ÃÂ±ÃÂÃÂ¾ÃÂ²ÃÂ°ÃÂ ÃÂÃÂ¸ÃÂÃÂÃÂµÃÂ¼ÃÂ° ÃÂÃÂ¿ÃÂÃÂ°ÃÂ²ÃÂ»ÃÂµÃÂ½ÃÂ¸ÃÂ ÃÂ±ÃÂ°ÃÂ·ÃÂ°ÃÂ¼ÃÂ¸ ÃÂ´ÃÂ°ÃÂ½ÃÂ½ÃÂÃÂ', 'House');
select hasSubsequence('ClickHouse - ÃÂÃÂÃÂ¾ÃÂ»ÃÂ±ÃÂÃÂ¾ÃÂ²ÃÂ°ÃÂ ÃÂÃÂ¸ÃÂÃÂÃÂµÃÂ¼ÃÂ° ÃÂÃÂ¿ÃÂÃÂ°ÃÂ²ÃÂ»ÃÂµÃÂ½ÃÂ¸ÃÂ ÃÂ±ÃÂ°ÃÂ·ÃÂ°ÃÂ¼ÃÂ¸ ÃÂ´ÃÂ°ÃÂ½ÃÂ½ÃÂÃÂ', 'house');
select hasSubsequence('ClickHouse - ÃÂÃÂÃÂ¾ÃÂ»ÃÂ±ÃÂÃÂ¾ÃÂ²ÃÂ°ÃÂ ÃÂÃÂ¸ÃÂÃÂÃÂµÃÂ¼ÃÂ° ÃÂÃÂ¿ÃÂÃÂ°ÃÂ²ÃÂ»ÃÂµÃÂ½ÃÂ¸ÃÂ ÃÂ±ÃÂ°ÃÂ·ÃÂ°ÃÂ¼ÃÂ¸ ÃÂ´ÃÂ°ÃÂ½ÃÂ½ÃÂÃÂ', 'ÃÂÃÂ¸ÃÂÃÂÃÂµÃÂ¼ÃÂ°');
select hasSubsequence('ClickHouse - ÃÂÃÂÃÂ¾ÃÂ»ÃÂ±ÃÂÃÂ¾ÃÂ²ÃÂ°ÃÂ ÃÂÃÂ¸ÃÂÃÂÃÂµÃÂ¼ÃÂ° ÃÂÃÂ¿ÃÂÃÂ°ÃÂ²ÃÂ»ÃÂµÃÂ½ÃÂ¸ÃÂ ÃÂ±ÃÂ°ÃÂ·ÃÂ°ÃÂ¼ÃÂ¸ ÃÂ´ÃÂ°ÃÂ½ÃÂ½ÃÂÃÂ', 'ÃÂ¡ÃÂ¸ÃÂÃÂÃÂµÃÂ¼ÃÂ°');
select hasSubsequence('ClickHouse - ÃÂÃÂÃÂ¾ÃÂ»ÃÂ±ÃÂÃÂ¾ÃÂ²ÃÂ°ÃÂ ÃÂÃÂ¸ÃÂÃÂÃÂµÃÂ¼ÃÂ° ÃÂÃÂ¿ÃÂÃÂ°ÃÂ²ÃÂ»ÃÂµÃÂ½ÃÂ¸ÃÂ ÃÂ±ÃÂ°ÃÂ·ÃÂ°ÃÂ¼ÃÂ¸ ÃÂ´ÃÂ°ÃÂ½ÃÂ½ÃÂÃÂ', 'ÃÂÃÂÃÂÃÂ±ÃÂ´');
select hasSubsequence(materialize('ClickHouse - ÃÂÃÂÃÂ¾ÃÂ»ÃÂ±ÃÂÃÂ¾ÃÂ²ÃÂ°ÃÂ ÃÂÃÂ¸ÃÂÃÂÃÂµÃÂ¼ÃÂ° ÃÂÃÂ¿ÃÂÃÂ°ÃÂ²ÃÂ»ÃÂµÃÂ½ÃÂ¸ÃÂ ÃÂ±ÃÂ°ÃÂ·ÃÂ°ÃÂ¼ÃÂ¸ ÃÂ´ÃÂ°ÃÂ½ÃÂ½ÃÂÃÂ'), 'ÃÂÃÂÃÂ±ÃÂ´');
select hasSubsequence(materialize('ClickHouse - ÃÂÃÂÃÂ¾ÃÂ»ÃÂ±ÃÂÃÂ¾ÃÂ²ÃÂ°ÃÂ ÃÂÃÂ¸ÃÂÃÂÃÂµÃÂ¼ÃÂ° ÃÂÃÂ¿ÃÂÃÂ°ÃÂ²ÃÂ»ÃÂµÃÂ½ÃÂ¸ÃÂ ÃÂ±ÃÂ°ÃÂ·ÃÂ°ÃÂ¼ÃÂ¸ ÃÂ´ÃÂ°ÃÂ½ÃÂ½ÃÂÃÂ'), 'ÃÂÃÂÃÂ±ÃÂ±ÃÂ´');
select hasSubsequence('ClickHouse - ÃÂÃÂÃÂ¾ÃÂ»ÃÂ±ÃÂÃÂ¾ÃÂ²ÃÂ°ÃÂ ÃÂÃÂ¸ÃÂÃÂÃÂµÃÂ¼ÃÂ° ÃÂÃÂ¿ÃÂÃÂ°ÃÂ²ÃÂ»ÃÂµÃÂ½ÃÂ¸ÃÂ ÃÂ±ÃÂ°ÃÂ·ÃÂ°ÃÂ¼ÃÂ¸ ÃÂ´ÃÂ°ÃÂ½ÃÂ½ÃÂÃÂ', materialize('ÃÂÃÂÃÂÃÂ»'));
select hasSubsequence('ClickHouse - ÃÂÃÂÃÂ¾ÃÂ»ÃÂ±ÃÂÃÂ¾ÃÂ²ÃÂ°ÃÂ ÃÂÃÂ¸ÃÂÃÂÃÂµÃÂ¼ÃÂ° ÃÂÃÂ¿ÃÂÃÂ°ÃÂ²ÃÂ»ÃÂµÃÂ½ÃÂ¸ÃÂ ÃÂ±ÃÂ°ÃÂ·ÃÂ°ÃÂ¼ÃÂ¸ ÃÂ´ÃÂ°ÃÂ½ÃÂ½ÃÂÃÂ', materialize('ÃÂ´ÃÂ²ÃÂ° ÃÂÃÂÃÂÃÂ»ÃÂ°'));
select hasSubsequence(materialize('ClickHouse - ÃÂÃÂÃÂ¾ÃÂ»ÃÂ±ÃÂÃÂ¾ÃÂ²ÃÂ°ÃÂ ÃÂÃÂ¸ÃÂÃÂÃÂµÃÂ¼ÃÂ° ÃÂÃÂ¿ÃÂÃÂ°ÃÂ²ÃÂ»ÃÂµÃÂ½ÃÂ¸ÃÂ ÃÂ±ÃÂ°ÃÂ·ÃÂ°ÃÂ¼ÃÂ¸ ÃÂ´ÃÂ°ÃÂ½ÃÂ½ÃÂÃÂ'), materialize('ÃÂ¾ÃÂÃÂµÃÂ'));
select hasSubsequence(materialize('ClickHouse - ÃÂÃÂÃÂ¾ÃÂ»ÃÂ±ÃÂÃÂ¾ÃÂ²ÃÂ°ÃÂ ÃÂÃÂ¸ÃÂÃÂÃÂµÃÂ¼ÃÂ° ÃÂÃÂ¿ÃÂÃÂ°ÃÂ²ÃÂ»ÃÂµÃÂ½ÃÂ¸ÃÂ ÃÂ±ÃÂ°ÃÂ·ÃÂ°ÃÂ¼ÃÂ¸ ÃÂ´ÃÂ°ÃÂ½ÃÂ½ÃÂÃÂ'), materialize('ÃÂ´ÃÂ²ÃÂ° ÃÂ¾ÃÂÃÂµÃÂÃÂ°'));
select 'hasSubsequenceCaseInsensitiveUTF8';
select hasSubsequenceCaseInsensitiveUTF8('ÃÂ´ÃÂ»ÃÂ ÃÂ¾ÃÂ½ÃÂ»ÃÂ°ÃÂ¹ÃÂ½ ÃÂ¾ÃÂ±ÃÂÃÂ°ÃÂ±ÃÂ¾ÃÂÃÂºÃÂ¸ ÃÂ°ÃÂ½ÃÂ°ÃÂ»ÃÂ¸ÃÂÃÂ¸ÃÂÃÂµÃÂÃÂºÃÂ¸ÃÂ ÃÂ·ÃÂ°ÃÂ¿ÃÂÃÂ¾ÃÂÃÂ¾ÃÂ² (OLAP)', 'oltp');
select hasSubsequenceCaseInsensitiveUTF8('ÃÂ´ÃÂ»ÃÂ ÃÂ¾ÃÂ½ÃÂ»ÃÂ°ÃÂ¹ÃÂ½ ÃÂ¾ÃÂ±ÃÂÃÂ°ÃÂ±ÃÂ¾ÃÂÃÂºÃÂ¸ ÃÂ°ÃÂ½ÃÂ°ÃÂ»ÃÂ¸ÃÂÃÂ¸ÃÂÃÂµÃÂÃÂºÃÂ¸ÃÂ ÃÂ·ÃÂ°ÃÂ¿ÃÂÃÂ¾ÃÂÃÂ¾ÃÂ² (OLAP)', 'ÃÂ¾ÃÂÃÂ¾ÃÂÃÂ¾O');
select hasSubsequenceCaseInsensitiveUTF8('ÃÂ´ÃÂ»ÃÂ ÃÂ¾ÃÂ½ÃÂ»ÃÂ°ÃÂ¹ÃÂ½ ÃÂ¾ÃÂ±ÃÂÃÂ°ÃÂ±ÃÂ¾ÃÂÃÂºÃÂ¸ ÃÂ°ÃÂ½ÃÂ°ÃÂ»ÃÂ¸ÃÂÃÂ¸ÃÂÃÂµÃÂÃÂºÃÂ¸ÃÂ ÃÂ·ÃÂ°ÃÂ¿ÃÂÃÂ¾ÃÂÃÂ¾ÃÂ² (OLAP)', 'ÃÂ ÃÂÃÂ°ÃÂ±');
select hasSubsequenceCaseInsensitiveUTF8(materialize('ÃÂ´ÃÂ»ÃÂ ÃÂ¾ÃÂ½ÃÂ»ÃÂ°ÃÂ¹ÃÂ½ ÃÂ¾ÃÂ±ÃÂÃÂ°ÃÂ±ÃÂ¾ÃÂÃÂºÃÂ¸ ÃÂ°ÃÂ½ÃÂ°ÃÂ»ÃÂ¸ÃÂÃÂ¸ÃÂÃÂµÃÂÃÂºÃÂ¸ÃÂ ÃÂ·ÃÂ°ÃÂ¿ÃÂÃÂ¾ÃÂÃÂ¾ÃÂ² (OLAP)'), 'ÃÂÃÂ°ÃÂ±ÃÂ¾ÃÂÃÂ°');
select hasSubsequenceCaseInsensitiveUTF8(materialize('ÃÂ´ÃÂ»ÃÂ ÃÂ¾ÃÂ½ÃÂ»ÃÂ°ÃÂ¹ÃÂ½ ÃÂ¾ÃÂ±ÃÂÃÂ°ÃÂ±ÃÂ¾ÃÂÃÂºÃÂ¸ ÃÂ°ÃÂ½ÃÂ°ÃÂ»ÃÂ¸ÃÂÃÂ¸ÃÂÃÂµÃÂÃÂºÃÂ¸ÃÂ ÃÂ·ÃÂ°ÃÂ¿ÃÂÃÂ¾ÃÂÃÂ¾ÃÂ² (OLAP)'), 'work');
select hasSubsequenceCaseInsensitiveUTF8('ÃÂ´ÃÂ»ÃÂ ÃÂ¾ÃÂ½ÃÂ»ÃÂ°ÃÂ¹ÃÂ½ ÃÂ¾ÃÂ±ÃÂÃÂ°ÃÂ±ÃÂ¾ÃÂÃÂºÃÂ¸ ÃÂ°ÃÂ½ÃÂ°ÃÂ»ÃÂ¸ÃÂÃÂ¸ÃÂÃÂµÃÂÃÂºÃÂ¸ÃÂ ÃÂ·ÃÂ°ÃÂ¿ÃÂÃÂ¾ÃÂÃÂ¾ÃÂ² (OLAP)', materialize('ÃÂ´ÃÂ¾ÃÂ±ÃÂÃÂ¾)'));
select hasSubsequenceCaseInsensitiveUTF8('ÃÂ´ÃÂ»ÃÂ ÃÂ¾ÃÂ½ÃÂ»ÃÂ°ÃÂ¹ÃÂ½ ÃÂ¾ÃÂ±ÃÂÃÂ°ÃÂ±ÃÂ¾ÃÂÃÂºÃÂ¸ ÃÂ°ÃÂ½ÃÂ°ÃÂ»ÃÂ¸ÃÂÃÂ¸ÃÂÃÂµÃÂÃÂºÃÂ¸ÃÂ ÃÂ·ÃÂ°ÃÂ¿ÃÂÃÂ¾ÃÂÃÂ¾ÃÂ² (OLAP)', materialize('ÃÂ·ÃÂ»ÃÂ¾()'));
select hasSubsequenceCaseInsensitiveUTF8(materialize('ÃÂ´ÃÂ»ÃÂ ÃÂ¾ÃÂ½ÃÂ»ÃÂ°ÃÂ¹ÃÂ½ ÃÂ¾ÃÂ±ÃÂÃÂ°ÃÂ±ÃÂ¾ÃÂÃÂºÃÂ¸ ÃÂ°ÃÂ½ÃÂ°ÃÂ»ÃÂ¸ÃÂÃÂ¸ÃÂÃÂµÃÂÃÂºÃÂ¸ÃÂ ÃÂ·ÃÂ°ÃÂ¿ÃÂÃÂ¾ÃÂÃÂ¾ÃÂ² (OLAP)'), materialize('ÃÂ°ÃÂ½ÃÂ°ÃÂ»ÃÂ¸ÃÂÃÂ¸ÃÂºÃÂ°'));
select hasSubsequenceCaseInsensitiveUTF8(materialize('ÃÂ´ÃÂ»ÃÂ ÃÂ¾ÃÂ½ÃÂ»ÃÂ°ÃÂ¹ÃÂ½ ÃÂ¾ÃÂ±ÃÂÃÂ°ÃÂ±ÃÂ¾ÃÂÃÂºÃÂ¸ ÃÂ°ÃÂ½ÃÂ°ÃÂ»ÃÂ¸ÃÂÃÂ¸ÃÂÃÂµÃÂÃÂºÃÂ¸ÃÂ ÃÂ·ÃÂ°ÃÂ¿ÃÂÃÂ¾ÃÂÃÂ¾ÃÂ² (OLAP)'), materialize('ÃÂ°ÃÂ½ÃÂ°ÃÂ»ÃÂ¸ÃÂÃÂ¸ÃÂºÃÂ° ÃÂ´ÃÂ»ÃÂ ÃÂ°ÃÂ½ÃÂ°ÃÂ»ÃÂ¸ÃÂÃÂ¸ÃÂºÃÂ¾ÃÂ²'));
select 'Nullable';
select hasSubsequence(Null, Null);
select hasSubsequence(Null, 'a');
select hasSubsequence(Null::Nullable(String), 'arg'::Nullable(String));
select hasSubsequence('garbage'::Nullable(String), 'a');
select hasSubsequence('garbage'::Nullable(String), 'arg'::Nullable(String));
select hasSubsequence(materialize('garbage'::Nullable(String)), materialize('arg'::Nullable(String)));
