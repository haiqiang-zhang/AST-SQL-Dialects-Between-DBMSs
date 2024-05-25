SET allow_experimental_analyzer=1;
CREATE TABLE t1 ( k Int64, x Int64) ENGINE = Memory;
CREATE TABLE t2( x Int64 ) ENGINE = Memory;
create table s (k Int64, d DateTime)  Engine=Memory;
