DROP TABLE IF EXISTS weird_mmx;
CREATE TABLE weird_mmx (x Array(UInt64)) ENGINE = TinyLog;
SELECT sum(length(*)) FROM weird_mmx;
DROP TABLE weird_mmx;
