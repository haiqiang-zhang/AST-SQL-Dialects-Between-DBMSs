DROP TABLE IF EXISTS merge_a;
DROP TABLE IF EXISTS merge_b;
DROP TABLE IF EXISTS merge_ab;
CREATE TABLE merge_a (x UInt8) ENGINE = StripeLog;
CREATE TABLE merge_b (x UInt8) ENGINE = StripeLog;
CREATE TABLE merge_ab AS merge(currentDatabase(), '^merge_[ab]$');
