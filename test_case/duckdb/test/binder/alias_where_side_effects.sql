PRAGMA enable_verification;
select count(*) from (select random() as num from range(20) where num > 0.9) where num <= 0.9;
