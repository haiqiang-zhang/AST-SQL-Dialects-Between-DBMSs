select arrayJoin(val) as nameGroup6, countDistinct(nid) as rowids from t1_00729 where notEmpty(toString(nameGroup6)) group by nameGroup6 order by nameGroup6;
drop table t1_00729;
