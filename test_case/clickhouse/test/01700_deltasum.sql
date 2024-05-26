select deltaSum(arrayJoin([1, 2, 3]));
select deltaSumMerge(rows) as delta_sum from
(
    select * from
    (
        select deltaSumState(arrayJoin([0, 1])) as rows
        union all
        select deltaSumState(arrayJoin([4, 5])) as rows
    ) order by rows
) order by delta_sum;
select deltaSumMerge(rows) as delta_sum from
(
    select * from
    (
        select deltaSumState(arrayJoin([4, 5])) as rows
        union all
        select deltaSumState(arrayJoin([0, 1])) as rows
    ) order by rows
) order by delta_sum;
select deltaSumMerge(rows) as delta_sum from
(
    select * from
    (
        select deltaSumState(arrayJoin([0.1, 0.3, 0.5])) as rows
        union all
        select deltaSumState(arrayJoin([4.1, 5.1, 6.6])) as rows
    ) order by rows
) order by delta_sum;
select deltaSumMerge(rows) as delta_sum from
(
    select * from
    (
        select deltaSumState(arrayJoin([3, 5])) as rows
        union all
        select deltaSumState(arrayJoin([1, 2])) as rows
        union all
        select deltaSumState(arrayJoin([4, 6])) as rows
    ) order by rows
) order by delta_sum;
