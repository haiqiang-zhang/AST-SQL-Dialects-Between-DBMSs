SELECT v as value, hashint2(v)::bit(32) as standard,
       hashint2extended(v, 0)::bit(32) as extended0,
       hashint2extended(v, 1)::bit(32) as extended1
FROM   (VALUES (0::int2), (1::int2), (17::int2), (42::int2)) x(v)
WHERE  hashint2(v)::bit(32) != hashint2extended(v, 0)::bit(32)
       OR hashint2(v)::bit(32) = hashint2extended(v, 1)::bit(32);
CREATE TYPE mood AS ENUM ('sad', 'ok', 'happy');
DROP TYPE mood;
CREATE TYPE hash_test_t1 AS (a int, b text);
DROP TYPE hash_test_t1;
CREATE TYPE hash_test_t2 AS (a varbit, b text);
DROP TYPE hash_test_t2;
SELECT hashfloat4('0'::float4) = hashfloat4('-0'::float4) AS t;
SELECT hashfloat4('NaN'::float4) = hashfloat4(-'NaN'::float4) AS t;
SELECT hashfloat8('0'::float8) = hashfloat8('-0'::float8) AS t;
SELECT hashfloat8('NaN'::float8) = hashfloat8(-'NaN'::float8) AS t;
SELECT hashfloat4('NaN'::float4) = hashfloat8('NaN'::float8) AS t;
