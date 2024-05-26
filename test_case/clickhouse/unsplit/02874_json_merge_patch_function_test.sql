select jsonMergePatch(null);
drop table if exists t_json_merge;
create table t_json_merge (id UInt64, s1 String, s2 String) engine = Memory;
drop table t_json_merge;
