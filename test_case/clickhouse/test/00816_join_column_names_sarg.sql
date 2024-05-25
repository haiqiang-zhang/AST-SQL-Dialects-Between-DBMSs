select t1_00816.a, t2_00816.a from t1_00816 all inner join t2_00816 on t1_00816.a=t2_00816.a;
-- Code: 47. DB::Exception: Received from localhost:9000, 127.0.0.1. DB::Exception: Unknown identifier: t2_00816.a.

-- this query works fine
select t1_00816.a, t2_00816.* from t1_00816 all inner join t2_00816 on t1_00816.a=t2_00816.a;
select t1_00816.a, t2_00816.val from t1_00816 all inner join t2_00816 on t1_00816.a=t2_00816.a;
DROP TABLE t1_00816;
DROP TABLE t2_00816;
