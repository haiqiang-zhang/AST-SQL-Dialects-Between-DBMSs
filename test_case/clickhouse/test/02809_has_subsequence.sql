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
select hasSubsequence('ClickHouse - ÑÑÐ¾Ð»Ð±ÑÐ¾Ð²Ð°Ñ ÑÐ¸ÑÑÐµÐ¼Ð° ÑÐ¿ÑÐ°Ð²Ð»ÐµÐ½Ð¸Ñ Ð±Ð°Ð·Ð°Ð¼Ð¸ Ð´Ð°Ð½Ð½ÑÑ', '');
select hasSubsequence('ClickHouse - ÑÑÐ¾Ð»Ð±ÑÐ¾Ð²Ð°Ñ ÑÐ¸ÑÑÐµÐ¼Ð° ÑÐ¿ÑÐ°Ð²Ð»ÐµÐ½Ð¸Ñ Ð±Ð°Ð·Ð°Ð¼Ð¸ Ð´Ð°Ð½Ð½ÑÑ', 'C');
select hasSubsequence('ClickHouse - ÑÑÐ¾Ð»Ð±ÑÐ¾Ð²Ð°Ñ ÑÐ¸ÑÑÐµÐ¼Ð° ÑÐ¿ÑÐ°Ð²Ð»ÐµÐ½Ð¸Ñ Ð±Ð°Ð·Ð°Ð¼Ð¸ Ð´Ð°Ð½Ð½ÑÑ', 'Ð¡');
select hasSubsequence('ClickHouse - ÑÑÐ¾Ð»Ð±ÑÐ¾Ð²Ð°Ñ ÑÐ¸ÑÑÐµÐ¼Ð° ÑÐ¿ÑÐ°Ð²Ð»ÐµÐ½Ð¸Ñ Ð±Ð°Ð·Ð°Ð¼Ð¸ Ð´Ð°Ð½Ð½ÑÑ', 'House');
select hasSubsequence('ClickHouse - ÑÑÐ¾Ð»Ð±ÑÐ¾Ð²Ð°Ñ ÑÐ¸ÑÑÐµÐ¼Ð° ÑÐ¿ÑÐ°Ð²Ð»ÐµÐ½Ð¸Ñ Ð±Ð°Ð·Ð°Ð¼Ð¸ Ð´Ð°Ð½Ð½ÑÑ', 'house');
select hasSubsequence('ClickHouse - ÑÑÐ¾Ð»Ð±ÑÐ¾Ð²Ð°Ñ ÑÐ¸ÑÑÐµÐ¼Ð° ÑÐ¿ÑÐ°Ð²Ð»ÐµÐ½Ð¸Ñ Ð±Ð°Ð·Ð°Ð¼Ð¸ Ð´Ð°Ð½Ð½ÑÑ', 'ÑÐ¸ÑÑÐµÐ¼Ð°');
select hasSubsequence('ClickHouse - ÑÑÐ¾Ð»Ð±ÑÐ¾Ð²Ð°Ñ ÑÐ¸ÑÑÐµÐ¼Ð° ÑÐ¿ÑÐ°Ð²Ð»ÐµÐ½Ð¸Ñ Ð±Ð°Ð·Ð°Ð¼Ð¸ Ð´Ð°Ð½Ð½ÑÑ', 'Ð¡Ð¸ÑÑÐµÐ¼Ð°');
select hasSubsequence('ClickHouse - ÑÑÐ¾Ð»Ð±ÑÐ¾Ð²Ð°Ñ ÑÐ¸ÑÑÐµÐ¼Ð° ÑÐ¿ÑÐ°Ð²Ð»ÐµÐ½Ð¸Ñ Ð±Ð°Ð·Ð°Ð¼Ð¸ Ð´Ð°Ð½Ð½ÑÑ', 'ÑÑÑÐ±Ð´');
select hasSubsequence(materialize('ClickHouse - ÑÑÐ¾Ð»Ð±ÑÐ¾Ð²Ð°Ñ ÑÐ¸ÑÑÐµÐ¼Ð° ÑÐ¿ÑÐ°Ð²Ð»ÐµÐ½Ð¸Ñ Ð±Ð°Ð·Ð°Ð¼Ð¸ Ð´Ð°Ð½Ð½ÑÑ'), 'ÑÑÐ±Ð´');
select hasSubsequence(materialize('ClickHouse - ÑÑÐ¾Ð»Ð±ÑÐ¾Ð²Ð°Ñ ÑÐ¸ÑÑÐµÐ¼Ð° ÑÐ¿ÑÐ°Ð²Ð»ÐµÐ½Ð¸Ñ Ð±Ð°Ð·Ð°Ð¼Ð¸ Ð´Ð°Ð½Ð½ÑÑ'), 'ÑÑÐ±Ð±Ð´');
select hasSubsequence('ClickHouse - ÑÑÐ¾Ð»Ð±ÑÐ¾Ð²Ð°Ñ ÑÐ¸ÑÑÐµÐ¼Ð° ÑÐ¿ÑÐ°Ð²Ð»ÐµÐ½Ð¸Ñ Ð±Ð°Ð·Ð°Ð¼Ð¸ Ð´Ð°Ð½Ð½ÑÑ', materialize('ÑÑÑÐ»'));
select hasSubsequence('ClickHouse - ÑÑÐ¾Ð»Ð±ÑÐ¾Ð²Ð°Ñ ÑÐ¸ÑÑÐµÐ¼Ð° ÑÐ¿ÑÐ°Ð²Ð»ÐµÐ½Ð¸Ñ Ð±Ð°Ð·Ð°Ð¼Ð¸ Ð´Ð°Ð½Ð½ÑÑ', materialize('Ð´Ð²Ð° ÑÑÑÐ»Ð°'));
select hasSubsequence(materialize('ClickHouse - ÑÑÐ¾Ð»Ð±ÑÐ¾Ð²Ð°Ñ ÑÐ¸ÑÑÐµÐ¼Ð° ÑÐ¿ÑÐ°Ð²Ð»ÐµÐ½Ð¸Ñ Ð±Ð°Ð·Ð°Ð¼Ð¸ Ð´Ð°Ð½Ð½ÑÑ'), materialize('Ð¾ÑÐµÑ'));
select hasSubsequence(materialize('ClickHouse - ÑÑÐ¾Ð»Ð±ÑÐ¾Ð²Ð°Ñ ÑÐ¸ÑÑÐµÐ¼Ð° ÑÐ¿ÑÐ°Ð²Ð»ÐµÐ½Ð¸Ñ Ð±Ð°Ð·Ð°Ð¼Ð¸ Ð´Ð°Ð½Ð½ÑÑ'), materialize('Ð´Ð²Ð° Ð¾ÑÐµÑÐ°'));
select 'hasSubsequenceCaseInsensitiveUTF8';
select hasSubsequenceCaseInsensitiveUTF8('Ð´Ð»Ñ Ð¾Ð½Ð»Ð°Ð¹Ð½ Ð¾Ð±ÑÐ°Ð±Ð¾ÑÐºÐ¸ Ð°Ð½Ð°Ð»Ð¸ÑÐ¸ÑÐµÑÐºÐ¸Ñ Ð·Ð°Ð¿ÑÐ¾ÑÐ¾Ð² (OLAP)', 'oltp');
select hasSubsequenceCaseInsensitiveUTF8('Ð´Ð»Ñ Ð¾Ð½Ð»Ð°Ð¹Ð½ Ð¾Ð±ÑÐ°Ð±Ð¾ÑÐºÐ¸ Ð°Ð½Ð°Ð»Ð¸ÑÐ¸ÑÐµÑÐºÐ¸Ñ Ð·Ð°Ð¿ÑÐ¾ÑÐ¾Ð² (OLAP)', 'Ð¾ÐÐ¾ÐÐ¾O');
select hasSubsequenceCaseInsensitiveUTF8('Ð´Ð»Ñ Ð¾Ð½Ð»Ð°Ð¹Ð½ Ð¾Ð±ÑÐ°Ð±Ð¾ÑÐºÐ¸ Ð°Ð½Ð°Ð»Ð¸ÑÐ¸ÑÐµÑÐºÐ¸Ñ Ð·Ð°Ð¿ÑÐ¾ÑÐ¾Ð² (OLAP)', 'Ñ ÑÐ°Ð±');
select hasSubsequenceCaseInsensitiveUTF8(materialize('Ð´Ð»Ñ Ð¾Ð½Ð»Ð°Ð¹Ð½ Ð¾Ð±ÑÐ°Ð±Ð¾ÑÐºÐ¸ Ð°Ð½Ð°Ð»Ð¸ÑÐ¸ÑÐµÑÐºÐ¸Ñ Ð·Ð°Ð¿ÑÐ¾ÑÐ¾Ð² (OLAP)'), 'ÑÐ°Ð±Ð¾ÑÐ°');
select hasSubsequenceCaseInsensitiveUTF8(materialize('Ð´Ð»Ñ Ð¾Ð½Ð»Ð°Ð¹Ð½ Ð¾Ð±ÑÐ°Ð±Ð¾ÑÐºÐ¸ Ð°Ð½Ð°Ð»Ð¸ÑÐ¸ÑÐµÑÐºÐ¸Ñ Ð·Ð°Ð¿ÑÐ¾ÑÐ¾Ð² (OLAP)'), 'work');
select hasSubsequenceCaseInsensitiveUTF8('Ð´Ð»Ñ Ð¾Ð½Ð»Ð°Ð¹Ð½ Ð¾Ð±ÑÐ°Ð±Ð¾ÑÐºÐ¸ Ð°Ð½Ð°Ð»Ð¸ÑÐ¸ÑÐµÑÐºÐ¸Ñ Ð·Ð°Ð¿ÑÐ¾ÑÐ¾Ð² (OLAP)', materialize('Ð´Ð¾Ð±ÑÐ¾)'));
select hasSubsequenceCaseInsensitiveUTF8('Ð´Ð»Ñ Ð¾Ð½Ð»Ð°Ð¹Ð½ Ð¾Ð±ÑÐ°Ð±Ð¾ÑÐºÐ¸ Ð°Ð½Ð°Ð»Ð¸ÑÐ¸ÑÐµÑÐºÐ¸Ñ Ð·Ð°Ð¿ÑÐ¾ÑÐ¾Ð² (OLAP)', materialize('Ð·Ð»Ð¾()'));
select hasSubsequenceCaseInsensitiveUTF8(materialize('Ð´Ð»Ñ Ð¾Ð½Ð»Ð°Ð¹Ð½ Ð¾Ð±ÑÐ°Ð±Ð¾ÑÐºÐ¸ Ð°Ð½Ð°Ð»Ð¸ÑÐ¸ÑÐµÑÐºÐ¸Ñ Ð·Ð°Ð¿ÑÐ¾ÑÐ¾Ð² (OLAP)'), materialize('Ð°Ð½Ð°Ð»Ð¸ÑÐ¸ÐºÐ°'));
select hasSubsequenceCaseInsensitiveUTF8(materialize('Ð´Ð»Ñ Ð¾Ð½Ð»Ð°Ð¹Ð½ Ð¾Ð±ÑÐ°Ð±Ð¾ÑÐºÐ¸ Ð°Ð½Ð°Ð»Ð¸ÑÐ¸ÑÐµÑÐºÐ¸Ñ Ð·Ð°Ð¿ÑÐ¾ÑÐ¾Ð² (OLAP)'), materialize('Ð°Ð½Ð°Ð»Ð¸ÑÐ¸ÐºÐ° Ð´Ð»Ñ Ð°Ð½Ð°Ð»Ð¸ÑÐ¸ÐºÐ¾Ð²'));
select 'Nullable';
select hasSubsequence(Null, Null);
select hasSubsequence(Null, 'a');
select hasSubsequence(Null::Nullable(String), 'arg'::Nullable(String));
select hasSubsequence('garbage'::Nullable(String), 'a');
select hasSubsequence('garbage'::Nullable(String), 'arg'::Nullable(String));
select hasSubsequence(materialize('garbage'::Nullable(String)), materialize('arg'::Nullable(String)));