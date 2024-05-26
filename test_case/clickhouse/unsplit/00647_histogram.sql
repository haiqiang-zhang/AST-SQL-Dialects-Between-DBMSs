select histogram(5)(number-10) from (select * from system.numbers limit 20);
WITH arrayJoin(histogram(3)(sin(number))) AS res select round(res.1, 2), round(res.2, 2), round(res.3, 2) from (select * from system.numbers limit 10);
select histogramIf(3)(number, number > 11) from (select * from system.numbers limit 10);
