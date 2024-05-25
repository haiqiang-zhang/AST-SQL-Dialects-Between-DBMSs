alter table cc detach part 'all_1_1_0';
alter table cc attach part 'all_1_1_0';
select * from cc;
