select max(rowid) from t2250;
CREATE TABLE t2260a_real(a, b);
CREATE TABLE t2260b_real(a, b);
CREATE INDEX i2260 ON t2260a_real(a);
CREATE INDEX i2260x ON t2260b_real(a);
