select 'inner';
select X.*, Y.* from X inner join Y on X.id = Y.id order by X.id, X.x_a, X.x_b, Y.id, Y.y_a, Y.y_b;
select 'inner subs';
select s.*, j.* from (select * from X) as s inner join (select * from Y) as j on s.id = j.id order by s.id, s.x_a, s.x_b, j.id, j.y_a, j.y_b;
select 'inner expr';
select X.*, Y.* from X inner join Y on (X.id + 1) = (Y.id + 1) order by X.id, X.x_a, X.x_b, Y.id, Y.y_a, Y.y_b;
select 'left';
select X.*, Y.* from X left join Y on X.id = Y.id order by X.id, X.x_a, X.x_b, Y.id, Y.y_a, Y.y_b;
select 'left subs';
select s.*, j.* from (select * from X) as s left join (select * from Y) as j on s.id = j.id order by s.id, s.x_a, s.x_b, j.id, j.y_a, j.y_b;
select 'left expr';
select X.*, Y.* from X left join Y on (X.id + 1) = (Y.id + 1) order by X.id, X.x_a, X.x_b, Y.id, Y.y_a, Y.y_b;
select 'right';
select X.*, Y.* from X right join Y on X.id = Y.id order by X.id, X.x_a, X.x_b, Y.id, Y.y_a, Y.y_b;
select 'right subs';
select s.*, j.* from (select * from X) as s right join (select * from Y) as j on s.id = j.id order by s.id, s.x_a, s.x_b, j.id, j.y_a, j.y_b;
select 'full';
select X.*, Y.* from X full join Y on X.id = Y.id order by X.id, X.x_a, X.x_b, Y.id, Y.y_a, Y.y_b;
select 'full subs';
select s.*, j.* from (select * from X) as s full join (select * from Y) as j on s.id = j.id order by s.id, s.x_a, s.x_b, j.id, j.y_a, j.y_b;
select 'self inner';
select X.*, s.* from X inner join (select * from X) as s on X.id = s.id order by X.id, X.x_a, X.x_b, s.id, s.x_a, s.x_b;
select 'self inner nullable';
select X.*, s.* from X inner join (select * from X) as s on X.x_b = s.x_b order by X.id, X.x_a, X.x_b, s.id, s.x_a, s.x_b;
select 'self inner nullable vs not nullable';
select X.*, s.* from X inner join (select * from X) as s on X.id = s.x_b order by X.id, X.x_a, X.x_b, s.id, s.x_a, s.x_b;
select 'self inner nullable vs not nullable 2';
select Y.*, s.* from Y inner join (select * from Y) as s on concat('n', Y.y_a) = s.y_b order by Y.id, Y.y_a, Y.y_b, s.id, s.y_a, s.y_b;
select 'self left';
select X.*, s.* from X left join (select * from X) as s on X.id = s.id order by X.id, X.x_a, X.x_b, s.id, s.x_a, s.x_b;
select 'self left nullable';
select X.*, s.* from X left join (select * from X) as s on X.x_b = s.x_b order by X.id, X.x_a, X.x_b, s.id, s.x_a, s.x_b;
select 'self left nullable vs not nullable';
select X.*, s.* from X left join (select * from X) as s on X.id = s.x_b order by X.id, X.x_a, X.x_b, s.id, s.x_a, s.x_b;
select 'self left nullable vs not nullable 2';
select Y.*, s.* from Y left join (select * from Y) as s on concat('n', Y.y_a) = s.y_b order by Y.id, Y.y_a, Y.y_b, s.id, s.y_a, s.y_b;
select 'self right';
select X.*, s.* from X right join (select * from X) as s on X.id = s.id order by X.id, X.x_a, X.x_b, s.id, s.x_a, s.x_b;
select 'self right nullable';
select X.*, s.* from X right join (select * from X) as s on X.x_b = s.x_b order by X.id, X.x_a, X.x_b, s.id, s.x_a, s.x_b;
select 'self right nullable vs not nullable';
select X.*, s.* from X right join (select * from X) as s on X.id = s.x_b order by X.id, X.x_a, X.x_b, s.id, s.x_a, s.x_b;
select 'self full';
select X.*, s.* from X full join (select * from X) as s on X.id = s.id order by X.id, X.x_a, X.x_b, s.id, s.x_a, s.x_b;
select 'self full nullable';
select X.*, s.* from X full join (select * from X) as s on X.x_b = s.x_b order by X.id, X.x_a, X.x_b, s.id, s.x_a, s.x_b;
select 'self full nullable vs not nullable';
select X.*, s.* from X full join (select * from X) as s on X.id = s.x_b order by X.id, X.x_a, X.x_b, s.id, s.x_a, s.x_b;
drop table X;
drop table Y;
