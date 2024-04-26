
CREATE TABLE t(id int, vbin1 varbinary(32), vbin2 varbinary(32));
INSERT INTO t VALUES
(1, x'59', x'6a'),
(2, x'5939', x'6ac3'),
(3, x'5939a998', x'6ac35d2a'),
(4, x'5939a99861154f35', x'6ac35d2a3ab34bda'),
(5, x'5939a99861154f3587d5440618e9b28b', x'6ac35d2a3ab34bda8ac412ea0141852c'),
(6, x'5939a99861154f3587d5440618e9b28b166181c5ca514ab1b8e9c970ae5e421a', x'6ac35d2a3ab34bda8ac412ea0141852c3c8e38bb19934a7092a40bb19db13a80'),
(7, x'5939a99861154f3587d5440618e9b28b', x'8ac412ea0141852c'),
(8, x'5939a99861154f35', x'6ac35d2a3ab34bda8ac412ea0141852c');

SELECT HEX(vbin1 & vbin2), HEX(vbin1 | vbin2), HEX(vbin1 ^ vbin2),
  HEX(~vbin1), HEX(vbin1 << 3), HEX(vbin2 >> 3), BIT_COUNT(vbin1)
FROM t
WHERE id in(1,2,3,4,5,6);
SELECT vbin1 & vbin2, vbin1 | vbin2, vbin1 ^ vbin2, ~vbin1, vbin1 << 3, vbin2 >> 3
FROM t
WHERE id in(1,2,3,4,5,6);

SELECT (vbin1 & vbin2)=0x4801090820114B1082C40002004180081400008108114A3090A009308C100200, (vbin1 | vbin2)=0x7BFBFDBA7BB74FFF8FD556EE19E9B7AF3EEFB9FFDBD34AF1BAEDCBF1BFFF7A9A, (vbin1 ^ vbin2)=0x33FAF4B25BA604EF0D1156EC19A837A72AEFB97ED3C200C12A4DC2C133EF789A, (~vbin1)=0xA6C656679EEAB0CA782ABBF9E7164D74E99E7E3A35AEB54E4716368F51A1BDE5, (vbin1 << 3)=0xC9CD4CC308AA79AC3EAA2030C74D9458B30C0E2E528A558DC74E4B8572F210D0, (vbin2 >> 3)=0x0D586BA54756697B5158825D402830A58791C7176332694E1254817633B62750
FROM t
WHERE id in(1,2,3,4,5,6);

select HEX(0x19c9bbcce9e0a88f5212572b0c5b9e6d0 | _binary 0x13c19e5cfdf03b19518cbe3d65faf10d2), HEX(0x19c9bbcce9e0a88f5212572b0c5b9e6d0 ^ _binary 0x13c19e5cfdf03b19518cbe3d65faf10d2),
HEX(0x19c9bbcce9e0a88f5212572b0c5b9e6d0 & _binary 0x13c19e5cfdf03b19518cbe3d65faf10d2), HEX(~ _binary 0x19c9bbcce9e0a88f5212572b0c5b9e6d0), HEX(~ _binary 0x13c19e5cfdf03b19518cbe3d65faf10d2);

SELECT HEX(vbin1 << 3), HEX(vbin2 << 3) FROM t WHERE id=7;
SELECT HEX(vbin1 >> 3), HEX(vbin2 >> 3) FROM t WHERE id=7;
SELECT HEX(~vbin1), HEX(~vbin2) FROM t WHERE id=7;
SELECT HEX(vbin1 << 3), HEX(vbin2 << 3) FROM t WHERE id=8;
SELECT HEX(vbin1 >> 3), HEX(vbin2 >> 3) FROM t WHERE id=8;
SELECT HEX(~vbin1), HEX(~vbin2) FROM t WHERE id=8;
SELECT HEX(vbin1 & vbin2) FROM t WHERE id=7;
SELECT HEX(vbin1 | vbin2) FROM t WHERE id=7;
SELECT HEX(vbin1 ^ vbin2) FROM t WHERE id=7;
SELECT HEX(vbin1 & vbin2) FROM t WHERE id=8;
SELECT HEX(vbin1 | vbin2) FROM t WHERE id=8;
SELECT HEX(vbin1 ^ vbin2) FROM t WHERE id=8;
CREATE TABLE t0(vbin VARBINARY(6), bin BINARY(6));
CREATE TABLE t1  charset utf8mb4
AS SELECT vbin & vbin, vbin & bin, bin & vbin, bin & bin FROM t0;
DROP TABLE t0;
DROP TABLE t1;

DROP TABLE t;

CREATE TABLE networks (
  id int(10) unsigned NOT NULL AUTO_INCREMENT,
  start varbinary(16) NOT NULL,
  end varbinary(16) NOT NULL,
  country_code varchar(2) NOT NULL,
  country varchar(255) NOT NULL,
  PRIMARY KEY (id),
  KEY start (start),
  KEY end (end)
);

INSERT INTO networks(start, end, country_code, country) VALUES
(INET6_ATON('2c0f:fff0::'),INET6_ATON('2c0f:fff0:ffff:ffff:ffff:ffff:ffff:ffff'),'NG','Nigeria'),
(INET6_ATON('2405:1d00::'),INET6_ATON('2405:1d00:ffff:ffff:ffff:ffff:ffff:ffff'),'GR','Greenland'),
(INET6_ATON('2c0f:ffe8::'),INET6_ATON('2c0f:ffe8:ffff:ffff:ffff:ffff:ffff:ffff'),'NG','Nigeria');

SELECT id, HEX(start), HEX(end), country_code, country
FROM networks
WHERE INET6_ATON('2c0f:fff0:1234:5678:9101:1123::') & start = INET6_ATON('2c0f:fff0::');

SELECT id, HEX(start), HEX(end), country_code, country
FROM networks
WHERE INET6_ATON('2c0f:ffe8:1234:5678:9101:1123::') & start = INET6_ATON('2c0f:ffe8::');

SELECT id, HEX(start), HEX(end), country_code, country
FROM networks
WHERE INET6_ATON('2c0f:fff0::') | start = INET6_ATON('2c0f:fff0::');

SELECT id, HEX(start), HEX(end), country_code, country
FROM  networks
WHERE INET6_ATON('2c0f:ffe8::') | start = INET6_ATON('2c0f:ffe8::');

SELECT id, HEX(start), HEX(end), country_code, country
FROM networks
WHERE INET6_ATON('2c0f:fff0::') ^ start = INET6_ATON('::');

SELECT id, HEX(start), HEX(end), country_code, country
FROM networks
WHERE INET6_ATON('2c0f:ffe8::') ^ start = INET6_ATON('::');

DROP TABLE networks;

CREATE TABLE at(_bit bit(64),
                _tin tinyint(8),
                _boo bool,
                _sms smallint signed,
                _smu smallint unsigned,
                _mes mediumint signed,
                _meu mediumint unsigned,
                _ins int signed,
                _inu int unsigned,
                _bis bigint signed,
                _biu bigint unsigned,
                _dec decimal (5,2),
                _flo float,
                _dou double,
                _yea year,
                _jsn json,
                _chr char(12),
                _vch varchar(12),
                _bin binary(255),
                _vbn varbinary(255),
                _tbl tinyblob,
                _ttx tinytext,
                _blb blob,
                _txt text,
                _mbb mediumblob,
                _mtx mediumtext,
                _lbb longblob,
                _ltx longtext,
                _pnt point,
                _dat date default '1988-12-15',
                _dtt datetime default '2015-10-24 12:00:00',
                _smp timestamp default '2015-10-24 14:00:00',
                _tim time default' 07:08:09',
                _enu enum('a', 'b', 'c'),
                _set set('a', 'b', 'c')
                );
INSERT INTO at (
    _bit,
    _tin,
    _boo,
    _sms,
    _smu,
    _mes,
    _meu,
    _ins,
    _inu,
    _bis,
    _biu,
    _dec,
    _flo,
    _dou,
    _yea,
    _jsn,
    _chr,
    _vch,
    _bin,
    _vbn,
    _tbl,
    _ttx,
    _blb,
    _txt,
    _mbb,
    _mtx,
    _lbb,
    _ltx,
    _pnt,
    _enu,
    _set
) VALUES (
    64,
    64,
    true,
    64,
    64,
    64,
    64,
    64,
    64,
    64,
    64,
    64,
    64,
    64,
    2005,
    cast('{"a": 3}' as json),
    "abcdefghijkl",
    "abcdefghijkl",
    x'CAFEBABE000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000CAFEBABE11111111',
    x'CAFEBABE00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011111111CAFEBABE',
    x'CAFEBABE000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000CAFE1111CAFE1111',
    "abcdefg",
    x'cafebabe',
    "abcdefg",
    x'cafebabe',
    "abcdefg",
    x'cafebabe',
    "abcdefg",
    st_geomfromtext('point(1 1)'),
    1,
    1
);

SELECT _bit | 2147483647 FROM at;
SELECT _tin | 2147483647 FROM at;
SELECT _boo | 2147483647 FROM at;
SELECT _sms | 2147483647 FROM at;
SELECT _smu | 2147483647 FROM at;
SELECT _mes | 2147483647 FROM at;
SELECT _meu | 2147483647 FROM at;
SELECT _ins | 2147483647 FROM at;
SELECT _inu | 2147483647 FROM at;
SELECT _bis | 2147483647 FROM at;
SELECT _biu | 2147483647 FROM at;
SELECT _dec | 2147483647 FROM at;
SELECT _flo | 2147483647 FROM at;
SELECT _dou | 2147483647 FROM at;
SELECT _yea | 2147483647 FROM at;
SELECT _jsn | 2147483647 FROM at;
SELECT _chr | 2147483647 FROM at;
SELECT _vch | 2147483647 FROM at;
SELECT _bin | 2147483647 FROM at;
SELECT _vbn | 2147483647 FROM at;
SELECT _tbl | 2147483647 FROM at;
SELECT _ttx | 2147483647 FROM at;
SELECT _blb | 2147483647 FROM at;
SELECT _txt | 2147483647 FROM at;
SELECT _mbb | 2147483647 FROM at;
SELECT _mtx | 2147483647 FROM at;
SELECT _lbb | 2147483647 FROM at;
SELECT _ltx | 2147483647 FROM at;
SELECT _pnt | 2147483647 FROM at;
SELECT _dat | 2147483647 FROM at;
SELECT _dtt | 2147483647 FROM at;
SELECT _smp | 2147483647 FROM at;
SELECT _tim | 2147483647 FROM at;
SELECT _enu | 2147483647 FROM at;
SELECT _set | 2147483647 FROM at;

SELECT _bit & 2147483647 FROM at;
SELECT _tin & 2147483647 FROM at;
SELECT _boo & 2147483647 FROM at;
SELECT _sms & 2147483647 FROM at;
SELECT _smu & 2147483647 FROM at;
SELECT _mes & 2147483647 FROM at;
SELECT _meu & 2147483647 FROM at;
SELECT _ins & 2147483647 FROM at;
SELECT _inu & 2147483647 FROM at;
SELECT _bis & 2147483647 FROM at;
SELECT _biu & 2147483647 FROM at;
SELECT _dec & 2147483647 FROM at;
SELECT _flo & 2147483647 FROM at;
SELECT _dou & 2147483647 FROM at;
SELECT _yea & 2147483647 FROM at;
SELECT _jsn & 2147483647 FROM at;
SELECT _chr & 2147483647 FROM at;
SELECT _vch & 2147483647 FROM at;
SELECT _bin & 2147483647 FROM at;
SELECT _vbn & 2147483647 FROM at;
SELECT _tbl & 2147483647 FROM at;
SELECT _ttx & 2147483647 FROM at;
SELECT _blb & 2147483647 FROM at;
SELECT _txt & 2147483647 FROM at;
SELECT _mbb & 2147483647 FROM at;
SELECT _mtx & 2147483647 FROM at;
SELECT _lbb & 2147483647 FROM at;
SELECT _ltx & 2147483647 FROM at;
SELECT _pnt & 2147483647 FROM at;
SELECT _dat & 2147483647 FROM at;
SELECT _dtt & 2147483647 FROM at;
SELECT _smp & 2147483647 FROM at;
SELECT _tim & 2147483647 FROM at;
SELECT _enu & 2147483647 FROM at;
SELECT _set & 2147483647 FROM at;

SELECT _bit ^ 2147483647 FROM at;
SELECT _tin ^ 2147483647 FROM at;
SELECT _boo ^ 2147483647 FROM at;
SELECT _sms ^ 2147483647 FROM at;
SELECT _smu ^ 2147483647 FROM at;
SELECT _mes ^ 2147483647 FROM at;
SELECT _meu ^ 2147483647 FROM at;
SELECT _ins ^ 2147483647 FROM at;
SELECT _inu ^ 2147483647 FROM at;
SELECT _bis ^ 2147483647 FROM at;
SELECT _biu ^ 2147483647 FROM at;
SELECT _dec ^ 2147483647 FROM at;
SELECT _flo ^ 2147483647 FROM at;
SELECT _dou ^ 2147483647 FROM at;
SELECT _yea ^ 2147483647 FROM at;
SELECT _jsn ^ 2147483647 FROM at;
SELECT _chr ^ 2147483647 FROM at;
SELECT _vch ^ 2147483647 FROM at;
SELECT _bin ^ 2147483647 FROM at;
SELECT _vbn ^ 2147483647 FROM at;
SELECT _tbl ^ 2147483647 FROM at;
SELECT _ttx ^ 2147483647 FROM at;
SELECT _blb ^ 2147483647 FROM at;
SELECT _txt ^ 2147483647 FROM at;
SELECT _mbb ^ 2147483647 FROM at;
SELECT _mtx ^ 2147483647 FROM at;
SELECT _lbb ^ 2147483647 FROM at;
SELECT _ltx ^ 2147483647 FROM at;
SELECT _pnt ^ 2147483647 FROM at;
SELECT _dat ^ 2147483647 FROM at;
SELECT _dtt ^ 2147483647 FROM at;
SELECT _smp ^ 2147483647 FROM at;
SELECT _tim ^ 2147483647 FROM at;
SELECT _enu ^ 2147483647 FROM at;
SELECT _set ^ 2147483647 FROM at;

SELECT _bit | x'cafebabe' FROM at;
SELECT _tin | x'cafebabe' FROM at;
SELECT _boo | x'cafebabe' FROM at;
SELECT _sms | x'cafebabe' FROM at;
SELECT _smu | x'cafebabe' FROM at;
SELECT _mes | x'cafebabe' FROM at;
SELECT _meu | x'cafebabe' FROM at;
SELECT _ins | x'cafebabe' FROM at;
SELECT _inu | x'cafebabe' FROM at;
SELECT _bis | x'cafebabe' FROM at;
SELECT _biu | x'cafebabe' FROM at;
SELECT _dec | x'cafebabe' FROM at;
SELECT _flo | x'cafebabe' FROM at;
SELECT _dou | x'cafebabe' FROM at;
SELECT _yea | x'cafebabe' FROM at;
SELECT _jsn | x'cafebabe' FROM at;
SELECT _chr | x'cafebabe' FROM at;
SELECT _vch | x'cafebabe' FROM at;
SELECT hex(_bin | x'CAFEBABE000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000CAFE1111CAFE1111') FROM at;
SELECT _bin | x'cafebabe' FROM at;
SELECT hex(_vbn | x'CAFEBABE000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000CAFE1111CAFE1111') FROM at;
SELECT _vbn | x'cafebabe' FROM at;
SELECT hex(_tbl | x'CAFEBABE000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000CAFE1111CAFE1111') FROM at;
SELECT _tbl | x'cafebabe' FROM at;
SELECT _ttx | x'cafebabe' FROM at;
SELECT hex(_blb | x'cafebabe') FROM at;
SELECT _txt | x'cafebabe' FROM at;
SELECT hex(_mbb | x'cafebabe') FROM at;
SELECT _mtx | x'cafebabe' FROM at;
SELECT hex(_lbb | x'cafebabe') FROM at;
SELECT _ltx | x'cafebabe' FROM at;
SELECT _pnt | x'cafebabe' FROM at;
SELECT _dat | x'cafebabe' FROM at;
SELECT _dtt | x'cafebabe' FROM at;
SELECT _smp | x'cafebabe' FROM at;
SELECT _tim | x'cafebabe' FROM at;
SELECT _enu | x'cafebabe' FROM at;
SELECT _set | x'cafebabe' FROM at;

SELECT _bit & x'cafebabe' FROM at;
SELECT _tin & x'cafebabe' FROM at;
SELECT _boo & x'cafebabe' FROM at;
SELECT _sms & x'cafebabe' FROM at;
SELECT _smu & x'cafebabe' FROM at;
SELECT _mes & x'cafebabe' FROM at;
SELECT _meu & x'cafebabe' FROM at;
SELECT _ins & x'cafebabe' FROM at;
SELECT _inu & x'cafebabe' FROM at;
SELECT _bis & x'cafebabe' FROM at;
SELECT _biu & x'cafebabe' FROM at;
SELECT _dec & x'cafebabe' FROM at;
SELECT _flo & x'cafebabe' FROM at;
SELECT _dou & x'cafebabe' FROM at;
SELECT _yea & x'cafebabe' FROM at;
SELECT _jsn & x'cafebabe' FROM at;
SELECT _chr & x'cafebabe' FROM at;
SELECT _vch & x'cafebabe' FROM at;
SELECT hex(_bin & x'CAFEBABE000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000CAFE1111CAFE1111') FROM at;
SELECT _bin & x'cafebabe' FROM at;
SELECT hex(_vbn & x'CAFEBABE000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000CAFE1111CAFE1111') FROM at;
SELECT _vbn & x'cafebabe' FROM at;
SELECT hex(_tbl & x'CAFEBABE000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000CAFE1111CAFE1111') FROM at;
SELECT _tbl & x'cafebabe' FROM at;
SELECT _ttx & x'cafebabe' FROM at;
SELECT hex(_blb & x'cafebabe') FROM at;
SELECT _txt & x'cafebabe' FROM at;
SELECT hex(_mbb & x'cafebabe') FROM at;
SELECT _mtx & x'cafebabe' FROM at;
SELECT hex(_lbb & x'cafebabe') FROM at;
SELECT _ltx & x'cafebabe' FROM at;
SELECT _pnt & x'cafebabe' FROM at;
SELECT _dat & x'cafebabe' FROM at;
SELECT _dtt & x'cafebabe' FROM at;
SELECT _smp & x'cafebabe' FROM at;
SELECT _tim & x'cafebabe' FROM at;
SELECT _enu & x'cafebabe' FROM at;
SELECT _set & x'cafebabe' FROM at;

SELECT _bit ^ x'cafebabe' FROM at;
SELECT _tin ^ x'cafebabe' FROM at;
SELECT _boo ^ x'cafebabe' FROM at;
SELECT _sms ^ x'cafebabe' FROM at;
SELECT _smu ^ x'cafebabe' FROM at;
SELECT _mes ^ x'cafebabe' FROM at;
SELECT _meu ^ x'cafebabe' FROM at;
SELECT _ins ^ x'cafebabe' FROM at;
SELECT _inu ^ x'cafebabe' FROM at;
SELECT _bis ^ x'cafebabe' FROM at;
SELECT _biu ^ x'cafebabe' FROM at;
SELECT _dec ^ x'cafebabe' FROM at;
SELECT _flo ^ x'cafebabe' FROM at;
SELECT _dou ^ x'cafebabe' FROM at;
SELECT _yea ^ x'cafebabe' FROM at;
SELECT _jsn ^ x'cafebabe' FROM at;
SELECT _chr ^ x'cafebabe' FROM at;
SELECT _vch ^ x'cafebabe' FROM at;
SELECT hex(_bin ^ x'CAFEBABE000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000CAFE1111CAFE1111') FROM at;
SELECT _bin ^ x'cafebabe' FROM at;
SELECT hex(_vbn ^ x'CAFEBABE000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000CAFE1111CAFE1111') FROM at;
SELECT _vbn ^ x'cafebabe' FROM at;
SELECT hex(_tbl ^ x'CAFEBABE000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000CAFE1111CAFE1111') FROM at;
SELECT _tbl ^ x'cafebabe' FROM at;
SELECT _ttx ^ x'cafebabe' FROM at;
SELECT hex(_blb ^ x'cafebabe') FROM at;
SELECT _txt ^ x'cafebabe' FROM at;
SELECT hex(_mbb ^ x'cafebabe') FROM at;
SELECT _mtx ^ x'cafebabe' FROM at;
SELECT hex(_lbb ^ x'cafebabe') FROM at;
SELECT _ltx ^ x'cafebabe' FROM at;
SELECT _pnt ^ x'cafebabe' FROM at;
SELECT _dat ^ x'cafebabe' FROM at;
SELECT _dtt ^ x'cafebabe' FROM at;
SELECT _smp ^ x'cafebabe' FROM at;
SELECT _tim ^ x'cafebabe' FROM at;
SELECT _enu ^ x'cafebabe' FROM at;
SELECT _set ^ x'cafebabe' FROM at;

SELECT HEX(_bin & _bin), HEX(_bin & _vbn), HEX(_vbn & _bin), HEX(_vbn & _vbn) FROM at;
SELECT HEX(_bin | _bin), HEX(_bin | _vbn), HEX(_vbn | _bin), HEX(_vbn | _vbn) FROM at;
SELECT HEX(_bin ^ _bin), HEX(_bin ^ _vbn), HEX(_vbn ^ _bin), HEX(_vbn ^ _vbn) FROM at;
DROP TABLE at;

CREATE TABLE t1 (a int, b VARBINARY(6));
INSERT INTO t1 VALUES (1,null);
INSERT INTO t1 VALUES (1,null);
INSERT INTO t1 VALUES (2,null);
SELECT a, HEX(BIT_AND(b)), HEX(BIT_OR(b)), HEX(BIT_XOR(b)) FROM t1 GROUP BY a;
SELECT HEX(BIT_AND(b)), HEX(BIT_OR(b)), HEX(BIT_XOR(b)) FROM t1;
INSERT INTO t1 VALUES (2,0x12345678901);
SELECT a, HEX(BIT_AND(b)), HEX(BIT_OR(b)), HEX(BIT_XOR(b)) FROM t1 GROUP BY a;
SELECT HEX(BIT_AND(b)), HEX(BIT_OR(b)), HEX(BIT_XOR(b)) FROM t1;
SELECT SQL_BIG_RESULT a, HEX(BIT_AND(b)), HEX(BIT_OR(b)), HEX(BIT_XOR(b)) FROM t1 GROUP BY a;
INSERT INTO t1 VALUES (3,0xabcdef);
SELECT a, HEX(BIT_AND(b)), HEX(BIT_OR(b)), HEX(BIT_XOR(b)) FROM t1 GROUP BY a;
SELECT SQL_BIG_RESULT a, HEX(BIT_AND(b)), HEX(BIT_OR(b)), HEX(BIT_XOR(b)) FROM t1 GROUP BY a;
INSERT INTO t1 VALUES (2,0x11347290158), (3, 0x149032);
SELECT a, HEX(BIT_AND(b)), HEX(BIT_OR(b)), HEX(BIT_XOR(b)) FROM t1 GROUP BY a;
SELECT SQL_BIG_RESULT a, HEX(BIT_AND(b)), HEX(BIT_OR(b)), HEX(BIT_XOR(b)) FROM t1 GROUP BY a;
DROP TABLE t1;

CREATE TABLE t(a varbinary(10));
INSERT INTO t VALUES(0xFF00F0F0), (0xF0F0FF00);
SELECT BIT_AND(a) FROM t;
SELECT BIT_OR(a) FROM t;
SELECT BIT_XOR(a) FROM t;
SELECT HEX(BIT_AND(a)) FROM t;
SELECT HEX(BIT_OR(a)) FROM t;
SELECT HEX(BIT_XOR(a)) FROM t;

-- bitwise aggregate functions with NULL value
INSERT INTO t VALUES(NULL);
SELECT HEX(BIT_AND(a)) FROM t;
SELECT HEX(BIT_OR(a)) FROM t;
SELECT HEX(BIT_XOR(a)) FROM t;

-- bitwise aggregate functions when first value is null
INSERT INTO t VALUES(NULL), (0xFF00F0F0), (0xF0F0FF00);
SELECT HEX(BIT_AND(a)) FROM t;
SELECT HEX(BIT_OR(a)) FROM t;
SELECT HEX(BIT_XOR(a)) FROM t;

-- bitwise aggregate functions when last value is null
INSERT INTO t VALUES(0xFF00F0F0), (0xF0F0FF00), (NULL);
SELECT HEX(BIT_AND(a)) FROM t;
SELECT HEX(BIT_OR(a)) FROM t;
SELECT HEX(BIT_XOR(a)) FROM t;

-- bitwise aggregate functions when a value in the middle of the aggregate is null
INSERT INTO t VALUES(0xFF00F0F0), (NULL), (0xF0F0FF00);
SELECT HEX(BIT_AND(a)) FROM t;
SELECT HEX(BIT_OR(a)) FROM t;
SELECT HEX(BIT_XOR(a)) FROM t;
SELECT SQL_BUFFER_RESULT HEX(BIT_AND(a)), HEX(BIT_OR(a)), HEX(BIT_XOR(a)) FROM t;

DROP TABLE t;

CREATE TABLE t(group_id int, a varbinary(10));
INSERT INTO t VALUES(1, 0xFF00F0F0), (1, 0xFF00);

SELECT HEX(BIT_AND(lpad(a, 10, 0x00))) FROM t;
SELECT BIT_AND(a) FROM t;
SELECT BIT_OR(a) FROM t;
SELECT BIT_XOR(a) FROM t;

INSERT INTO t VALUES(1, 0xFF00), (1, 0xFF00F0F0);
SELECT BIT_AND(a) FROM t;
SELECT BIT_OR(a) FROM t;
SELECT BIT_XOR(a) FROM t;

SELECT
HEX(0xABCDEF & 0x123456 & 0x789123),
HEX(0xABCDEF | 0x123456 | 0x789123),
HEX(0xABCDEF ^ 0x123456 ^ 0x789123);

INSERT INTO t(group_id, a) VALUES
(1, 0x34567101ABFF00F0F0),
(2, NULL),
(1, 0x34567102ABF0F0F0F0),
(3, 0x34567104ABF0F0F0F0),
(1, 0x34567103ABFF00F0F0),
(5, 0xABCDEF),
(5, 0x123456),
(5, 0x789123),
(1, 0x34567104ABF0F0F0F0),
(4, 0x34567100ABF0F0F0F0),
(4, NULL),
(4, 0x34567101ABFF00F0F0);
SELECT group_id, HEX(BIT_AND(a)), HEX(BIT_OR(a)), HEX(BIT_XOR(a))
FROM t
GROUP BY group_id;
SELECT SQL_BUFFER_RESULT group_id, HEX(BIT_AND(a)), HEX(BIT_OR(a)), HEX(BIT_XOR(a))
FROM t
GROUP BY group_id;
SELECT group_id, HEX(BIT_AND(a)), BIT_AND(192), BIT_AND(0x303233), BIT_AND(binary "foo")
FROM t
GROUP BY group_id;
SELECT BIT_COUNT(group_id), BIT_COUNT(a), BIT_COUNT(192), BIT_COUNT(0x303233),
  BIT_COUNT(binary "foo"), BIT_COUNT(NULL)
FROM t;
SELECT HEX(_binary 0x0003 << (_binary 0x38 | 0x38));
SELECT HEX(_binary 0x0003 << (_binary 0x40 | 0x40));
SELECT CONCAT("M", (0x39 | 0x39));

CREATE TABLE t2(gid int, a int);

INSERT INTO t2(gid, a) VALUES (1, 1), (1, 2), (2, 4), (2, 8);
SELECT CONCAT("M" ,BIT_OR(a)) FROM t2;
SELECT CONCAT("M" ,BIT_OR(a)) FROM t2 GROUP BY gid;

SELECT BIT_OR(a) FROM t2;
SELECT 1.0 * BIT_OR(a) FROM t2;
SELECT gid, BIT_OR(a) FROM t2 GROUP BY gid;
SELECT gid, 1.0 * BIT_OR(a) FROM t2 GROUP BY gid;

DROP TABLE t2;

INSERT INTO t(group_id, a) VALUES
(1, NULL),
(1, 0x312E35),
(1, 0x312E35),
(4, 0x312E38),
(4, NULL),
(4, 0x312E38),
(5, 0x31),
(5, 0x31);
SELECT
group_id,
1.0 * BIT_AND(a),
1.0 * BIT_OR(a)
FROM t
WHERE group_id != 5
GROUP BY group_id;
SELECT
group_id,
0x30 << BIT_AND(a),
0x30 << BIT_OR(a)
FROM t
WHERE group_id = 5
GROUP BY group_id;
SELECT
group_id,
CONCAT('My', BIT_AND(a)),
CONCAT('My', BIT_OR(a))
FROM t
GROUP BY group_id;
SELECT
group_id,
0x30 << BIT_XOR(a)
FROM t
GROUP BY group_id;
SELECT
group_id,
1.0 * BIT_XOR(a)
FROM t
GROUP BY group_id;

INSERT INTO t(group_id, a) VALUES
(1, 0x7BAFBF),
(1, 0x4A818A),
(4, 0xFFFEFF),
(4, NULL),
(4, 0xCED0C7),
(5, 0xFB),
(5, 0xCA);
SELECT
group_id,
1.0 * BIT_XOR(a),
CONCAT('My', BIT_XOR(a))
FROM t
GROUP BY group_id;
SELECT
group_id,
0x30 << BIT_XOR(a)
FROM t
WHERE group_id = 5
GROUP BY group_id;
SELECT
group_id,
1.0 * BIT_AND(a)
FROM t
GROUP BY group_id;
SELECT
group_id,
0x30 << BIT_AND(a)
FROM t
GROUP BY group_id;
SELECT
group_id,
1.0 * BIT_OR(a)
FROM t
GROUP BY group_id;
SELECT
group_id,
0x30 << BIT_OR(a)
FROM t
GROUP BY group_id;

--
-- simulate OOM in Item_sum_bit::clear (init stage for groups)
--
LET $have_debug= `SELECT (version() LIKE '%debug%')`;
SET GLOBAL debug = '+d,simulate_sum_out_of_memory';
SELECT group_id, HEX(BIT_AND(a)), HEX(BIT_OR(a)), HEX(BIT_XOR(a))
FROM t
GROUP BY group_id;
SET GLOBAL debug = '';
DROP table t;

SET @a:= b'1010010001000010000010000001000000010000000010000000001000000000010000000000010000000000001';
SELECT BIT_COUNT(@a);
SELECT BIT_COUNT(_binary 0x221040808040100200200100);

CREATE TABLE t(b BLOB);
INSERT INTO t VALUES(NULL);
SELECT BIT_COUNT(BIT_AND(b)) FROM t GROUP BY b;
SELECT BIT_COUNT(BIT_AND(CAST(b AS BINARY(500)))) FROM t GROUP BY b;
SELECT BIT_COUNT(BIT_AND(SUBSTRING(b,1,500))) FROM t GROUP BY b;
INSERT INTO t VALUES(REPEAT(x'0a',1000));
SELECT BIT_COUNT(BIT_AND(CAST(b AS BINARY(500)))) FROM t GROUP BY b;
SELECT BIT_COUNT(BIT_AND(SUBSTRING(b,1,500))) FROM t GROUP BY b;
DROP TABLE t;

-- From one zero to twelve zeroes.
SET @a:= b'1010010001000010000010000001000000010000000010000000001000000000010000000000010000000000001';

SELECT LENGTH(@a), HEX(@a);
LET $c = 96;

CREATE TABLE r select 0 as c, HEX(@a << 0) as sl, HEX(@a >> 0) as sr;
{
  EVAL INSERT INTO r SELECT $c, HEX(@a << $c), HEX(@a >> $c);
  DEC $c;

SELECT * FROM r ORDER by c;
DROP TABLE r;

CREATE TABLE t (gid int, a varbinary(514));
INSERT INTO t VALUES(1, REPEAT('2', 257)), (1, REPEAT('1', 257));
SELECT HEX(BIT_OR(a)) FROM t GROUP BY gid;
DROP TABLE t;

CREATE TABLE t (gid int, a varbinary(511));
INSERT INTO t VALUES(1, REPEAT('2', 255)), (1, REPEAT('1', 255));
SELECT HEX(BIT_OR(a)) FROM t GROUP BY gid;
DROP TABLE t;

CREATE TABLE t (gid int, a varbinary(65500), b blob);
INSERT INTO t VALUES(1, REPEAT('2', 32750), REPEAT('1', 32750));
SELECT BIT_COUNT(a & b) FROM t ;
DROP TABLE t;

CREATE TABLE t(b LONGBLOB);
INSERT INTO t VALUES(NULL);
SELECT concat(BIT_COUNT(BIT_AND(b))) FROM t GROUP BY b;
SELECT concat("" , BIT_COUNT(BIT_AND(b))) FROM t GROUP BY b;
DROP TABLE t;
CREATE TABLE t(id int, a varbinary(10));
insert into t values(1,''), (1,NULL), (2,NULL), (2, ''),
(3, ''), (3, 'x'), (4, 'x'), (4, '');
SELECT id, bit_or(a) FROM t where id=3 GROUP BY id;
SELECT id, bit_or(a) FROM t where id=4 GROUP BY id;
SELECT id, bit_or(a) FROM t where id in (1,2) GROUP BY id;
DROP TABLE t;
CREATE TABLE u(a VARBINARY(18), b VARBINARY(18), c VARBINARY(18));
INSERT INTO u VALUES(0x6bc7cecf8b98558d7aa6048d0ebcf9fe, 0x7bb1512989ab38a2e91a9b17a268be16, 0xdb502fb16fded188fef1ea604820eb41);
SELECT a | b = 0x7bf7dfef8bbb7daffbbe9f9faefcfffe, a | c = 0xfbd7efffefded58dfef7eeed4ebcfbff, b | c = 0xfbf17fb9effff9aafffbfb77ea68ff57 FROM u;
SELECT a & b = 0x6b81400989881080680200050228b816, a & c = 0x4b400e810b9851887aa000000820e940, b & c = 0x5b100121098a1080e8108a000020aa00 FROM u;
SELECT a ^ b = 0x10769fe602336d2f93bc9f9aacd447e8, a ^ c = 0xb097e17ee44684058457eeed469c12bf, b ^ c = 0xa0e17e98e675e92a17eb7177ea485557 FROM u;
SELECT (~a) = 0x943831307467aa728559fb72f1430601, ~b = 0x844eaed67654c75d16e564e85d9741e9, ~c = 0x24afd04e90212e77010e159fb7df14be FROM u;
CREATE TABLE t(a VARBINARY(18), id INT);
INSERT INTO t VALUES
(0x6BC7CECF8B98558D7AA6048D0EBCF9FE, 1),
(0x7BB1512989AB38A2E91A9B17A268BE16, 1),
(0xDB502FB16FDED188FEF1EA604820EB41, 1),
(0xD78F9D9F1730AB1AF54C091A1D79F3FC, 2),
(0xF762A25313567145D235362F44D17C2C, 2),
(0xB6A05F62DFBDA311FDE3D4C09041D682, 2);
SELECT BIT_AND(a) = 0x4b00000109881080680000000020a800, BIT_OR(a) = 0xfbf7ffffeffffdafffffffffeefcffff, BIT_XOR(a) = 0xcb26b0576dedbca76d4d75fae4f4aca9 FROM t WHERE id = 1;
SELECT id, HEX(BIT_AND(a)), HEX(BIT_OR(a)), HEX(BIT_XOR(a)) FROM t GROUP BY id;
DROP TABLE t, u;

CREATE TABLE u(a BINARY(18), b BINARY(18), c BINARY(18));
INSERT INTO u VALUES(0x6bc7cecf8b98558d7aa6048d0ebcf9fe, 0x7bb1512989ab38a2e91a9b17a268be16, 0xdb502fb16fded188fef1ea604820eb41);
SELECT a | b = 0x7bf7dfef8bbb7daffbbe9f9faefcfffe0000, a | c = 0xfbd7efffefded58dfef7eeed4ebcfbff0000, b | c = 0xfbf17fb9effff9aafffbfb77ea68ff570000 FROM u;
SELECT a & b = 0x6b81400989881080680200050228b8160000, a & c = 0x4b400e810b9851887aa000000820e9400000, b & c = 0x5b100121098a1080e8108a000020aa000000 FROM u;
SELECT a ^ b = 0x10769fe602336d2f93bc9f9aacd447e80000, a ^ c = 0xb097e17ee44684058457eeed469c12bf0000, b ^ c = 0xa0e17e98e675e92a17eb7177ea4855570000 FROM u;
SELECT (~a) = 0x943831307467aa728559fb72f1430601ffff, ~b = 0x844eaed67654c75d16e564e85d9741e9ffff, ~c = 0x24afd04e90212e77010e159fb7df14beffff FROM u;
CREATE TABLE t(a binary(18), id INT);
INSERT INTO t VALUES
(0x6BC7CECF8B98558D7AA6048D0EBCF9FE, 1),
(0x7BB1512989AB38A2E91A9B17A268BE16, 1),
(0xDB502FB16FDED188FEF1EA604820EB41, 1),
(0xD78F9D9F1730AB1AF54C091A1D79F3FC, 2),
(0xF762A25313567145D235362F44D17C2C, 2),
(0xB6A05F62DFBDA311FDE3D4C09041D682, 2);
SELECT BIT_AND(a) = 0x4b00000109881080680000000020a8000000, BIT_OR(a) = 0xfbf7ffffeffffdafffffffffeefcffff0000, BIT_XOR(a) = 0xcb26b0576dedbca76d4d75fae4f4aca90000 FROM t WHERE id = 1;
SELECT id, HEX(BIT_AND(a)), HEX(BIT_OR(a)), HEX(BIT_XOR(a)) FROM t GROUP BY id;
DROP TABLE t, u;

SELECT BIT_COUNT(0b1100000010011010000000101000000111100010) = 13;

DROP TABLE IF EXISTS t;
CREATE TABLE t(
a BINARY(2) NOT NULL,
b BINARY(1) NOT NULL
) engine=innodb;
INSERT INTO t VALUES('1',''),('','');
SELECT SQL_BIG_RESULT DISTINCT a&b FROM t;

DROP TABLE t;
CREATE TABLE t (a BLOB NOT NULL) ENGINE=INNODB;
INSERT INTO t values(0xfefefefefefe);
SELECT bit_count(a & 0x2438) FROM t;
SELECT 1 FROM t WHERE ~reverse(a & 0x111111);
SELECT 1 FROM t WHERE insert(a & 0x111111,'','','');
SELECT 1 FROM t WHERE rtrim(a & 0x111111);
SELECT (SELECT a & 0xff FROM t);

SELECT bit_count(a & NULL) FROM t;
SELECT 1 FROM t WHERE ~reverse(a & NULL);
SELECT 1 FROM t WHERE insert(a & NULL,'','','');
SELECT 1 FROM t WHERE rtrim(a & NULL);
SELECT (SELECT a & NULL from t);

DROP TABLE t;
SET @s:="do field('1',monthname(now()),bit_and(export_set(1,'',1,0x29,186)))";

SET @s1:='do length(concat(1,bit_xor(aes_encrypt(1,1,1))));

CREATE TABLE t0(c0 TEXT);
INSERT INTO t0(c0) VALUES ("a");
SELECT * FROM t0 WHERE GREATEST((-1) & (-1), -t0.c0);

SELECT GREATEST((-1) & (-1), -t0.c0) IS TRUE FROM t0;
SELECT * FROM t0 WHERE GREATEST(18446744073709551615, -t0.c0);
SELECT GREATEST(18446744073709551615, -t0.c0) IS TRUE FROM t0;

DROP TABLE t0;

CREATE TABLE t0(c0 INT, c1 TEXT);
INSERT INTO t0(c0, c1) VALUES(-1, "a");
SELECT * FROM t0 WHERE t0.c1 < (t0.c0 & t0.c0) AND t0.c0 = -1;

SELECT t0.c1 < (t0.c0 & t0.c0) AND t0.c0 = -1 FROM t0;

DROP TABLE t0;
