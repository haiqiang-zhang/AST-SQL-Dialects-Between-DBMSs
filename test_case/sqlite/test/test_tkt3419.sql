select * FROM a, b, c WHERE a.id=2 AND b.a_id = a.id AND b.id=c.b_id;
select * FROM a, c, b WHERE a.id=2 AND b.a_id = a.id AND b.id=c.b_id;
select * FROM b, a, c WHERE a.id=2 AND b.a_id = a.id AND b.id=c.b_id;
select * FROM b, c, a WHERE a.id=2 AND b.a_id = a.id AND b.id=c.b_id;
select * FROM c, a, b WHERE a.id=2 AND b.a_id = a.id AND b.id=c.b_id;
select * FROM c, b, a WHERE a.id=2 AND b.a_id = a.id AND b.id=c.b_id;
