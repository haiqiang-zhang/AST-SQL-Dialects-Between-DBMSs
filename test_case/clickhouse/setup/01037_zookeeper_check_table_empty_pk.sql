SET insert_keeper_fault_injection_probability=0;
SET send_logs_level = 'fatal';
DROP TABLE IF EXISTS mt_without_pk SYNC;
CREATE TABLE mt_without_pk (SomeField1 Int64, SomeField2 Double) ENGINE = MergeTree() ORDER BY tuple();
INSERT INTO mt_without_pk VALUES (1, 2);
