create materialized view mv_02231 to buffer_02231 as select
    number as key,
    groupArrayState(toString(number)) as v1
from in_02231
group by key;
drop table buffer_02231;
drop table out_02231;
drop table in_02231;
drop table mv_02231;
