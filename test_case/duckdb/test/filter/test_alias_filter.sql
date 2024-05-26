SELECT i % 2 AS k FROM integers WHERE k<>0;
SELECT i % 2 AS i FROM integers WHERE i<>0;
SELECT i % 2 AS k FROM integers WHERE integers.i<>0;
SELECT i % 2 AS k FROM integers WHERE k=k;
