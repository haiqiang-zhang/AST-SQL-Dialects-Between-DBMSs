select json_group_array(v) from t1;
select json_group_object(n, v) from t1;
select json_group_object(n, v) from t1 group by n % 2 order by all;
select json_group_object(n, v) from t1 group by n % 2 order by all;
select json_group_structure(j) from t2;
select json(' { "this" : "is", "a": [ "test" ] }');
