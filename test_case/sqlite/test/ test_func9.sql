SELECT concat('abc',123,null,'xyz');
SELECT typeof(concat(null));
SELECT concat_ws(',',1,2,3,4,5,6,7,8,NULL,9,10,11,12);
SELECT concat_ws(NULL,1,2,3,4,5,6,7,8,NULL,9,10,11,12);
