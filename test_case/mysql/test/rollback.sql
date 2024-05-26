SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" AND
        info LIKE "DROP TABLES t0, t1";
SELECT * FROM t0;
