prepare v1 as select $2::int;
prepare v2 as select $1::int;
prepare v3 as select $1::int where 1=0;
execute v3(1);
