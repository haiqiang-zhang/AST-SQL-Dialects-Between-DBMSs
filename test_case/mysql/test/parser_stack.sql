
--
-- These tests are designed to cause an internal parser stack overflow,
-- and trigger my_yyoverflow().
--

use test;

SELECT
((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
1
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
;
SELECT
((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
1
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
"
;
drop view if exists view_overflow;

CREATE VIEW view_overflow AS
SELECT
((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
1
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
;

SELECT * from view_overflow;

drop view view_overflow;
drop procedure if exists proc_overflow;

CREATE PROCEDURE proc_overflow()
BEGIN

  BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN
  BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN
  BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN
  BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN
  BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN
  BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN
  BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN
  BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN
  BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN
  BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN

  select 1;
  select 2;
  select 3;

END $$

delimiter ;

drop procedure proc_overflow;
drop function if exists func_overflow;

create function func_overflow() returns int
BEGIN
  DECLARE x int default 0;

  SET x=x+1;
  SET x=x+2;
  SET x=x+3;
END $$

delimiter ;

select func_overflow();

drop function func_overflow;
drop table if exists table_overflow;

create table table_overflow(a int, b int);

create trigger trigger_overflow before insert on table_overflow
for each row
BEGIN

  BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN
  BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN
  BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN
  BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN
  BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN
  BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN
  BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN
  BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN
  BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN
  BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN BEGIN

  SET NEW.b := NEW.a;
  SET NEW.b := NEW.b + 1;
  SET NEW.b := NEW.b + 2;
  SET NEW.b := NEW.b + 3;

END $$

delimiter ;

insert into table_overflow set a=10;
insert into table_overflow set a=20;
select * from table_overflow;

drop table table_overflow;
drop procedure if exists proc_35577;

CREATE PROCEDURE proc_35577()
BEGIN
  DECLARE z_done INT DEFAULT 0;
    IF t_done=1  THEN
      LEAVE outer_loop;
    END IF;

    inner_block:BEGIN
      DECLARE z_done INT DEFAULT  0;
      SET z_done = 0;
      inner_loop: LOOP
        IF z_done=1  THEN
          LEAVE inner_loop;
        END IF;
        IF (t_done = 'a') THEN
          IF (t_done <> 0) THEN
            IF ( t_done > 0) THEN
              IF (t_done = 'a') THEN
                SET t_done = 'a';
              ELSEIF (t_done = 'a') THEN
                SET t_done = 'a';
              ELSEIF(t_done = 'a') THEN
                SET t_done = 'a';
              ELSEIF(t_done = 'a') THEN
                SET t_done = 'a';
              ELSEIF(t_done = 'a') THEN
                SET t_done = 'a';
              ELSEIF(t_done = 'a') THEN
                SET t_done = 'a';
              ELSEIF(t_done = 'a') THEN
                SET t_done = 'a';
              ELSEIF(t_done = 'a') THEN
                SET t_done = 'a';
              END IF;
            END IF;
          END IF;
        END IF;
      END LOOP inner_loop;
    END inner_block;
  END LOOP outer_loop;
END $$

delimiter ;

drop procedure proc_35577;

--
-- Bug#37269 (parser crash when creating stored procedure)
--

--disable_warnings
drop procedure if exists p_37269;

create procedure p_37269()
begin
  declare done int default 0;
    select now();
    select now();
    begin
      select now();
      repeat
        select now();
      until done end repeat;
      if vara then 
        select now();
        repeat
          select now();
          loop
            select now();
          end loop;
          repeat
            select now();
            label1: while varb do
              select now();
            end while label1;
            if vara then 
              select now();
              repeat
                select now();
              until done end repeat;
              begin
                select now();
                while varb do
                  select now();
                  label1: while varb do
                    select now();
                  end while label1;
                  if vara then 
                    select now();
                    while varb do
                      select now();
                      loop
                        select now();
                      end loop;
                      repeat
                        select now();
                        loop
                          select now();
                          while varb do
                            select now();
                          end while;
                          repeat
                            select now();
                            label1: loop
                              select now();
                              if vara then 
                                select now();
                              end if;
                            end loop label1;
                          until done end repeat;
                        end loop;
                      until done end repeat;
                    end while;
                  end if;
                end while;
              end;
            end if;
          until done end repeat;
        until done end repeat;
      end if;
    end;
  end while;
end $$

delimiter ;

drop procedure p_37269;

--
-- Bug#37228 (Sever crashes when creating stored procedure with more than
--            10 IF/ELSEIF)
--

--disable_warnings
drop procedure if exists p_37228;

create procedure p_37228 ()
BEGIN
  DECLARE v INT DEFAULT 123;

  IF (v > 1) THEN SET v = 1;
  END IF;
END $$

delimiter ;

drop procedure p_37228;

--
-- Bug#27863 (excessive memory usage for many small queries in a multiquery
-- packet).
--

let $i=`select repeat("set @a=1;
