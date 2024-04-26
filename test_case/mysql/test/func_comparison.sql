CREATE TABLE t1
(pk INTEGER PRIMARY KEY,
 i1 TINYINT,
 u1 TINYINT UNSIGNED,
 i2 SMALLINT,
 u2 SMALLINT UNSIGNED,
 i3 MEDIUMINT,
 u3 MEDIUMINT UNSIGNED,
 i4 INTEGER,
 u4 INTEGER UNSIGNED,
 i8 BIGINT,
 u8 BIGINT UNSIGNED);

INSERT INTO t1 VALUES
(0, -128, 0, -32768, 0, -8388608, 0, -2147483648, 0, -9223372036854775808, 0),
(1, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0),
(2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
(4, 127, 255, 32767, 65535, 8388607, 16777215, 2147483647, 4294967295,
 9223372036854775807, 18446744073709551615);

let $prep_query1=
SELECT i1 = ? AS a,
       u1 = ? AS au,
       i2 = ? AS b,
       u2 = ? AS bu,
       i3 = ? AS c,
       u3 = ? AS cu,
       i4 = ? AS d,
       u4 = ? AS du,
       i8 = ? AS e,
       u8 = ? AS eu
FROM t1;

let $prep_query2=
SELECT i1 <> ? AS a,
       u1 <> ? AS au,
       i2 <> ? AS b,
       u2 <> ? AS bu,
       i3 <> ? AS c,
       u3 <> ? AS cu,
       i4 <> ? AS d,
       u4 <> ? AS du,
       i8 <> ? AS e,
       u8 <> ? AS eu
FROM t1;

let $prep_query3=
SELECT i1 < ? AS a,
       u1 < ? AS au,
       i2 < ? AS b,
       u2 < ? AS bu,
       i3 < ? AS c,
       u3 < ? AS cu,
       i4 < ? AS d,
       u4 < ? AS du,
       i8 < ? AS e,
       u8 < ? AS eu
FROM t1;

let $prep_query4=
SELECT i1 >= ? AS a,
       u1 >= ? AS au,
       i2 >= ? AS b,
       u2 >= ? AS bu,
       i3 >= ? AS c,
       u3 >= ? AS cu,
       i4 >= ? AS d,
       u4 >= ? AS du,
       i8 >= ? AS e,
       u8 >= ? AS eu
FROM t1;

let $prep_query5=
SELECT i1 <= ? AS a,
       u1 <= ? AS au,
       i2 <= ? AS b,
       u2 <= ? AS bu,
       i3 <= ? AS c,
       u3 <= ? AS cu,
       i4 <= ? AS d,
       u4 <= ? AS du,
       i8 <= ? AS e,
       u8 <= ? AS eu
FROM t1;

let $prep_query6=
SELECT i1 > ? AS a,
       u1 > ? AS au,
       i2 > ? AS b,
       u2 > ? AS bu,
       i3 > ? AS c,
       u3 > ? AS cu,
       i4 > ? AS d,
       u4 > ? AS du,
       i8 > ? AS e,
       u8 > ? AS eu
FROM t1;

let $i=0;
{
  if ($i == 0)
  {
    let $value= -9223372036854775809;
  }
  if ($i == 1)
  {
    let $value= -9223372036854775808;
  }
  if ($i == 2)
  {
    let $value= -2147483648;
  }
  if ($i == 3)
  {
    let $value= -8388608;
  }
  if ($i == 4)
  {
    let $value= -32768;
  }
  if ($i == 5)
  {
    let $value= -128;
  }
  if ($i == 6)
  {
    let $value= 0;
  }
  if ($i == 7)
  {
    let $value= 127;
  }
  if ($i == 8)
  {
    let $value= 255;
  }
  if ($i == 9)
  {
    let $value= 32767;
  }
  if ($i == 10)
  {
    let $value= 65535;
  }
  if ($i == 11)
  {
    let $value= 8388607;
  }
  if ($i == 12)
  {
    let $value= 16777215;
  }
  if ($i == 13)
  {
    let $value= 2147483647;
  }
  if ($i == 14)
  {
    let $value= 4294967295;
  }
  if ($i == 15)
  {
    let $value= 9223372036854775807;
  }
  if ($i == 16)
  {
    let $value= 9223372036854775808;
  }
  if ($i == 17)
  {
    let $value= 18446744073709551615;
  }
  if ($i == 18)
  {
    let $value= 18446744073709551616;
  }
  let $d_value=$value.0;
  let $f_value=$value.0e0;
  let $s_value='$value';

  let $query=
  SELECT i1 = $value AS a,
         u1 = $value AS au,
         i2 = $value AS b,
         u2 = $value AS bu,
         i3 = $value AS c,
         u3 = $value AS cu,
         i4 = $value AS d,
         u4 = $value AS du,
         i8 = $value AS e,
         u8 = $value AS eu
  FROM t1;

  let $query=
  SELECT i1 = $d_value AS a,
         u1 = $d_value AS au,
         i2 = $d_value AS b,
         u2 = $d_value AS bu,
         i3 = $d_value AS c,
         u3 = $d_value AS cu,
         i4 = $d_value AS d,
         u4 = $d_value AS du,
         i8 = $d_value AS e,
         u8 = $d_value AS eu
  FROM t1;

  let $query=
  SELECT i1 = $f_value AS a,
         u1 = $f_value AS au,
         i2 = $f_value AS b,
         u2 = $f_value AS bu,
         i3 = $f_value AS c,
         u3 = $f_value AS cu,
         i4 = $f_value AS d,
         u4 = $f_value AS du,
         i8 = $f_value AS e,
         u8 = $f_value AS eu
  FROM t1;

  let $query=
  SELECT i1 = $s_value AS a,
         u1 = $s_value AS au,
         i2 = $s_value AS b,
         u2 = $s_value AS bu,
         i3 = $s_value AS c,
         u3 = $s_value AS cu,
         i4 = $s_value AS d,
         u4 = $s_value AS du,
         i8 = $s_value AS e,
         u8 = $s_value AS eu
  FROM t1;

  let $query=
  SELECT i1 <> $value AS a,
         u1 <> $value AS au,
         i2 <> $value AS b,
         u2 <> $value AS bu,
         i3 <> $value AS c,
         u3 <> $value AS cu,
         i4 <> $value AS d,
         u4 <> $value AS du,
         i8 <> $value AS e,
         u8 <> $value AS eu
  FROM t1;

  let $query=
  SELECT i1 <> $d_value AS a,
         u1 <> $d_value AS au,
         i2 <> $d_value AS b,
         u2 <> $d_value AS bu,
         i3 <> $d_value AS c,
         u3 <> $d_value AS cu,
         i4 <> $d_value AS d,
         u4 <> $d_value AS du,
         i8 <> $d_value AS e,
         u8 <> $d_value AS eu
  FROM t1;

  let $query=
  SELECT i1 <> $f_value AS a,
         u1 <> $f_value AS au,
         i2 <> $f_value AS b,
         u2 <> $f_value AS bu,
         i3 <> $f_value AS c,
         u3 <> $f_value AS cu,
         i4 <> $f_value AS d,
         u4 <> $f_value AS du,
         i8 <> $f_value AS e,
         u8 <> $f_value AS eu
  FROM t1;

  let $query=
  SELECT i1 <> $s_value AS a,
         u1 <> $s_value AS au,
         i2 <> $s_value AS b,
         u2 <> $s_value AS bu,
         i3 <> $s_value AS c,
         u3 <> $s_value AS cu,
         i4 <> $s_value AS d,
         u4 <> $s_value AS du,
         i8 <> $s_value AS e,
         u8 <> $s_value AS eu
  FROM t1;

  let $query=
  SELECT i1 < $value AS a,
         u1 < $value AS au,
         i2 < $value AS b,
         u2 < $value AS bu,
         i3 < $value AS c,
         u3 < $value AS cu,
         i4 < $value AS d,
         u4 < $value AS du,
         i8 < $value AS e,
         u8 < $value AS eu
  FROM t1;

  let $query=
  SELECT i1 < $d_value AS a,
         u1 < $d_value AS au,
         i2 < $d_value AS b,
         u2 < $d_value AS bu,
         i3 < $d_value AS c,
         u3 < $d_value AS cu,
         i4 < $d_value AS d,
         u4 < $d_value AS du,
         i8 < $d_value AS e,
         u8 < $d_value AS eu
  FROM t1;

  let $query=
  SELECT i1 < $f_value AS a,
         u1 < $f_value AS au,
         i2 < $f_value AS b,
         u2 < $f_value AS bu,
         i3 < $f_value AS c,
         u3 < $f_value AS cu,
         i4 < $f_value AS d,
         u4 < $f_value AS du,
         i8 < $f_value AS e,
         u8 < $f_value AS eu
  FROM t1;

  let $query=
  SELECT i1 < $s_value AS a,
         u1 < $s_value AS au,
         i2 < $s_value AS b,
         u2 < $s_value AS bu,
         i3 < $s_value AS c,
         u3 < $s_value AS cu,
         i4 < $s_value AS d,
         u4 < $s_value AS du,
         i8 < $s_value AS e,
         u8 < $s_value AS eu
  FROM t1;

  let $query=
  SELECT i1 >= $value AS a,
         u1 >= $value AS au,
         i2 >= $value AS b,
         u2 >= $value AS bu,
         i3 >= $value AS c,
         u3 >= $value AS cu,
         i4 >= $value AS d,
         u4 >= $value AS du,
         i8 >= $value AS e,
         u8 >= $value AS eu
  FROM t1;
  let $query=
  SELECT i1 >= $d_value AS a,
         u1 >= $d_value AS au,
         i2 >= $d_value AS b,
         u2 >= $d_value AS bu,
         i3 >= $d_value AS c,
         u3 >= $d_value AS cu,
         i4 >= $d_value AS d,
         u4 >= $d_value AS du,
         i8 >= $d_value AS e,
         u8 >= $d_value AS eu
  FROM t1;

  let $query=
  SELECT i1 >= $f_value AS a,
         u1 >= $f_value AS au,
         i2 >= $f_value AS b,
         u2 >= $f_value AS bu,
         i3 >= $f_value AS c,
         u3 >= $f_value AS cu,
         i4 >= $f_value AS d,
         u4 >= $f_value AS du,
         i8 >= $f_value AS e,
         u8 >= $f_value AS eu
  FROM t1;

  let $query=
  SELECT i1 >= $s_value AS a,
         u1 >= $s_value AS au,
         i2 >= $s_value AS b,
         u2 >= $s_value AS bu,
         i3 >= $s_value AS c,
         u3 >= $s_value AS cu,
         i4 >= $s_value AS d,
         u4 >= $s_value AS du,
         i8 >= $s_value AS e,
         u8 >= $s_value AS eu
  FROM t1;

  let $query=
  SELECT i1 <= $value AS a,
         u1 <= $value AS au,
         i2 <= $value AS b,
         u2 <= $value AS bu,
         i3 <= $value AS c,
         u3 <= $value AS cu,
         i4 <= $value AS d,
         u4 <= $value AS du,
         i8 <= $value AS e,
         u8 <= $value AS eu
  FROM t1;

  let $query=
  SELECT i1 <= $d_value AS a,
         u1 <= $d_value AS au,
         i2 <= $d_value AS b,
         u2 <= $d_value AS bu,
         i3 <= $d_value AS c,
         u3 <= $d_value AS cu,
         i4 <= $d_value AS d,
         u4 <= $d_value AS du,
         i8 <= $d_value AS e,
         u8 <= $d_value AS eu
  FROM t1;

  let $query=
  SELECT i1 <= $f_value AS a,
         u1 <= $f_value AS au,
         i2 <= $f_value AS b,
         u2 <= $f_value AS bu,
         i3 <= $f_value AS c,
         u3 <= $f_value AS cu,
         i4 <= $f_value AS d,
         u4 <= $f_value AS du,
         i8 <= $f_value AS e,
         u8 <= $f_value AS eu
  FROM t1;

  let $query=
  SELECT i1 <= $s_value AS a,
         u1 <= $s_value AS au,
         i2 <= $s_value AS b,
         u2 <= $s_value AS bu,
         i3 <= $s_value AS c,
         u3 <= $s_value AS cu,
         i4 <= $s_value AS d,
         u4 <= $s_value AS du,
         i8 <= $s_value AS e,
         u8 <= $s_value AS eu
  FROM t1;

  let $query=
  SELECT i1 > $value AS a,
         u1 > $value AS au,
         i2 > $value AS b,
         u2 > $value AS bu,
         i3 > $value AS c,
         u3 > $value AS cu,
         i4 > $value AS d,
         u4 > $value AS du,
         i8 > $value AS e,
         u8 > $value AS eu
  FROM t1;

  let $query=
  SELECT i1 > $d_value AS a,
         u1 > $d_value AS au,
         i2 > $d_value AS b,
         u2 > $d_value AS bu,
         i3 > $d_value AS c,
         u3 > $d_value AS cu,
         i4 > $d_value AS d,
         u4 > $d_value AS du,
         i8 > $d_value AS e,
         u8 > $d_value AS eu
  FROM t1;

  let $query=
  SELECT i1 > $f_value AS a,
         u1 > $f_value AS au,
         i2 > $f_value AS b,
         u2 > $f_value AS bu,
         i3 > $f_value AS c,
         u3 > $f_value AS cu,
         i4 > $f_value AS d,
         u4 > $f_value AS du,
         i8 > $f_value AS e,
         u8 > $f_value AS eu
  FROM t1;

  let $query=
  SELECT i1 > $s_value AS a,
         u1 > $s_value AS au,
         i2 > $s_value AS b,
         u2 > $s_value AS bu,
         i3 > $s_value AS c,
         u3 > $s_value AS cu,
         i4 > $s_value AS d,
         u4 > $s_value AS du,
         i8 > $s_value AS e,
         u8 > $S_value AS eu
  FROM t1;

  inc $i;

DROP TABLE t1;
CREATE TABLE t2
(pk INTEGER PRIMARY KEY,
 f4 REAL,
 f8 DOUBLE);

INSERT INTO t2 VALUES
(0, -3.402823e+38, -1.797693134862315708e+308),
(1, -1.175494e-38, -2.225073858507201383e-308),
(2, 0, 0),
(3, 1.175494e-38, 2.225073858507201383e-308),
(4, 3.402823e+38, 1.797693134862315708e+308);

let $prep_query1=
SELECT f4 = ? AS a,
       f8 = ? AS b
FROM t2;

let $prep_query2=
SELECT f4 <> ? AS a,
       f8 <> ? AS b
FROM t2;

let $prep_query3=
SELECT f4 < ? AS a,
       f8 < ? AS b
FROM t2;

let $prep_query4=
SELECT f4 >= ? AS a,
       f8 >= ? AS b
FROM t2;

let $prep_query5=
SELECT f4 <= ? AS a,
       f8 <= ? AS b
FROM t2;

let $prep_query6=
SELECT f4 > ? AS a,
       f8 > ? AS b
FROM t2;

let $i=0;
{
  if ($i == 0)
  {
    let $value= -1.797693134862315708e+308;
  }
  if ($i == 1)
  {
    let $value= -3.40282347e+38;
  }
  if ($i == 2)
  {
    let $value= -1.17549435e-38;
  }
  if ($i == 3)
  {
    let $value= -2.225073858507201383e-308;
  }
  if ($i == 4)
  {
    let $value= 0;
  }
  if ($i == 5)
  {
    let $value= 2.225073858507201383e-308;
  }
  if ($i == 6)
  {
    let $value= 1.17549435e-38;
  }
  if ($i == 7)
  {
    let $value= 3.40282347e+38;
  }
  if ($i == 8)
  {
    let $value= 1.797693134862315708e+308;
  }
  let $s_value='$value';

  let $query=
  SELECT f4 = $value AS a,
         f8 = $value AS b
  FROM t2;

  let $query=
  SELECT f4 = $s_value AS a,
         f8 = $s_value AS b
  FROM t2;

  let $query=
  SELECT f4 <> $value AS a,
         f8 <> $value AS b
  FROM t2;

  let $query=
  SELECT f4 <> $s_value AS a,
         f8 <> $s_value AS b
  FROM t2;

  let $query=
  SELECT f4 < $value AS a,
         f8 < $value AS b
  FROM t2;

  let $query=
  SELECT f4 < $s_value AS a,
         f8 < $s_value AS b
  FROM t2;

  let $query=
  SELECT f4 >= $value AS a,
         f8 >= $value AS b
  FROM t2;

  let $query=
  SELECT f4 >= $s_value AS a,
         f8 >= $s_value AS b
  FROM t2;

  let $query=
  SELECT f4 <= $value AS a,
         f8 <= $value AS b
  FROM t2;

  let $query=
  SELECT f4 <= $s_value AS a,
         f8 <= $s_value AS b
  FROM t2;

  let $query=
  SELECT f4 > $value AS a,
         f8 > $value AS b
  FROM t2;

  let $query=
  SELECT f4 > $s_value AS a,
         f8 > $s_value AS b
  FROM t2;

  inc $i;

DROP TABLE t2;

--
-- Decimal columns, boundary checks
--

CREATE TABLE t3
(pk INTEGER PRIMARY KEY,
 dc1 DECIMAL(12, 4),
 dc2 DECIMAL(30, 30),
 dc3 DECIMAL(65, 0),
 dc4 DECIMAL(65, 30));

INSERT INTO t3 VALUES
(0, -99999999.9999, -.999999999999999999999999999999,
    -99999999999999999999999999999999999999999999999999999999999999999,
    -99999999999999999999999999999999999.999999999999999999999999999999),
(1, 0, 0, 0, 0),
(2, 99999999.9999, .999999999999999999999999999999,
    99999999999999999999999999999999999999999999999999999999999999999,
    99999999999999999999999999999999999.999999999999999999999999999999);

let $prep_query1=
SELECT dc1 = ? AS a,
       dc2 = ? AS b,
       dc3 = ? AS c,
       dc4 = ? AS d
FROM t3;

let $prep_query2=
SELECT dc1 <> ? AS a,
       dc2 <> ? AS b,
       dc3 <> ? AS c,
       dc4 <> ? AS d
FROM t3;

let $prep_query3=
SELECT dc1 < ? AS a,
       dc2 < ? AS b,
       dc3 < ? AS c,
       dc4 < ? AS d
FROM t3;

let $prep_query4=
SELECT dc1 >= ? AS a,
       dc2 >= ? AS b,
       dc3 >= ? AS c,
       dc4 >= ? AS d
FROM t3;

let $prep_query5=
SELECT dc1 <= ? AS a,
       dc2 <= ? AS b,
       dc3 <= ? AS c,
       dc4 <= ? AS d
FROM t3;

let $prep_query6=
SELECT dc1 > ? AS a,
       dc2 > ? AS b,
       dc3 > ? AS c,
       dc4 > ? AS d
FROM t3;

let $i=0;
{
  if ($i == 0)
  {
    let $value=
       -100000000000000000000000000000000000000000000000000000000000000000;
  }
  if ($i == 1)
  {
    let $value=
        -99999999999999999999999999999999999999999999999999999999999999999;
  }
  if ($i == 2)
  {
    let $value=
        -99999999999999999999999999999999999.999999999999999999999999999999;
  }
  if ($i == 3)
  {
    let $value= -99999999.9999;
  }
  if ($i == 4)
  {
    let $value= -.999999999999999999999999999999;
  }
  if ($i == 5)
  {
    let $value= 0;
  }
  if ($i == 6)
  {
    let $value= .999999999999999999999999999999;
  }
  if ($i == 7)
  {
    let $value= 99999999.9999;
  }
  if ($i == 8)
  {
    let $value=
        99999999999999999999999999999999999.999999999999999999999999999999;
  }
  if ($i == 9)
  {
    let $value=
        99999999999999999999999999999999999999999999999999999999999999999;
  }
  if ($i == 10)
  {
    let $value=
        100000000000000000000000000000000000000000000000000000000000000000;
  }

  let $s_value='$value';

  let $query=
  SELECT dc1 = $value AS a,
         dc2 = $value AS b,
         dc3 = $value AS c,
         dc4 = $value AS d
  FROM t3;

  let $query=
  SELECT dc1 = $s_value AS a,
         dc2 = $s_value AS b,
         dc3 = $s_value AS c,
         dc4 = $s_value AS d
  FROM t3;

  let $query=
  SELECT dc1 <> $value AS a,
         dc2 <> $value AS b,
         dc3 <> $value AS c,
         dc4 <> $value AS d
  FROM t3;

  let $query=
  SELECT dc1 <> $s_value AS a,
         dc2 <> $s_value AS b,
         dc3 <> $s_value AS c,
         dc4 <> $s_value AS d
  FROM t3;

  let $query=
  SELECT dc1 < $value AS a,
         dc2 < $value AS b,
         dc3 < $value AS c,
         dc4 < $value AS d
  FROM t3;

  let $query=
  SELECT dc1 < $s_value AS a,
         dc2 < $s_value AS b,
         dc3 < $s_value AS c,
         dc4 < $s_value AS d
  FROM t3;

  let $query=
  SELECT dc1 >= $value AS a,
         dc2 >= $value AS b,
         dc3 >= $value AS c,
         dc4 >= $value AS d
  FROM t3;

  let $query=
  SELECT dc1 >= $s_value AS a,
         dc2 >= $s_value AS b,
         dc3 >= $s_value AS c,
         dc4 >= $s_value AS d
  FROM t3;

  let $query=
  SELECT dc1 <= $value AS a,
         dc2 <= $value AS b,
         dc3 <= $value AS c,
         dc4 <= $value AS d
  FROM t3;

  let $query=
  SELECT dc1 <= $s_value AS a,
         dc2 <= $s_value AS b,
         dc3 <= $s_value AS c,
         dc4 <= $s_value AS d
  FROM t3;

  let $query=
  SELECT dc1 > $value AS a,
         dc2 > $value AS b,
         dc3 > $value AS c,
         dc4 > $value AS d
  FROM t3;

  let $query=
  SELECT dc1 > $s_value AS a,
         dc2 > $s_value AS b,
         dc3 > $s_value AS c,
         dc4 > $s_value AS d
  FROM t3;

  inc $i;

DROP TABLE t3;

--
-- Character columns, boundary checks
--
CREATE TABLE t4
(pk INTEGER PRIMARY KEY,
 fc CHAR(12),
 vc VARCHAR(12));

INSERT INTO t4 VALUES
(0, "", "");

let $prep_query1=
SELECT fc = ? AS a,
       vc = ? AS b
FROM t4;

let $prep_query2=
SELECT fc <> ? AS a,
       vc <> ? AS b
FROM t4;

let $prep_query3=
SELECT fc < ? AS a,
       vc < ? AS b
FROM t4;

let $prep_query4=
SELECT fc >= ? AS a,
       vc >= ? AS b
FROM t4;

let $prep_query5=
SELECT fc <= ? AS a,
       vc <= ? AS b
FROM t4;

let $prep_query6=
SELECT fc > ? AS a,
       vc > ? AS b
FROM t4;

let $i=0;
{
  if ($i == 0)
  {
    let $value= "";
  }
  eval set @sv= "$value";

  let $query=
  SELECT fc = $value AS a,
         vc = $value AS b
  FROM t4;

  let $query=
  SELECT fc <> $value AS a,
         vc <> $value AS b
  FROM t4;

  let $query=
  SELECT fc < $value AS a,
         vc < $value AS b
  FROM t4;

  let $query=
  SELECT fc >= $value AS a,
         vc >= $value AS b
  FROM t4;

  let $query=
  SELECT fc <= $value AS a,
         vc <= $value AS b
  FROM t4;

  let $query=
  SELECT fc > $value AS a,
         vc > $value AS b
  FROM t4;

  inc $i;

DROP TABLE t4;
CREATE TABLE t5
(pk INTEGER PRIMARY KEY,
 d DATE);

INSERT INTO t5 VALUES
(0, '0001-01-01'), (1, '2017-01-01'), (2, '9999-12-31');

let $prep_query1=
SELECT d = ? AS a
FROM t5;

let $prep_query2=
SELECT d <> ? AS a
FROM t5;

let $prep_query3=
SELECT d < ? AS a
FROM t5;

let $prep_query4=
SELECT d >= ? AS a
FROM t5;

let $prep_query5=
SELECT d <= ? AS a
FROM t5;

let $prep_query6=
SELECT d > ? AS a
FROM t5;

let $i=0;
{
  if ($i == 0)
  {
    let $d_value= 0001-01-01;
    let $i_value= 00010101;
  }
  if ($i == 1)
  {
    let $d_value= 2017-01-01;
    let $i_value= 20170101;
  }
  if ($i == 2)
  {
    let $d_value= 9999-12-31;
    let $i_value= 99991231;
  }
  let s_value= '$d_value';
  let time_suffix=000000.0;
  let ts_temp= $d_value 00:00:00.000000;
  let ts_num= $i_value$time_suffix;
  let ts_value= '$ts_temp';

  let $query=
  SELECT d = $s_value AS a
  FROM t5;

  let $query=
  SELECT d = $i_value AS a
  FROM t5;

  let $query=
  SELECT d = $ts_value AS a
  FROM t5;

  let $query=
  SELECT d = $ts_num AS a
  FROM t5;

  let $query=
  SELECT d <> $s_value AS a
  FROM t5;

  let $query=
  SELECT d <> $i_value AS a
  FROM t5;

  let $query=
  SELECT d <> $ts_value AS a
  FROM t5;

  let $query=
  SELECT d <> $ts_num AS a
  FROM t5;

  let $query=
  SELECT d < $s_value AS a
  FROM t5;

  let $query=
  SELECT d < $i_value AS a
  FROM t5;

  let $query=
  SELECT d < $ts_value AS a
  FROM t5;

  let $query=
  SELECT d < $ts_num AS a
  FROM t5;

  let $query=
  SELECT d >= $s_value AS a
  FROM t5;

  let $query=
  SELECT d >= $i_value AS a
  FROM t5;

  let $query=
  SELECT d >= $ts_value AS a
  FROM t5;

  let $query=
  SELECT d >= $ts_num AS a
  FROM t5;

  let $query=
  SELECT d <= $s_value AS a
  FROM t5;

  let $query=
  SELECT d <= $i_value AS a
  FROM t5;

  let $query=
  SELECT d <= $ts_value AS a
  FROM t5;

  let $query=
  SELECT d <= $ts_num AS a
  FROM t5;

  let $query=
  SELECT d > $s_value AS a
  FROM t5;

  let $query=
  SELECT d > $i_value AS a
  FROM t5;

  let $query=
  SELECT d > $ts_value AS a
  FROM t5;

  let $query=
  SELECT d > $ts_num AS a
  FROM t5;

  inc $i;

-- Verify that an invalid date leads to a warning

set @iv=-20010101;
select @iv;
set @sv="abc";

DROP TABLE t5;
CREATE TABLE t6
(pk INTEGER PRIMARY KEY,
 t1 TIME(0),
 t2 TIME(6));

INSERT INTO t6 VALUES
(0, '-838:59:59', '-838:59:59.000000'),
(1, '-23:59:59', '-23:59:59.999999'),
(2, '00:00:00', '00:00:00.000000'),
(3, '23:59:59', '23:59:59.999999'),
(4, '838:59:59', '838:59:59.000000');

let $prep_query1=
SELECT t1 = ? AS a,
       t2 = ? AS b
FROM t6;

let $prep_query2=
SELECT t1 <> ? AS a,
       t2 <> ? AS b
FROM t6;

let $prep_query3=
SELECT t1 < ? AS a,
       t2 < ? AS b
FROM t6;

let $prep_query4=
SELECT t1 >= ? AS a,
       t2 >= ? AS b
FROM t6;

let $prep_query5=
SELECT t1 <= ? AS a,
       t2 <= ? AS b
FROM t6;

let $prep_query6=
SELECT t1 > ? AS a,
       t2 > ? AS b
FROM t6;

let $i=0;
{
  if ($i == 0)
  {
    let $t_value= -838:59:59.000000;
    let $dc_value= -8385959.000000;
  }
  if ($i == 1)
  {
    let $t_value= -23:59:59.999999;
    let $dc_value= -235959.999999;
  }
  if ($i == 2)
  {
    let $t_value= 00:00:00.000000;
    let $dc_value= 000000.000000;
  }
  if ($i == 3)
  {
    let $t_value= 23:59:59.999999;
    let $dc_value= 235959.999999;
  }
  if ($i == 4)
  {
    let $t_value= 838:59:59.000000;
    let $dc_value= 8385959.000000;
  }
  let $s_value= '$t_value';

  let $query=
  SELECT t1 = $s_value AS a,
         t2 = $s_value AS b
  FROM t6;

  let $query=
  SELECT t1 = $dc_value AS a,
         t2 = $dc_value AS b
  FROM t6;

  let $query=
  SELECT t1 <> $s_value AS a,
         t2 <> $s_value AS b
  FROM t6;

  let $query=
  SELECT t1 <> $dc_value AS a,
         t2 <> $dc_value AS b
  FROM t6;

  let $query=
  SELECT t1 < $s_value AS a,
         t2 < $s_value AS b
  FROM t6;

  let $query=
  SELECT t1 < $dc_value AS a,
         t2 < $dc_value AS b
  FROM t6;

  let $query=
  SELECT t1 >= $s_value AS a,
         t2 >= $s_value AS b
  FROM t6;

  let $query=
  SELECT t1 >= $dc_value AS a,
         t2 >= $dc_value AS b
  FROM t6;

  let $query=
  SELECT t1 <= $s_value AS a,
         t2 <= $s_value AS b
  FROM t6;

  let $query=
  SELECT t1 <= $dc_value AS a,
         t2 <= $dc_value AS b
  FROM t6;

  let $query=
  SELECT t1 > $s_value AS a,
         t2 > $s_value AS b
  FROM t6;

  let $query=
  SELECT t1 > $dc_value AS a,
         t2 > $dc_value AS b
  FROM t6;

  inc $i;

DROP TABLE t6;

--
-- Datetime columns, boundary checks
--
CREATE TABLE t7
(pk INTEGER PRIMARY KEY,
 dt1 DATETIME(0),
 dt2 DATETIME(6));

INSERT INTO t7 VALUES
(0, '0001-01-01 00:00:00', '0001-01-01 00:00:00.000000'),
(1, '2017-01-01 11:59.59', '2017-01-01 11:59.59.555555'),
(2, '9999-12-31 23:59.59', '9999-12-31 23:59.59.999999');

let $prep_query1=
SELECT dt1 = ? AS a,
       dt2 = ? AS b
FROM t7;

let $prep_query2=
SELECT dt1 <> ? AS a,
       dt2 <> ? AS b
FROM t7;

let $prep_query3=
SELECT dt1 < ? AS a,
       dt2 < ? AS b
FROM t7;

let $prep_query4=
SELECT dt1 >= ? AS a,
       dt2 >= ? AS b
FROM t7;

let $prep_query5=
SELECT dt1 <= ? AS a,
       dt2 <= ? AS b
FROM t7;

let $prep_query6=
SELECT dt1 > ? AS a,
       dt2 > ? AS b
FROM t7;

let $i=0;
{
  if ($i == 0)
  {
    let $d_value= 0001-01-01;
    let $ts_value= 0001-01-01 00:00:00.000000;
    let $i_value= 00010101;
    let $dc_value= 00010101000000.000000;
  }
  if ($i == 1)
  {
    let $d_value= 2017-01-01;
    let $ts_value= 2017-01-01 11:59:59;
    let $i_value= 20170101;
    let $dc_value= 20170101115959;
  }
  if ($i == 2)
  {
    let $d_value= 2017-01-01;
    let $ts_value= 2017-01-01 11:59:59.555555;
    let $i_value= 20170101;
    let $dc_value= 20170101115959.555555;
  }
  --#todo WL#6570 i==3 and i==4 seem to do the same?
  if ($i == 3)
  {
    let $d_value= 9999-12-31;
    let $ts_value= 9999-12-31 23:59:59.999999;
    let $i_value= 99991231;
    let $dc_value= 99991231235959.999999;
  }
  if ($i == 4)
  {
    let $d_value= 9999-12-31;
    let $ts_value= 9999-12-31 23:59:59.999999;
    let $i_value= 99991231;
    let $dc_value= 99991231235959.999999;
  }
  let ds_value= '$d_value';
  let tss_value= '$ts_value';

  let $query=
  SELECT dt1 = $ds_value AS a,
         dt2 = $ds_value AS b
  FROM t7;

  let $query=
  SELECT dt1 = $i_value AS a,
         dt2 = $i_value AS b
  FROM t7;

  let $query=
  SELECT dt1 = $tss_value AS a,
         dt2 = $tss_value AS b
  FROM t7;

  let $query=
  SELECT dt1 = $dc_value AS a,
         dt2 = $dc_value AS b
  FROM t7;

  let $query=
  SELECT dt1 <> $ds_value AS a,
         dt2 <> $ds_value AS b
  FROM t7;

  let $query=
  SELECT dt1 <> $i_value AS a,
         dt2 <> $i_value AS b
  FROM t7;

  let $query=
  SELECT dt1 <> $tss_value AS a,
         dt2 <> $tss_value AS b
  FROM t7;

  let $query=
  SELECT dt1 <> $dc_value AS a,
         dt2 <> $dc_value AS b
  FROM t7;

  let $query=
  SELECT dt1 < $ds_value AS a,
         dt2 < $ds_value AS b
  FROM t7;

  let $query=
  SELECT dt1 < $i_value AS a,
         dt2 < $i_value AS b
  FROM t7;

  let $query=
  SELECT dt1 < $tss_value AS a,
         dt2 < $tss_value AS b
  FROM t7;

  let $query=
  SELECT dt1 < $dc_value AS a,
         dt2 < $dc_value AS b
  FROM t7;

  let $query=
  SELECT dt1 >= $ds_value AS a,
         dt2 >= $ds_value AS b
  FROM t7;

  let $query=
  SELECT dt1 >= $i_value AS a,
         dt2 >= $i_value AS b
  FROM t7;

  let $query=
  SELECT dt1 >= $tss_value AS a,
         dt2 >= $tss_value AS b
  FROM t7;

  let $query=
  SELECT dt1 >= $dc_value AS a,
         dt2 >= $dc_value AS b
  FROM t7;

  let $query=
  SELECT dt1 <= $ds_value AS a,
         dt2 <= $ds_value AS b
  FROM t7;

  let $query=
  SELECT dt1 <= $i_value AS a,
         dt2 <= $i_value AS b
  FROM t7;

  let $query=
  SELECT dt1 <= $tss_value AS a,
         dt2 <= $tss_value AS b
  FROM t7;

  let $query=
  SELECT dt1 <= $dc_value AS a,
         dt2 <= $dc_value AS b
  FROM t7;

  let $query=
  SELECT dt1 > $ds_value AS a,
         dt2 > $ds_value AS b
  FROM t7;

  let $query=
  SELECT dt1 > $i_value AS a,
         dt2 > $i_value AS b
  FROM t7;

  let $query=
  SELECT dt1 > $tss_value AS a,
         dt2 > $tss_value AS b
  FROM t7;

  let $query=
  SELECT dt1 > $dc_value AS a,
         dt2 > $dc_value AS b
  FROM t7;

  inc $i;

DROP TABLE t7;
