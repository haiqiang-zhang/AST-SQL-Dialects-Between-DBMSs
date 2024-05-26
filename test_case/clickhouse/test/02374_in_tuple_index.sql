SELECT count()
FROM t_in_tuple_index
WHERE (PLATFORM, USER_ID) IN (('insta', '33'));
DROP TABLE IF EXISTS t_in_tuple_index;
