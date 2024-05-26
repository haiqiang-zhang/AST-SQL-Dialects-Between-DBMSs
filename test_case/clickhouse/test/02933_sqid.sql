SELECT '-- negative tests';
SELECT '-- const UInt*';
SELECT sqidEncode(1) AS sqid, sqidDecode(sqid);
SELECT sqidEncode(toNullable(1), toLowCardinality(2)) AS sqid;
SELECT '-- non-const UInt*';
SELECT sqidEncode(toNullable(materialize(1)), toLowCardinality(materialize(2)));
SELECT '-- invalid sqid';
SELECT '-- alias';
SELECT sqid(1, 2);
