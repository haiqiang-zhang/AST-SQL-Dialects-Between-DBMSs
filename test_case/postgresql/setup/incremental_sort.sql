set work_mem to '2MB';
reset work_mem;
create table t(a integer, b integer);
end;
end;
end;
insert into t(a, b) select i/100 + 1, i + 1 from generate_series(0, 999) n(i);
