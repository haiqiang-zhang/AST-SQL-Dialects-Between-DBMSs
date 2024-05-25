SET max_memory_usage = 50000000;
select test2_00863.id
from test1_00863, test2_00863, test3_00863
where test1_00863.code in ('1', '2', '3')
    and test2_00863.test1_id = test1_00863.id
    and test2_00863.test3_id = test3_00863.id;
drop table test1_00863;
drop table test2_00863;
drop table test3_00863;
