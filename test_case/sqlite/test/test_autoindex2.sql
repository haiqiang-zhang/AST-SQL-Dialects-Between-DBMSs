SELECT count(*) FROM sqlite_master;
ANALYZE sqlite_master;
INSERT INTO sqlite_stat1 VALUES('t1','t1x3','10747267 260');
INSERT INTO sqlite_stat1 VALUES('t1','t1x2','10747267 121 113 2 2 2 1');
INSERT INTO sqlite_stat1 VALUES('t1','t1x1','10747267 50 40');
INSERT INTO sqlite_stat1 VALUES('t1','t1x0','10747267 1');
INSERT INTO sqlite_stat1 VALUES('t2','t2x15','39667 253');
INSERT INTO sqlite_stat1 VALUES('t2','t2x14','39667 19834');
INSERT INTO sqlite_stat1 VALUES('t2','t2x13','39667 13223');
INSERT INTO sqlite_stat1 VALUES('t2','t2x12','39667 7');
INSERT INTO sqlite_stat1 VALUES('t2','t2x11','39667 17');
INSERT INTO sqlite_stat1 VALUES('t2','t2x10','39667 19834');
INSERT INTO sqlite_stat1 VALUES('t2','t2x9','39667 7934');
INSERT INTO sqlite_stat1 VALUES('t2','t2x8','39667 11');
INSERT INTO sqlite_stat1 VALUES('t2','t2x7','39667 5');
INSERT INTO sqlite_stat1 VALUES('t2','t2x6','39667 242');
INSERT INTO sqlite_stat1 VALUES('t2','t2x5','39667 1984');
INSERT INTO sqlite_stat1 VALUES('t2','t2x4','39667 4408');
INSERT INTO sqlite_stat1 VALUES('t2','t2x3','39667 81');
INSERT INTO sqlite_stat1 VALUES('t2','t2x2','39667 551');
INSERT INTO sqlite_stat1 VALUES('t2','t2x1','39667 2');
INSERT INTO sqlite_stat1 VALUES('t2','t2x0','39667 1');
INSERT INTO sqlite_stat1 VALUES('t3','t3x6','569 285');
INSERT INTO sqlite_stat1 VALUES('t3','t3x5','569 2');
INSERT INTO sqlite_stat1 VALUES('t3','t3x4','569 2');
INSERT INTO sqlite_stat1 VALUES('t3','t3x3','569 5');
INSERT INTO sqlite_stat1 VALUES('t3','t3x2','569 3');
INSERT INTO sqlite_stat1 VALUES('t3','t3x1','569 6');
INSERT INTO sqlite_stat1 VALUES('t3','t3x0','569 1');
ANALYZE sqlite_master;
EXPLAIN QUERY PLAN
  SELECT
     t1_id,
     t1.did,
     param2,
     param3,
     t1.ptime,
     t1.trange,
     t1.exmass,
     t1.mass,
     t1.vstatus,
     type,
     subtype,
     t1.deviation,
     t1.formula,
     dparam1,
     reserve1,
     reserve2,
     param4,
     t1.last_operation,
     t1.admin_uuid,
     t1.previous_value,
     t1.job_id,
     client_did, 
     t1.last_t1,
     t1.data_t1,
     t1.previous_date,
     param5,
     param6,
     mgr_uuid
  FROM
     t1,
     t2,
     t3
  WHERE
     t1.ptime > 1393520400
     AND param3<>9001
     AND t3.flg7 = 1
     AND t1.did = t2.did
     AND t2.uid = t3.uid
  ORDER BY t1.ptime desc LIMIT 500;
