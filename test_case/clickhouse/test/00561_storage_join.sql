select * from joinbug;
select id, id2, val, val2, created
from ( SELECT toUInt64(arrayJoin(range(50))) AS id2 ) js1
SEMI LEFT JOIN joinbug_join using id2;
SELECT * FROM ( SELECT toUInt32(11) AS id2 ) AS js1 SEMI LEFT JOIN joinbug_join USING (id2);
DROP TABLE joinbug;
DROP TABLE joinbug_join;
