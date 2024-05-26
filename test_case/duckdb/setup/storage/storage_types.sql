CREATE TABLE a_interval AS SELECT interval (range) year i FROM range(1,1001);
CREATE TABLE a_bool AS SELECT range%2=0 i FROM range(1000);
