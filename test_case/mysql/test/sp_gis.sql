
use test;

--
-- BUG#21025: misleading error message when creating functions named 'x', or 'y'
--
-- Note: Since the functions 'x' and 'y' now are deprecated and removed,
-- this bug is tested using the functions 'st_x' and 'st_y' to verify
-- correct behaviour.
--

--disable_warnings
drop function if exists a;
drop function if exists st_x;
drop function if exists st_y;

create function a() returns int
return 1;

create function st_x() returns int
return 2;

create function st_y() returns int
return 3;

select a();
select st_x();
select st_y();
select st_x(ST_PointFromText("POINT(10 20)")), st_y(ST_PointFromText("POINT(10 20)"));

-- Non deterministic warnings from db_load_routine
--disable_warnings
select test.a(), test.st_x(), test.st_y();

drop function a;
drop function st_x;
drop function st_y;
