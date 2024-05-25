/** What happens if we insert a then c then d then b?
  * Insertion of b forces rehash.
  * a will be removed, but c, d, b remain:
  * [dd         bbbbbbbbbb     cc]
  * Then we go through hash table and move elements to better places in collision resolution chain.
  * c will be moved left to their right place:
  * [dd         bbbbbbbbbb   cc  ]
  *
  * And d must be moved also:
  * [           bbbbbbbbbb   ccdd]
  * But our algorithm was incorrect and it doesn't happen.
  *
  * If we insert d again, it will be placed twice because original d will not found:
  * [dd         bbbbbbbbbb   ccdd]
  * This will lead to slightly higher return value of "uniq" aggregate function and it is dependent on insertion order.
  */


SET max_threads = 1;
/** Results of these two queries must match: */

SELECT uniq(number) FROM (
          SELECT * FROM part_a
UNION ALL SELECT * FROM part_c
UNION ALL SELECT * FROM part_d
UNION ALL SELECT * FROM part_b);
SELECT uniq(number) FROM (
          SELECT * FROM part_a
UNION ALL SELECT * FROM part_c
UNION ALL SELECT * FROM part_d
UNION ALL SELECT * FROM part_b
UNION ALL SELECT * FROM part_d);
DROP TABLE part_a;
DROP TABLE part_b;
DROP TABLE part_c;
DROP TABLE part_d;
