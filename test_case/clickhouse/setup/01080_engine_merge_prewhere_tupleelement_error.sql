drop table if exists A1;
drop table if exists A_M;
CREATE TABLE A1( a DateTime ) ENGINE = MergeTree ORDER BY tuple();
CREATE TABLE A_M as A1 ENGINE = Merge(currentDatabase(), '^A1$');
insert into A1(a) select now();
set optimize_move_to_prewhere=0;
