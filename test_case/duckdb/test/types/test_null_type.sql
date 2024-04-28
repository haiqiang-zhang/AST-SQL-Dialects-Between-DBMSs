pragma enable_verification;
insert into null_table values (null);
select 42::${type}::"null";
insert into null_table values (42::${type});
create table null_list (i "null"[]);
insert into null_list values (null), ([null]);
insert into null_list values ([42::${type}]);
create table null_struct (i struct(n "null"));
insert into null_struct values (null), ({n:null});
insert into null_struct values ({n: 42::${type}});
create table null_map (i map("null", "null"));
insert into null_map values (null), (map([null], [null]));
insert into null_map values (map([42::${type}], [7::${type}]));
create table null_table (i "null")

query I
select typeof(i) from null_table;;
select i from null_list;
select i::${type}[] from null_list;
select i from null_struct;
select i::struct(n ${type}) from null_struct;
