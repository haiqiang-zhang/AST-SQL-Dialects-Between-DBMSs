select arraySort(arrayIntersect(arr, [1,2])) from array_intersect order by arr;
optimize table array_intersect;
drop table if exists array_intersect;
select '-';
