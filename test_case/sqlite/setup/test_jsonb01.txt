CREATE TABLE t1(x JSON BLOB);
INSERT INTO t1 VALUES(jsonb('{a:5,b:{x:10,y:11},c:[1,2,3,4]}'));
