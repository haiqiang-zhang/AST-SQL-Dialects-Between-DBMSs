PRAGMA enable_verification;
BEGIN TRANSACTION;
create table wintest( item integer, return_ratio numeric, currency_ratio numeric);
insert into wintest values  (7539  ,0.590000 , 0.590000), (3337  ,0.626506 , 0.626506), (15597 ,0.661972 , 0.661972), (2915  ,0.698630 , 0.698630), (11933 ,0.717172 , 0.717172), (483   ,0.800000 , 0.800000), (85    ,0.857143 , 0.857143), (97    ,0.903614 , 0.903614), (117   ,0.925000 , 0.925000), (5299  ,0.927083 , 0.927083), (10055 ,0.945652 , 0.945652), (4231  ,0.977778 , 0.977778), (5647  ,0.987805 , 0.987805), (8679  ,0.988764 , 0.988764), (10323 ,0.977778 , 1.111111), (3305  ,0.737500 , 1.293860);
ROLLBACK;
SELECT item, rank() OVER (ORDER BY return_ratio) AS return_rank, rank() OVER (ORDER BY currency_ratio) AS currency_rank FROM wintest order by item;
