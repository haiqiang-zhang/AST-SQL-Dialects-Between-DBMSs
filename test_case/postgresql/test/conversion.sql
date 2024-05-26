COMMENT ON CONVERSION myconv IS 'bar';
COMMENT ON CONVERSION myconv IS NULL;
DROP CONVERSION myconv;
DROP CONVERSION mydef;
RESET SESSION AUTHORIZATION;
create or replace function test_conv(
  input IN bytea,
  src_encoding IN text,
  dst_encoding IN text,

  result OUT bytea,
  errorat OUT bytea,
  error OUT text)
language plpgsql as
$$
declare
  validlen int;
begin
  begin
    select * into validlen, result from test_enc_conversion(input, src_encoding, dst_encoding, false);
    errorat = NULL;
    error := NULL;
  exception when others then
    error := sqlerrm;
    select * into validlen, result from test_enc_conversion(input, src_encoding, dst_encoding, true);
    errorat = substr(input, validlen + 1);
  end;
  return;
end;
$$;
CREATE TABLE utf8_verification_inputs (inbytes bytea, description text PRIMARY KEY);
insert into utf8_verification_inputs  values
  ('\x66006f',	'NUL byte'),
  ('\xaf',		'bare continuation'),
  ('\xc5',		'missing second byte in 2-byte char'),
  ('\xc080',	'smallest 2-byte overlong'),
  ('\xc1bf',	'largest 2-byte overlong'),
  ('\xc280',	'next 2-byte after overlongs'),
  ('\xdfbf',	'largest 2-byte'),
  ('\xe9af',	'missing third byte in 3-byte char'),
  ('\xe08080',	'smallest 3-byte overlong'),
  ('\xe09fbf',	'largest 3-byte overlong'),
  ('\xe0a080',	'next 3-byte after overlong'),
  ('\xed9fbf',	'last before surrogates'),
  ('\xeda080',	'smallest surrogate'),
  ('\xedbfbf',	'largest surrogate'),
  ('\xee8080',	'next after surrogates'),
  ('\xefbfbf',	'largest 3-byte'),
  ('\xf1afbf',	'missing fourth byte in 4-byte char'),
  ('\xf0808080',	'smallest 4-byte overlong'),
  ('\xf08fbfbf',	'largest 4-byte overlong'),
  ('\xf0908080',	'next 4-byte after overlong'),
  ('\xf48fbfbf',	'largest 4-byte'),
  ('\xf4908080',	'smallest too large'),
  ('\xfa9a9a8a8a',	'5-byte');
CREATE TABLE utf8_inputs (inbytes bytea, description text);
insert into utf8_inputs  values
  ('\x666f6f',		'valid, pure ASCII'),
  ('\xc3a4c3b6',	'valid, extra latin chars'),
  ('\xd184d0bed0be',	'valid, cyrillic'),
  ('\x666f6fe8b1a1',	'valid, kanji/Chinese'),
  ('\xe382abe3829a',	'valid, two chars that combine to one in EUC_JIS_2004'),
  ('\xe382ab',		'only first half of combined char in EUC_JIS_2004'),
  ('\xe382abe382',	'incomplete combination when converted EUC_JIS_2004'),
  ('\xecbd94eb81bceba6ac', 'valid, Hangul, Korean'),
  ('\x666f6fefa8aa',	'valid, needs mapping function to convert to GB18030'),
  ('\x66e8b1ff6f6f',	'invalid byte sequence'),
  ('\x66006f',		'invalid, NUL byte'),
  ('\x666f6fe8b100',	'invalid, NUL byte'),
  ('\x666f6fe8b1',	'incomplete character at end');
CREATE TABLE euc_jis_2004_inputs (inbytes bytea, description text);
insert into euc_jis_2004_inputs  values
  ('\x666f6f',		'valid, pure ASCII'),
  ('\x666f6fbedd',	'valid'),
  ('\xa5f7',		'valid, translates to two UTF-8 chars '),
  ('\xbeddbe',		'incomplete char '),
  ('\x666f6f00bedd',	'invalid, NUL byte'),
  ('\x666f6fbe00dd',	'invalid, NUL byte'),
  ('\x666f6fbedd00',	'invalid, NUL byte'),
  ('\xbe04',		'invalid byte sequence');
CREATE TABLE shiftjis2004_inputs (inbytes bytea, description text);
insert into shiftjis2004_inputs  values
  ('\x666f6f',		'valid, pure ASCII'),
  ('\x666f6f8fdb',	'valid'),
  ('\x666f6f81c0',	'valid, no translation to UTF-8'),
  ('\x666f6f82f5',	'valid, translates to two UTF-8 chars '),
  ('\x666f6f8fdb8f',	'incomplete char '),
  ('\x666f6f820a',	'incomplete char, followed by newline '),
  ('\x666f6f008fdb',	'invalid, NUL byte'),
  ('\x666f6f8f00db',	'invalid, NUL byte'),
  ('\x666f6f8fdb00',	'invalid, NUL byte');
CREATE TABLE gb18030_inputs (inbytes bytea, description text);
insert into gb18030_inputs  values
  ('\x666f6f',		'valid, pure ASCII'),
  ('\x666f6fcff3',	'valid'),
  ('\x666f6f8431a530',	'valid, no translation to UTF-8'),
  ('\x666f6f84309c38',	'valid, translates to UTF-8 by mapping function'),
  ('\x666f6f84309c',	'incomplete char '),
  ('\x666f6f84309c0a',	'incomplete char, followed by newline '),
  ('\x666f6f84309c3800', 'invalid, NUL byte'),
  ('\x666f6f84309c0038', 'invalid, NUL byte');
CREATE TABLE iso8859_5_inputs (inbytes bytea, description text);
insert into iso8859_5_inputs  values
  ('\x666f6f',		'valid, pure ASCII'),
  ('\xe4dede',		'valid'),
  ('\x00',		'invalid, NUL byte'),
  ('\xe400dede',	'invalid, NUL byte'),
  ('\xe4dede00',	'invalid, NUL byte');
CREATE TABLE big5_inputs (inbytes bytea, description text);
insert into big5_inputs  values
  ('\x666f6f',		'valid, pure ASCII'),
  ('\x666f6fb648',	'valid'),
  ('\x666f6fa27f',	'valid, no translation to UTF-8'),
  ('\x666f6fb60048',	'invalid, NUL byte'),
  ('\x666f6fb64800',	'invalid, NUL byte');
CREATE TABLE mic_inputs (inbytes bytea, description text);
insert into mic_inputs  values
  ('\x666f6f',		'valid, pure ASCII'),
  ('\x8bc68bcf8bcf',	'valid (in KOI8R)'),
  ('\x8bc68bcf8b',	'invalid,incomplete char'),
  ('\x92bedd',		'valid (in SHIFT_JIS)'),
  ('\x92be',		'invalid, incomplete char)'),
  ('\x666f6f95a3c1',	'valid (in Big5)'),
  ('\x666f6f95a3',	'invalid, incomplete char'),
  ('\x9200bedd',	'invalid, NUL byte'),
  ('\x92bedd00',	'invalid, NUL byte'),
  ('\x8b00c68bcf8bcf',	'invalid, NUL byte');
