ALTER TABLE issue_46128 UPDATE a = b WHERE id= 1 settings mutations_sync=2;
select * from issue_46128 where id  <= 2 order by id;
drop table issue_46128;
