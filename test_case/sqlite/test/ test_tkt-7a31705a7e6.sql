SELECT t1.a FROM ((t1 JOIN t2 ON t1.a=t2.a) AS x JOIN t2x ON x.b=t2x.b) as y;
