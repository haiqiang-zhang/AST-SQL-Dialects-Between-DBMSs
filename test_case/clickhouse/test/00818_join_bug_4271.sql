select * from t_00818 left join s_00818 on t_00818.a = s_00818.a ORDER BY t_00818.a;
select * from t_00818 left join s_00818 on t_00818.a = s_00818.a and t_00818.a = s_00818.b ORDER BY t_00818.a;
select * from t_00818 left join s_00818 on t_00818.a = s_00818.a where s_00818.a = 1 ORDER BY t_00818.a;
select * from t_00818 left join s_00818 on t_00818.a = s_00818.a and t_00818.a = s_00818.a ORDER BY t_00818.a;
select * from t_00818 left join s_00818 on t_00818.a = s_00818.a and t_00818.b = s_00818.a ORDER BY t_00818.a;
drop table t_00818;
drop table s_00818;
