select '---- arrays ----';
select cityHash64( toString( groupArray (tuple(*) ) )) from (
    select brand_id, rack_id, arrayJoin(arraySlice(arraySort(groupArray(quantity)),1,2)) quantity
    from stack
    group by brand_id, rack_id
    order by brand_id, rack_id, quantity
) t;
select '---- window f ----';
drop table if exists stack;
