pragma enable_verification;
create table null_list (i "null"[]);
insert into null_list values (null), ([null]);
create table null_struct (i struct(n "null"));
insert into null_struct values (null), ({n:null});
create table null_map (i map("null", "null"));
select i from null_list;
select i from null_struct;
