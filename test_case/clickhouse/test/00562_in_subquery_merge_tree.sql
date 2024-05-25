SET force_primary_key = 1;
SELECT * FROM merge_tree_in_subqueries WHERE id IN (SELECT * FROM system.numbers LIMIT 0);
SELECT * FROM merge_tree_in_subqueries WHERE id IN (SELECT * FROM system.numbers LIMIT 2, 3) ORDER BY id;
SELECT * FROM merge_tree_in_subqueries WHERE name IN (SELECT 'test' || toString(number) FROM system.numbers LIMIT 2, 3) ORDER BY id;
SELECT id AS id2, name AS value FROM merge_tree_in_subqueries WHERE (value, id2) IN (SELECT 'test' || toString(number), number FROM system.numbers LIMIT 2, 3) ORDER BY id;
SET force_primary_key = 0;
SELECT id AS id2, name AS value FROM merge_tree_in_subqueries WHERE num IN (SELECT number FROM system.numbers LIMIT 10) ORDER BY id;
SELECT id AS id2, name AS value FROM merge_tree_in_subqueries WHERE (id, num) IN (SELECT number, number + 6 FROM system.numbers LIMIT 10) ORDER BY id;
DROP TABLE IF EXISTS merge_tree_in_subqueries;
