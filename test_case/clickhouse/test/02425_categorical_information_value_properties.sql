SELECT corr(c1, c2) FROM VALUES((0, 0), (NULL, 2), (1, 0), (1, 1));
SELECT groupUniqArray(*) FROM VALUES(toNullable(0));
SELECT quantiles(0.5, 0.9)(c1) FROM VALUES(0::Nullable(UInt8));
