with
orders as (
    select * from main.stg_orders
    where ordered_at >= (select max(ordered_at) from main.orders)
),
some_more_logic as (
    select *
    from orders
)
select * from some_more_logic;
