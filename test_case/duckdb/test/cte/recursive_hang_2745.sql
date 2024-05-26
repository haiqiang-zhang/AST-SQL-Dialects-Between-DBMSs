with RECURSIVE parents_tab (id , value , parent )
as (values (1, 1, 2), (2, 2, 4), (3, 1, 4), (4, 2, -1), (5, 1, 2), (6, 2, 7), (7, 1, -1)
),
parents_tab2(id , value , parent )
as (values (1, 1, 2), (2, 2, 4), (3, 1, 4), (4, 2, -1), (5, 1, 2), (6, 2, 7), (7, 1, -1)
),
parents as (
    select * from parents_tab
    union all
    select id, value+2, parent from parents_tab2
)
select * from parents order by id, value, parent;
with RECURSIVE parents_tab (id , value , parent )
as (values (1, 1, 2), (2, 2, 4), (3, 1, 4), (4, 2, -1), (5, 1, 2), (6, 2, 7), (7, 1, -1)
),
parents_tab2(id , value , parent )
as (values (1, 1, 2), (2, 2, 4), (3, 1, 4), (4, 2, -1), (5, 1, 2), (6, 2, 7), (7, 1, -1)
)
select * from parents_tab
union all
select id, value+2, parent from parents_tab2 ORDER BY id, value, parent;
with parents_tab (id , value , parent )
as (values (1, 1, 2), (2, 2, 4), (3, 1, 4), (4, 2, -1), (5, 1, 2), (6, 2, 7), (7, 1, -1)
),
parents_tab2(id , value , parent )
as (values (1, 1, 2), (2, 2, 4), (3, 1, 4), (4, 2, -1), (5, 1, 2), (6, 2, 7), (7, 1, -1)
),
parents as (
    select * from parents_tab
    union all
    select id, value+2, parent from parents_tab2
)
select * from parents ORDER BY id, value, parent;
select * from vparents;
