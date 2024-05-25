SELECT length(groupArray(number)), count() FROM (SELECT number FROM system.numbers_mt LIMIT 1000000);
SELECT length(groupArray(toString(number))), count() FROM (SELECT number FROM system.numbers LIMIT 100000);
