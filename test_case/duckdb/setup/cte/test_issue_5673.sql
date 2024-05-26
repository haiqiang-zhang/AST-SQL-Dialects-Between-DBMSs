PRAGMA enable_verification;
create or replace table orders(ordered_at int);
create or replace table stg_orders(ordered_at int);
insert into orders values (1);
insert into stg_orders values (1);
