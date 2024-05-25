PRAGMA enable_verification;
SELECT concat() OVER ();
SELECT nonexistingfunction() OVER ();
SELECT avg(row_number() over ()) over ();
SELECT avg(42) over (partition by row_number() over ());
SELECT avg(42) over (order by row_number() over ());
SELECT row_number() OVER ();
SELECT avg(42) OVER ();
