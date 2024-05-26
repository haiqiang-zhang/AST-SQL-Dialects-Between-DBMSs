select 'invalid values:';
select geohashEncode(181.0, 91.0);
select count(geohashDecode('abcdefghijklmnopqrstuvwxyz'));
select 'constant values:';
select round(geohashDecode('ezs42').1, 5), round(geohashDecode('ezs42').2, 5);
select 'default precision:';
select 'mixing const and non-const-columns:';
select 'from table (with const precision):';
select 1 as p, geohashEncode(longitude, latitude, p) as actual, if(actual = encoded, 'Ok', concat('expected: ', encoded)) from geohash_test_data WHERE length(encoded) = p;
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
