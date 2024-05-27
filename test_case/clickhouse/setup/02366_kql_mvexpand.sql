DROP TABLE IF EXISTS mv_expand_test_table;
CREATE TABLE mv_expand_test_table
(    
   a UInt8,
   b Array(String),
   c Array(Int8),
   d Array(Int8)
) ENGINE = Memory;
INSERT INTO mv_expand_test_table VALUES (1, ['Salmon', 'Steak','Chicken'],[1,2,3,4],[5,6,7,8]);
set dialect='kusto';