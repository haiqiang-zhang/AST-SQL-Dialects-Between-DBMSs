set allow_experimental_analyzer = true;
set optimize_rewrite_array_exists_to_has = false;
EXPLAIN QUERY TREE run_passes = 1  select arrayExists(x -> x = 5 , materialize(range(10))) from numbers(10);
set optimize_rewrite_array_exists_to_has = true;
set allow_experimental_analyzer = false;
set optimize_rewrite_array_exists_to_has = false;
set optimize_rewrite_array_exists_to_has = true;
