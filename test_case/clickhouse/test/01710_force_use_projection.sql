set optimize_use_projections = 1, force_optimize_projection = 1;
select sum(eventcnt) eventcnt, d1 from tp group by d1;
select avg(eventcnt) eventcnt, d1 from tp group by d1;
insert into tp values (1, 2, 3);
select sum(eventcnt) eventcnt, d1 from tp group by d1;
drop table tp;
