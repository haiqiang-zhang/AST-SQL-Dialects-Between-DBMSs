SELECT t1.q, t2.item, t2.id, round(MATCH t2.item AGAINST ('sushi'),6)
as x FROM t1, t2 WHERE (t2.id2 = t1.id) ORDER BY x DESC,t2.id;
SELECT t1.q, t2.item, t2.id, MATCH t2.item AGAINST ('sushi' IN BOOLEAN MODE)
as x FROM t1, t2 WHERE (t2.id2 = t1.id) ORDER BY x DESC,t2.id;
SELECT t1.q, t2.item, t2.id, round(MATCH t2.item AGAINST ('sushi'),6)
as x FROM t2, t1 WHERE (t2.id2 = t1.id) ORDER BY x DESC,t2.id;
SELECT t1.q, t2.item, t2.id, MATCH t2.item AGAINST ('sushi' IN BOOLEAN MODE)
as x FROM t2, t1 WHERE (t2.id2 = t1.id) ORDER BY x DESC,t2.id;
drop table t1, t2;
