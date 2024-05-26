set plan_cache_mode = force_generic_plan;
create table lp (a char) partition by list (a);
create table lp_default partition of lp default;
create table lp_ef partition of lp for values in ('e', 'f');
create table lp_ad partition of lp for values in ('a', 'd');
create table lp_bc partition of lp for values in ('b', 'c');
create table lp_g partition of lp for values in ('g');
create table lp_null partition of lp for values in (null);
