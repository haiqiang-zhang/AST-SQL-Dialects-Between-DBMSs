select 'invalid values:';
select geohashEncode(181.0, 91.0);
select geohashEncode(-181.0, -91.0);
select count(geohashDecode('abcdefghijklmnopqrstuvwxyz'));
select 'constant values:';
select geohashEncode(-5.60302734375, 42.593994140625, 0);
select round(geohashDecode('ezs42').1, 5), round(geohashDecode('ezs42').2, 5);
select 'default precision:';
select geohashEncode(-5.60302734375, 42.593994140625);
select 'mixing const and non-const-columns:';
select geohashEncode(materialize(-5.60302734375), materialize(42.593994140625), 0);
select geohashEncode(materialize(-5.60302734375), materialize(42.593994140625), materialize(0));
select geohashEncode(-5.60302734375, materialize(42.593994140625), 0);
select geohashEncode(materialize(-5.60302734375), 42.593994140625, 0);
select geohashEncode(-5.60302734375, 42.593994140625, 0);
select 'from table (with const precision):';
select 1 as p, geohashEncode(longitude, latitude, p) as actual, if(actual = encoded, 'Ok', concat('expected: ', encoded)) from geohash_test_data WHERE length(encoded) = p;
select 2 as p, geohashEncode(longitude, latitude, p) as actual, if(actual = encoded, 'Ok', concat('expected: ', encoded)) from geohash_test_data WHERE length(encoded) = p;
select 3 as p, geohashEncode(longitude, latitude, p) as actual, if(actual = encoded, 'Ok', concat('expected: ', encoded)) from geohash_test_data WHERE length(encoded) = p;
select 4 as p, geohashEncode(longitude, latitude, p) as actual, if(actual = encoded, 'Ok', concat('expected: ', encoded)) from geohash_test_data WHERE length(encoded) = p;
select 5 as p, geohashEncode(longitude, latitude, p) as actual, if(actual = encoded, 'Ok', concat('expected: ', encoded)) from geohash_test_data WHERE length(encoded) = p;
select 6 as p, geohashEncode(longitude, latitude, p) as actual, if(actual = encoded, 'Ok', concat('expected: ', encoded)) from geohash_test_data WHERE length(encoded) = p;
select 7 as p, geohashEncode(longitude, latitude, p) as actual, if(actual = encoded, 'Ok', concat('expected: ', encoded)) from geohash_test_data WHERE length(encoded) = p;
select 8 as p, geohashEncode(longitude, latitude, p) as actual, if(actual = encoded, 'Ok', concat('expected: ', encoded)) from geohash_test_data WHERE length(encoded) = p;
select 9 as p, geohashEncode(longitude, latitude, p) as actual, if(actual = encoded, 'Ok', concat('expected: ', encoded)) from geohash_test_data WHERE length(encoded) = p;
select 10 as p, geohashEncode(longitude, latitude, p) as actual, if(actual = encoded, 'Ok', concat('expected: ', encoded)) from geohash_test_data WHERE length(encoded) = p;
select 11 as p, geohashEncode(longitude, latitude, p) as actual, if(actual = encoded, 'Ok', concat('expected: ', encoded)) from geohash_test_data WHERE length(encoded) = p;
select 12 as p, geohashEncode(longitude, latitude, p) as actual, if(actual = encoded, 'Ok', concat('expected: ', encoded)) from geohash_test_data WHERE length(encoded) = p;
-- We select all values that are off by some reasonable value:
-- each byte of encoded string provides 5 bits of precision, (roughly 2.5 for lon and lat)
-- each bit of precision divides value range by 2.
-- hence max error is roughly value range 2.5 times divided by 2 for each precision bit.
-- initial value range is [-90..90] for latitude and [-180..180] for longitude.
select 'incorrectly decoded values:';
select
	geohashDecode(encoded) as actual,
	'expected:', encoded, '=>', latitude, longitude,
	'length:', 	length(encoded),
	'max lat error:', 180 / power(2, 2.5 * length(encoded)) as latitude_max_error,
	'max lon error:', 360 / power(2, 2.5 * length(encoded)) as longitude_max_error,
	'err:', (actual.2 - latitude) as lat_error, (actual.1 - longitude) as lon_error,
	'derr:', abs(lat_error) - latitude_max_error, abs(lon_error) - longitude_max_error
from geohash_test_data
where
	abs(lat_error) > latitude_max_error
	or
	abs(lon_error) > longitude_max_error;
drop table if exists geohash_test_data;
