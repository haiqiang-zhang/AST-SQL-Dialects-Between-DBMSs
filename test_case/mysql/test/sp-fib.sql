drop table if exists t3;
create table t3 ( f bigint unsigned not null );

-- We deliberately do it the awkward way, fetching the last two
-- values from the table, in order to exercise various statements
-- and table accesses at each turn.
--disable_warnings
drop procedure if exists fib;

-- Now for multiple statements...
delimiter |;

create procedure fib(n int unsigned)
begin
  if n > 1 then
    begin
      declare x, y bigint unsigned;
      declare c cursor for select f from t3 order by f desc limit 2;
      open c;
      fetch c into y;
      fetch c into x;
      insert into t3 values (x+y);
      call fib(n-1);
      --# Close the cursor AFTER the recursion to ensure that the stack
      --# frame is somewhat intact.
      close c;
    end;
  end if;
