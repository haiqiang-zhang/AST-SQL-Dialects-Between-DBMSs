PRAGMA enable_verification;
prepare v1 as select $1[1];;
select case when true then {'a': 42} end.a;;
select [42][1];;
select array[42][1];;
select [a for a in [42, 84]][1];;
execute v1([42]);;
