SELECT length(groupArray(number)), count() FROM (SELECT number FROM system.numbers_mt LIMIT 1000000);
