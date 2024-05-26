SELECT c41, LENGTH(c42) FROM t4;
UPDATE t3
SET c32= CONCAT(c32,
                REPEAT('a', @max_allowed_packet-1));
DROP TABLE t3, t4;
