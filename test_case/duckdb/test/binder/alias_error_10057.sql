PRAGMA enable_verification;
with test_data as (
  select 'foo' as a
)
select test_data.foobar as new_column from test_data where new_column is not null;;