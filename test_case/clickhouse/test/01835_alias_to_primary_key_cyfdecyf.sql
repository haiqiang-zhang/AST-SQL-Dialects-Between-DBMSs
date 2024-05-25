SET force_primary_key = 1;
select * from tb where `index` >= 0 AND `index` <= 2;
select * from tb where idx >= 0 AND idx <= 2;
DROP TABLE tb;
