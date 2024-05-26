SELECT tupleElement(arrayJoin([(1, 1)]), 1) FROM A_M PREWHERE tupleElement((1, 1), 1) =1;
drop table A1;
drop table A_M;
