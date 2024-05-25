optimize table tab_lc;
select count() from tab_lc where y == '0' settings local_filesystem_read_prefetch=1;
drop table if exists tab_lc;
