select hex(ujis), hex(ucs2), hex(ujis2), name from t1 where ujis=ujis2 order by ujis;
drop table t1;
drop table t2;
create table t1 (
  ujis varchar(1) character set ujis,
  name varchar(64),
  ucs2 varchar(1) character set ucs2,
  ujis2 varchar(1) character set ujis
);
insert into t1 (ujis,name) values (0x5C,     'U+005C REVERSE SOLIDUS');
insert into t1 (ujis,name) values (0x7E,     'U+007E TILDE');
insert into t1 (ujis,name) values (0xA1B1,   'U+FFE3 FULLWIDTH MACRON');
insert into t1 (ujis,name) values (0xA1BD,   'U+2015 HORIZONTAL BAR');
insert into t1 (ujis,name) values (0xA1C0,   'U+005C REVERSE SOLIDUS');
insert into t1 (ujis,name) values (0xA1C1,   'U+301C WAVE DASH');
insert into t1 (ujis,name) values (0xA1C2,   'U+2016 DOUBLE VERTICAL LINE');
insert into t1 (ujis,name) values (0xA1DD,   'U+2212 MINUS SIGN');
insert into t1 (ujis,name) values (0xA1F1,   'U+00A2 CENT SIGN');
insert into t1 (ujis,name) values (0xA1F2,   'U+00A3 POUND SIGN');
insert into t1 (ujis,name) values (0xA1EF,   'U+FFE5 FULLWIDTH YEN SIGN');
insert into t1 (ujis,name) values (0xA2CC,   'U+00AC NOT SIGN');
insert into t1 (ujis,name) values (0x8FA2B7, 'U+007E TILDE');
insert into t1 (ujis,name) values (0x8FA2C3, 'U+00A6 BROKEN BAR');
update t1 set ucs2=ujis, ujis2=ucs2;
drop table t1;
create table t1 (
  ujis char(1) character set ujis,
  ucs2 char(1) character set ucs2,
  name char(64)
);
insert into t1 (ucs2,name) values (0x00A5,'U+00A5 YEN SIGN');
insert into t1 (ucs2,name) values (0x2014,'U+2014 EM DASH');
insert into t1 (ucs2,name) values (0x203E,'U+203E OVERLINE');
insert into t1 (ucs2,name) values (0x2225,'U+2225 PARALLEL TO');
insert into t1 (ucs2,name) values (0xFF0D,'U+FF0D FULLWIDTH HYPHEN-MINUS');
insert into t1 (ucs2,name) values (0xFF3C,'U+FF3C FULLWIDTH REVERSE SOLIDUS');
insert into t1 (ucs2,name) values (0xFF5E,'U+FF5E FULLWIDTH TILDE');
insert into t1 (ucs2,name) values (0xFFE0,'U+FFE0 FULLWIDTH CENT SIGN');
insert into t1 (ucs2,name) values (0xFFE1,'U+FFE1 FULLWIDTH POUND SIGN');
insert into t1 (ucs2,name) values (0xFFE2,'U+FFE2 FULLWIDTH NOT SIGN');
insert into t1 (ucs2,name) values (0xFFE4,'U+FFE4 FULLWIDTH BROKEN BAR');
update ignore t1 set ujis=ucs2;
drop table t1;
