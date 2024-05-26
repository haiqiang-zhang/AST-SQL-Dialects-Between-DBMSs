select j, s, string_agg(s) over (partition by j order by s) from a order by j, s;
select j, s, string_agg(s, '|') over (partition by j order by s) from a order by j, s;
