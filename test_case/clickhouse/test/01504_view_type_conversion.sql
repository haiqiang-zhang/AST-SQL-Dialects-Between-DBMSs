select groupArray(a) from testv;
DROP TABLE testv;
create view testv(a String) as select number a from numbers(10);
DROP TABLE testv;
