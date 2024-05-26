SELECT x FROM t1 WHERE c=instr('abcdefg',b) OR a='abcdefg' ORDER BY +x;
SELECT x FROM t1 WHERE a='abcdefg' OR c=instr('abcdefg',b) ORDER BY +x;
CREATE TABLE t2(x,y);
INSERT INTO t2 VALUES(1,2),(3,4),(5,6),(7,8);
SELECT x, y FROM t2 WHERE x+5=5+x ORDER BY +x;
