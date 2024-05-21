SET param_o = 'a';
CREATE TABLE test.xxx (a Int64) ENGINE=MergeTree ORDER BY ({o:String});