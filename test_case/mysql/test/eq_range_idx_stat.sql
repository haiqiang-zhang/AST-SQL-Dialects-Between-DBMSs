
-- Tests for eq_range_index_dive_limit variable: 
--   test that index dives are not done when index 
--   statistics is requested

--source include/have_debug.inc

SET eq_range_index_dive_limit=default;
SELECT @@eq_range_index_dive_limit;

CREATE TABLE t1
(
  /* Field names reflect value(rowid) distribution, st=STairs, swt= SaWTooth */
  st_a int,
  swt1a int,
  swt2a int,

  st_b int,
  swt1b int,
  swt2b int,

  key sta_swt12a(st_a,swt1a,swt2a),
  key sta_swt1a(st_a,swt1a),
  key sta_swt2a(st_a,swt2a),
  key sta_swt21a(st_a,swt2a,swt1a),

  key st_a(st_a),
  key stb_swt1a_2b(st_b,swt1b,swt2a),
  key stb_swt1b(st_b,swt1b),
  key st_b(st_b)
) ;

ALTER TABLE t1 DISABLE KEYS;
let $1=3;
{
  let $2=3;
  {
    let $3=3;
    while ($3)
    {
      let $equal_records=30;
      while ($equal_records)
      {
        eval insert into t1 select $1, $2, $3, $1 ,$2, $3;
        dec $equal_records;
      }
      dec $3;
    }
    dec $2;
  }
 dec $1;
ALTER TABLE t1 ENABLE KEYS;
let $iterations=2;
{
  dec $iterations;
  select * from t1 
  where st_a=1 and swt1a=1 and swt2a=1 and st_b=1 and swt1b=1 and swt2b=1 limit 5;

  select * from t1 
  where st_a=1 and swt1a=1 and swt2a=1 and st_b=1 and swt1b=1 and swt2b=1 limit 5;
  select * from t1
  where st_a=1 and swt1a=1 and swt2a=1 and st_b=1 and swt1b=1 limit 5;

  select * from t1
  where st_a=1 and swt1a=1 and swt2a=1 and st_b=1 and swt1b=1 limit 5;
  select * from t1
  where st_a=1 and swt1a=1 and st_b=1 and swt1b=1 and swt1b=1 limit 5;

  select st_a, swt1a, st_b, swt1b from t1
  where st_a=1 and swt1a=1 and st_b=1 and swt1b=1 and swt1b=1 limit 5;
  SET eq_range_index_dive_limit=1;
  SET SESSION DEBUG="+d,crash_records_in_range";

DROP TABLE t1;
