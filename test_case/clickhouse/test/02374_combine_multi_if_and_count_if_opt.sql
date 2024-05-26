explain syntax select sum(multiIf(a = 1, 1, 0)) from m;
set optimize_rewrite_sum_if_to_count_if=0;
drop table m;
