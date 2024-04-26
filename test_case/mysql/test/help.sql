
--      category:                     topic:               keyword:
--
-- impossible_category_1
--                            impossible_function_1
--                                                   impossible_function_5 
--                            impossible_function_2
--                                                   impossible_function_1
-- impossible_category_2
--                            impossible_function_3
--                                                   impossible_function_6                                            
--                            impossible_function_4
--                                                   impossible_function_6
--      impossible_category_3
--                            impossible_function_7 
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
insert into mysql.help_category(help_category_id,name)values(10001,'impossible_category_1');
select @category1_id:= 10001;
insert into mysql.help_category(help_category_id,name)values(10002,'impossible_category_2');
select @category2_id:= 10002;
insert into mysql.help_category(help_category_id,name,parent_category_id)values(10003,'impossible_category_3',@category2_id);
select @category3_id:= 10003;

insert into mysql.help_topic(help_topic_id,name,help_category_id,description,example)values(10101,'impossible_function_1',@category1_id,'description of \n impossible_function1\n','example of \n impossible_function1');
select @topic1_id:= 10101;
insert into mysql.help_topic(help_topic_id,name,help_category_id,description,example)values(10102,'impossible_function_2',@category1_id,'description of \n impossible_function2\n','example of \n impossible_function2');
select @topic2_id:= 10102;
insert into mysql.help_topic(help_topic_id,name,help_category_id,description,example)values(10103,'impossible_function_3',@category2_id,'description of \n impossible_function3\n','example of \n impossible_function3');
select @topic3_id:= 10103;
insert into mysql.help_topic(help_topic_id,name,help_category_id,description,example)values(10104,'impossible_function_4',@category2_id,'description of \n impossible_function4\n','example of \n impossible_function4');
select @topic4_id:= 10104;
insert into mysql.help_topic(help_topic_id,name,help_category_id,description,example)values(10105,'impossible_function_7',@category3_id,'description of \n impossible_function5\n','example of \n impossible_function7');
select @topic5_id:= 10105;

insert into mysql.help_keyword(help_keyword_id,name)values(10201,'impossible_function_1');
select @keyword1_id:= 10201;
insert into mysql.help_keyword(help_keyword_id,name)values(10202,'impossible_function_5');
select @keyword2_id:= 10202;
insert into mysql.help_keyword(help_keyword_id,name)values(10203,'impossible_function_6');
select @keyword3_id:= 10203;

insert into mysql.help_relation(help_keyword_id,help_topic_id)values(@keyword1_id,@topic2_id);
insert into mysql.help_relation(help_keyword_id,help_topic_id)values(@keyword2_id,@topic1_id);
insert into mysql.help_relation(help_keyword_id,help_topic_id)values(@keyword3_id,@topic3_id);
insert into mysql.help_relation(help_keyword_id,help_topic_id)values(@keyword3_id,@topic4_id);

delete from mysql.help_topic where help_topic_id=@topic1_id;
delete from mysql.help_topic where help_topic_id=@topic2_id;
delete from mysql.help_topic where help_topic_id=@topic3_id;
delete from mysql.help_topic where help_topic_id=@topic4_id;
delete from mysql.help_topic where help_topic_id=@topic5_id;

delete from mysql.help_category where help_category_id=@category3_id;
delete from mysql.help_category where help_category_id=@category2_id;
delete from mysql.help_category where help_category_id=@category1_id;

delete from mysql.help_keyword where help_keyword_id=@keyword1_id;
delete from mysql.help_keyword where help_keyword_id=@keyword2_id;
delete from mysql.help_keyword where help_keyword_id=@keyword3_id;

delete from mysql.help_relation where help_keyword_id=@keyword1_id and help_topic_id=@topic2_id;
delete from mysql.help_relation where help_keyword_id=@keyword2_id and help_topic_id=@topic1_id;
delete from mysql.help_relation where help_keyword_id=@keyword3_id and help_topic_id=@topic3_id;
delete from mysql.help_relation where help_keyword_id=@keyword3_id and help_topic_id=@topic4_id;

--
-- Test that we can use HELP even under LOCK TABLES.  See bug#9953:
-- CONVERT_TZ requires mysql.time_zone_name to be locked.
--
--disable_warnings
DROP TABLE IF EXISTS t1;

CREATE TABLE t1 (i INT);

DROP TABLE t1;

SET sql_mode = default;
