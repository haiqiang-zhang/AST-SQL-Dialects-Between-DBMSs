CREATE TABLE listhash(
       key INTEGER PRIMARY KEY,
       id TEXT,
       node INTEGER
     );
CREATE UNIQUE INDEX ididx ON listhash(id);
EXPLAIN QUERY PLAN 
  SELECT node FROM listhash WHERE id='5000' LIMIT 1;
EXPLAIN QUERY PLAN 
  SELECT node FROM listhash WHERE id="5000" LIMIT 1;
EXPLAIN QUERY PLAN 
  SELECT node FROM listhash WHERE id=5000 LIMIT 1;
