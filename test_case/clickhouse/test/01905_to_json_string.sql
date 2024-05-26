select * apply toJSONString from t;
set allow_experimental_map_type = 1;
select toJSONString(map('1234', '5678'));
