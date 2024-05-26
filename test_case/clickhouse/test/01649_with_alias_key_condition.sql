with i as k select * from alias_key_condition where k = (select i from alias_key_condition where i = 3);
drop table if exists alias_key_condition;
