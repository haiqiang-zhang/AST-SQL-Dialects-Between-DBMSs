--                                             #
--   Prepared Statements test on               #
--   "nested sets" representing hierarchies    #
--                                             #
--##############################################

-- Source: http://kris.koehntopp.de/artikel/sql-self-references (dated 1999)
-- Source: http://dbmsmag.com/9603d06.html (dated 1996)

--disable_warnings
drop table if exists t1;

-- "Nested Set": This table represents an employee list with a hierarchy tree.
-- The tree is not modeled by "parent" links but rather by showing the "left"
-- and "right" border of any person's "region". By convention, "l" < "r".
-- As it is a tree, these "regions" of two persons A and B are either disjoint,
-- or A's region is completely contained in B's (B.l < A.l < A.r < B.r:
-- B is A's boss), or vice versa.
-- Any other overlaps violate the model. See the references for more info.

create table t1  (
  id     INTEGER AUTO_INCREMENT PRIMARY KEY,
  emp    CHAR(10) NOT NULL,
  salary DECIMAL(6,2) NOT NULL,
  l INTEGER NOT NULL,
  r INTEGER NOT NULL);

-- Initial employee list:
-- Jerry ( Bert () Chuck ( Donna () Eddie () Fred () ) )
set @arg_nam= 'Jerry';
set @arg_nam= 'Bert';
set @arg_nam= 'Chuck';
set @arg_nam= 'Donna';
set @arg_nam= 'Eddie';
set @arg_nam= 'Fred';

select * from t1;

-- Three successive raises, each one is 100 units for managers, 10 percent for others.
prepare st_raise_base from 'update t1 set salary = salary * ( 1 + ? ) where r - l = 1';
let $1= 3;
set @arg_percent= .10;
set @arg_amount= 100;
{
  execute st_raise_base using @arg_percent;
  dec $1;

select * from t1;

-- Now, increase salary to a multiple of 50 (checks for bug#6138)
prepare st_round from 'update t1 set salary = salary + ? - ( salary MOD ? )';
set @arg_round= 50;

select * from t1;

drop table t1;
