select sum(if((number % NULL) = 2, 0, 1)) FROM numbers(1024) settings optimize_rewrite_sum_if_to_count_if=0;
