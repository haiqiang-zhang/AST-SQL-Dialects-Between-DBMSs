PRAGMA enable_verification;
create table my_functions as select 'my_name' as function_name;
select
    function_name as raw,
    replace(raw, '_', ' ') as prettier
from my_functions
group by all;
