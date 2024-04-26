--

-- source include/have_debug.inc

--disable_warnings
drop procedure if exists `empty`;
drop procedure if exists code_sample;

create procedure `empty`()
begin
end;
drop procedure `empty`;

create function almost_empty()
    returns int
  return 0;
drop function almost_empty;
create procedure code_sample(x int, out err int, out nulls int)
begin
  declare count int default 0;

  set nulls = 0;
    declare c cursor for select name from t1;
    declare exit handler for not found close c;

    open c;
    loop
      begin
        declare n varchar(20);
        declare continue handler for sqlexception set err=1;

        fetch c into n;
        if isnull(n) then
          set nulls = nulls + 1;
          set count = count + 1;
          update t2 set idx = count where name=n;
        end if;
      end;
    end loop;
  select t.name, t.idx from t2 t order by idx asc;
drop procedure code_sample;


--
-- BUG#15737: Stored procedure optimizer bug with LEAVE
--
-- This is a much more extensive test case than is strictly needed,
-- but it was kept as is for two reasons:
-- - The bug occurs under some quite special circumstances, so it
--   wasn't trivial to create a smaller test,
-- - There's some value in having another more complex code sample
--   in this test file. This might catch future code generation bugs
--   that doesn't show in behaviour in any obvious way.

--disable_warnings
drop procedure if exists sudoku_solve;
create procedure sudoku_solve(p_naive boolean, p_all boolean)
  deterministic
  modifies sql data
begin
  drop temporary table if exists sudoku_work, sudoku_schedule;

  create temporary table sudoku_work
  (
    `row` smallint not null,
    col smallint not null,
    dig smallint not null,
    cnt smallint,
    key using btree (cnt),
    key using btree (`row`),
    key using btree (col),
    unique key using hash (`row`,col)
  );

  create temporary table sudoku_schedule
  (
    idx int not null auto_increment primary key,
    `row` smallint not null,
    col smallint not null
  );

  if p_naive then
    update sudoku_work set cnt = 0 where dig = 0;
    call sudoku_count();
  end if;
  insert into sudoku_schedule (`row`,col)
    select `row`,col from sudoku_work where cnt is not null order by cnt desc;
    declare v_scounter bigint default 0;
    declare v_i smallint default 1;
    declare v_dig smallint;
    declare v_schedmax smallint;

    select count(*) into v_schedmax from sudoku_schedule;

   more: 
    loop
    begin
      declare v_tcounter bigint default 0;

     sched:
      while v_i <= v_schedmax do
      begin
        declare v_row, v_col smallint;

        select `row`,col into v_row,v_col from sudoku_schedule where v_i = idx;

        select dig into v_dig from sudoku_work
          where v_row = `row` and v_col = col;

        case v_dig
        when 0 then
          set v_dig = 1;
          update sudoku_work set dig = 1
            where v_row = `row` and v_col = col;
        when 9 then
          if v_i > 0 then
            update sudoku_work set dig = 0
              where v_row = `row` and v_col = col;
            set v_i = v_i - 1;
            iterate sched;
          else
            select v_scounter as 'Solutions';
            leave more;
          end if;
        else
          set v_dig = v_dig + 1;
          update sudoku_work set dig = v_dig
            where v_row = `row` and v_col = col;
        end case;

        set v_tcounter = v_tcounter + 1;
        if not sudoku_digit_ok(v_row, v_col, v_dig) then
          iterate sched;
        end if;
        set v_i = v_i + 1;
      end;
      end while sched;

      select dig from sudoku_work;
      select v_tcounter as 'Tests';
      set v_scounter = v_scounter + 1;

      if p_all and v_i > 0 then
        set v_i = v_i - 1;
      else
        leave more;
      end if;
    end;
    end loop more;

  drop temporary table sudoku_work, sudoku_schedule;

-- The interestings parts are where the code for the two "leave" are:
-- ...
--|  26 | jump_if_not 30 (v_i@3 > 0)                                            |
-- ...
--|  30 | stmt 0 "select v_scounter as 'Solutions'"                             |
--|  31 | jump 45                                                               |
-- ...
--|  42 | jump_if_not 45 (p_all@1 and (v_i@3 > 0))                              |
--|  43 | set v_i@3 (v_i@3 - 1)                                                 |
--|  44 | jump 14                                                               |
--|  45 | stmt 9 "drop temporary table sudoku_work, sud..."                     |
--+-----+-----------------------------------------------------------------------+
-- The bug appeared at position 42 (with the wrong destination).
show procedure code sudoku_solve;

drop procedure sudoku_solve;

--
-- Bug#19194 (Right recursion in parser for CASE causes excessive stack
--   usage, limitation)
-- This bug also exposed a flaw in the generated code with nested case
-- statements
--

--disable_warnings
DROP PROCEDURE IF EXISTS proc_19194_simple;
DROP PROCEDURE IF EXISTS proc_19194_searched;
DROP PROCEDURE IF EXISTS proc_19194_nested_1;
DROP PROCEDURE IF EXISTS proc_19194_nested_2;
DROP PROCEDURE IF EXISTS proc_19194_nested_3;
DROP PROCEDURE IF EXISTS proc_19194_nested_4;

CREATE PROCEDURE proc_19194_simple(i int)
BEGIN
  DECLARE str CHAR(10);
    WHEN 1 THEN SET str="1";
    WHEN 2 THEN SET str="2";
    WHEN 3 THEN SET str="3";
    ELSE SET str="unknown";
  END CASE;

  SELECT str;

CREATE PROCEDURE proc_19194_searched(i int)
BEGIN
  DECLARE str CHAR(10);
    WHEN i=1 THEN SET str="1";
    WHEN i=2 THEN SET str="2";
    WHEN i=3 THEN SET str="3";
    ELSE SET str="unknown";
  END CASE;

  SELECT str;

-- Outer SIMPLE case, inner SEARCHED case
CREATE PROCEDURE proc_19194_nested_1(i int, j int)
BEGIN
  DECLARE str_i CHAR(10);
    WHEN 10 THEN SET str_i="10";
    WHEN 20 THEN
    BEGIN
      set str_i="20";
      CASE
        WHEN j=1 THEN SET str_j="1";
        WHEN j=2 THEN SET str_j="2";
        WHEN j=3 THEN SET str_j="3";
      ELSE SET str_j="unknown";
      END CASE;
      select "i was 20";
    END;
    WHEN 30 THEN SET str_i="30";
    WHEN 40 THEN SET str_i="40";
    ELSE SET str_i="unknown";
  END CASE;

  SELECT str_i, str_j;

-- Outer SEARCHED case, inner SIMPLE case
CREATE PROCEDURE proc_19194_nested_2(i int, j int)
BEGIN
  DECLARE str_i CHAR(10);
    WHEN i=10 THEN SET str_i="10";
    WHEN i=20 THEN
    BEGIN
      set str_i="20";
      CASE j
        WHEN 1 THEN SET str_j="1";
        WHEN 2 THEN SET str_j="2";
        WHEN 3 THEN SET str_j="3";
      ELSE SET str_j="unknown";
      END CASE;
      select "i was 20";
    END;
    WHEN i=30 THEN SET str_i="30";
    WHEN i=40 THEN SET str_i="40";
    ELSE SET str_i="unknown";
  END CASE;

  SELECT str_i, str_j;

-- Outer SIMPLE case, inner SIMPLE case
CREATE PROCEDURE proc_19194_nested_3(i int, j int)
BEGIN
  DECLARE str_i CHAR(10);
    WHEN 10 THEN SET str_i="10";
    WHEN 20 THEN
    BEGIN
      set str_i="20";
      CASE j
        WHEN 1 THEN SET str_j="1";
        WHEN 2 THEN SET str_j="2";
        WHEN 3 THEN SET str_j="3";
      ELSE SET str_j="unknown";
      END CASE;
      select "i was 20";
    END;
    WHEN 30 THEN SET str_i="30";
    WHEN 40 THEN SET str_i="40";
    ELSE SET str_i="unknown";
  END CASE;

  SELECT str_i, str_j;

-- Outer SEARCHED case, inner SEARCHED case
CREATE PROCEDURE proc_19194_nested_4(i int, j int)
BEGIN
  DECLARE str_i CHAR(10);
    WHEN i=10 THEN SET str_i="10";
    WHEN i=20 THEN
    BEGIN
      set str_i="20";
      CASE
        WHEN j=1 THEN SET str_j="1";
        WHEN j=2 THEN SET str_j="2";
        WHEN j=3 THEN SET str_j="3";
      ELSE SET str_j="unknown";
      END CASE;
      select "i was 20";
    END;
    WHEN i=30 THEN SET str_i="30";
    WHEN i=40 THEN SET str_i="40";
    ELSE SET str_i="unknown";
  END CASE;

  SELECT str_i, str_j;

--
-- Before 19194, the generated code was:
--   20      jump_if_not 23(27) 30
--   21      set str_i@2 _latin1'30'
-- As opposed to the expected:
--   20      jump_if_not 23(27) (case_expr@0 = 30)
--   21      set str_i@2 _latin1'30'
--
-- and as a result, this call returned "30",
-- because the expression 30 is always true,
-- masking the case 40, case 0 and the else.
--
CALL proc_19194_nested_1(25, 1);

--
-- Before 19194, the generated code was:
--   20      jump_if_not 23(27) (case_expr@0 = (i@0 = 30))
--   21      set str_i@2 _latin1'30'
-- As opposed to the expected:
--   20      jump_if_not 23(27) (i@0 = 30)
--   21      set str_i@2 _latin1'30'
-- and as a result, this call crashed the server, because there is no
-- such variable as "case_expr@0".
--
CALL proc_19194_nested_2(25, 1);

DROP PROCEDURE proc_19194_simple;
DROP PROCEDURE proc_19194_searched;
DROP PROCEDURE proc_19194_nested_1;
DROP PROCEDURE proc_19194_nested_2;
DROP PROCEDURE proc_19194_nested_3;
DROP PROCEDURE proc_19194_nested_4;

--
-- Bug#19207: Final parenthesis omitted for CREATE INDEX in Stored
-- Procedure
--
-- Wrong criteria was used to distinguish the case when there was no
-- lookahead performed in the parser.  Bug affected only statements
-- ending in one-character token without any optional tail, like CREATE
-- INDEX and CALL.
--
--disable_warnings
DROP PROCEDURE IF EXISTS p1;

CREATE PROCEDURE p1() CREATE INDEX idx ON t1 (c1);

DROP PROCEDURE p1;


--
-- Bug#26977 exception handlers never hreturn
--
--disable_warnings
drop table if exists t1;
drop procedure if exists proc_26977_broken;
drop procedure if exists proc_26977_works;

create table t1(a int unique);

create procedure proc_26977_broken(v int)
begin
  declare i int default 5;
    select 'caught something';
    retry:
    while i > 0 do
      begin
        set i = i - 1;
        select 'looping', i;
      end;
    end while retry;

  select 'do something';
  insert into t1 values (v);
  select 'do something again';
  insert into t1 values (v);

create procedure proc_26977_works(v int)
begin
  declare i int default 5;
    select 'caught something';
    retry:
    while i > 0 do
      begin
        set i = i - 1;
        select 'looping', i;
      end;
    end while retry;
    select 'optimizer: keep hreturn';

  select 'do something';
  insert into t1 values (v);
  select 'do something again';
  insert into t1 values (v);

--# This caust an error because of jump short cut
--# optimization.
call proc_26977_broken(1);

--# This works
call proc_26977_works(2);

drop table t1;
drop procedure proc_26977_broken;
drop procedure proc_26977_works;

--
-- Bug#33618 Crash in sp_rcontext
--

--disable_warnings
drop procedure if exists proc_33618_h;
drop procedure if exists proc_33618_c;

create procedure proc_33618_h(num int)
begin
  declare count1 int default '0';
        
  while(num>=1) do
    set num=num-1;
    begin
      declare cur1 cursor for select `a` from t_33618;
      declare continue handler for not found set last_row = 1;
      set last_row:=0;
      open cur1;
      rep1:
      repeat
        begin
          declare exit handler for 1062 begin end;
          fetch cur1 into vb;
          if (last_row = 1) then
            --# should generate a hpop instruction here
            leave rep1;
          end if;
        end;
        until last_row=1
      end repeat;
      close cur1;
    end;
  end while;

create procedure proc_33618_c(num int)
begin
  declare count1 int default '0';
        
  while(num>=1) do
    set num=num-1;
    begin
      declare cur1 cursor for select `a` from t_33618;
      declare continue handler for not found set last_row = 1;
      set last_row:=0;
      open cur1;
      rep1:
      repeat
        begin
          declare cur2 cursor for select `b` from t_33618;
          fetch cur1 into vb;
          if (last_row = 1) then
            --# should generate a cpop instruction here
            leave rep1;
          end if;
        end;
        until last_row=1
      end repeat;
      close cur1;
    end;
  end while;

drop procedure proc_33618_h;
drop procedure proc_33618_c;

--
-- Bug#20906 (Multiple assignments in SET in stored routine produce incorrect
-- instructions)
--

--disable_warnings
drop procedure if exists p_20906_a;
drop procedure if exists p_20906_b;

create procedure p_20906_a() SET @a=@a+1, @b=@b+1;

set @a=1;
set @b=1;
select @a, @b;

create procedure p_20906_b() SET @a=@a+1, @b=@b+1, @c=@c+1;

set @a=1;
set @b=1;
set @c=1;
select @a, @b, @c;

drop procedure p_20906_a;
drop procedure p_20906_b;

--
-- Bug #26303: reserve() not called before qs_append() may lead to buffer
-- overflow
--
DELIMITER //;
CREATE PROCEDURE p1() 
BEGIN 
  DECLARE dummy int default 0;
    WHEN 12 
    THEN SET dummy = 0;
  END CASE;
DROP PROCEDURE p1;

CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES (1), (2), (3);

CREATE PROCEDURE p1()
BEGIN
  DECLARE c CURSOR FOR SELECT a FROM t1;
  
  BEGIN
    DECLARE v INT;

    DECLARE CONTINUE HANDLER FOR SQLWARNING
    BEGIN
      GET DIAGNOSTICS @n = NUMBER;
      GET DIAGNOSTICS CONDITION @n @err_no = MYSQL_ERRNO, @err_txt = MESSAGE_TEXT;
      SELECT "Warning found!";
      SELECT @err_no, @err_txt;
    END;

    DECLARE EXIT HANDLER FOR NOT FOUND
    BEGIN
      GET DIAGNOSTICS @n = NUMBER;
      GET DIAGNOSTICS CONDITION @n @err_no = MYSQL_ERRNO, @err_txt = MESSAGE_TEXT;
      SELECT "End of Result Set found!";
      SELECT @err_no, @err_txt;
    END;

    WHILE TRUE DO
      FETCH c INTO v;
    END WHILE;

  SELECT a INTO @foo FROM t1 LIMIT 1;

SET SESSION debug="+d,bug23032_emit_warning";
SET SESSION debug="-d,bug23032_emit_warning";

DROP PROCEDURE p1;
DROP TABLE t1;
SET @@SQL_MODE = '';
CREATE FUNCTION testf_bug11763507() RETURNS INT
BEGIN
    RETURN 0;
END
$

CREATE PROCEDURE testp_bug11763507()
BEGIN
    SELECT "PROCEDURE testp_bug11763507";
END
$

DELIMITER ;

-- STORED FUNCTIONS
SHOW FUNCTION CODE testf_bug11763507;

-- STORED PROCEDURE
SHOW PROCEDURE CODE testp_bug11763507;

DROP PROCEDURE testp_bug11763507;
DROP FUNCTION testf_bug11763507;

CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES (10);

CREATE TEMPORARY TABLE t2(a INT);
INSERT INTO t2 VALUES (20);

CREATE VIEW t3 AS SELECT 30;

CREATE FUNCTION f() RETURNS INT
  RETURN 1|

CREATE PROCEDURE p1()
BEGIN

  -- DEFAULT-expression

  DECLARE x1 INT DEFAULT (SELECT 1 + 2);

  -- CURSOR-query.

  DECLARE c1 CURSOR FOR SELECT (1 + 2) FROM dual;

  -- IF-expression.

  IF (SELECT 1 + 2) THEN
    SET @dummy = 1;
  END IF;

  IF (SELECT * FROM (SELECT 1 + 2) t1) THEN
    SET @dummy = 1;
  END IF;

  IF (SELECT * FROM t1) THEN
    SET @dummy = 1;
  END IF;

  IF (SELECT * FROM t2) THEN
    SET @dummy = 1;
  END IF;

  IF (SELECT * FROM t3) THEN
    SET @dummy = 1;
  END IF;

  IF (SELECT f()) THEN
    SET @dummy = 1;
  END IF;

  -- SET-expression.

  SET x1 = (SELECT 1 + 2);
  SET x1 = (SELECT * FROM (SELECT 1 + 2) t1);
  SET x1 = (SELECT * FROM t1);
  SET x1 = (SELECT * FROM t2);
  SET x1 = (SELECT * FROM t3);
  SET x1 = (SELECT f());

  -- CASE-expressions.

  CASE
    WHEN (SELECT 1 + 2) = 1                     THEN SET @dummy = 1;
    WHEN (SELECT * FROM (SELECT 1 + 2) t1) = 2  THEN SET @dummy = 1;
    WHEN (SELECT * FROM t1) = 3                 THEN SET @dummy = 1;
    WHEN (SELECT * FROM t2) = 3                 THEN SET @dummy = 1;
    WHEN (SELECT * FROM t3) = 3                 THEN SET @dummy = 1;
    WHEN (SELECT f()) = 3                       THEN SET @dummy = 1;
  END CASE;
    WHEN 1 THEN SET @dummy = 1;
    ELSE SET @dummy = 1;
  END CASE;
    WHEN 1 THEN SET @dummy = 1;
    ELSE SET @dummy = 1;
  END CASE;
    WHEN 1 THEN SET @dummy = 1;
    ELSE SET @dummy = 1;
  END CASE;
    WHEN 1 THEN SET @dummy = 1;
    ELSE SET @dummy = 1;
  END CASE;
    WHEN 1 THEN SET @dummy = 1;
    ELSE SET @dummy = 1;
  END CASE;
    WHEN 1 THEN SET @dummy = 1;
    ELSE SET @dummy = 1;
  END CASE;

  -- WHILE-expression.

  WHILE (SELECT 1 - 1) DO
    SET @dummy = 1;
  END WHILE;
    SET @dummy = 1;
  END WHILE;
    SET @dummy = 1;
  END WHILE;
    SET @dummy = 1;
  END WHILE;
    SET @dummy = 1;
  END WHILE;
    SET @dummy = 1;
  END WHILE;

  -- REPEAT-expression.

  REPEAT
    SET @dummy = 1;
    SET @dummy = 1;
    SET @dummy = 1;
    SET @dummy = 1;
    SET @dummy = 1;
  
  REPEAT
    SET @dummy = 1;

CREATE FUNCTION f1() RETURNS INT
  RETURN (SELECT 1 + 2)|

CREATE FUNCTION f2() RETURNS INT
  RETURN (SELECT * FROM (SELECT 1 + 2) t1)|

CREATE FUNCTION f3() RETURNS INT
  RETURN (SELECT * FROM t1)|

CREATE FUNCTION f4() RETURNS INT
  RETURN (SELECT * FROM t2)|

CREATE FUNCTION f5() RETURNS INT
  RETURN (SELECT * FROM t3)|

CREATE FUNCTION f6() RETURNS INT
  RETURN f()|

delimiter ;

DROP FUNCTION f;

DROP PROCEDURE p1;
DROP FUNCTION f1;
DROP FUNCTION f2;
DROP FUNCTION f3;
DROP FUNCTION f4;
DROP FUNCTION f5;
DROP FUNCTION f6;

DROP TABLE t1;
DROP TEMPORARY TABLE t2;
DROP VIEW t3;

CREATE PROCEDURE p11_many_handlers ()
BEGIN
  DECLARE CONTINUE HANDLER FOR 1050             SELECT "1050 for 401a, please";
    DECLARE EXIT   HANDLER FOR NOT FOUND, 1,2   SELECT "multi multi";
DROP PROCEDURE p11_many_handlers;
