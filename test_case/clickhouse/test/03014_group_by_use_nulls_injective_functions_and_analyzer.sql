SELECT bitNot(bitNot(number)) + 3 FROM numbers(10) GROUP BY GROUPING SETS (('str', bitNot(bitNot(number))), ('str')) order by all;
SELECT tuple(tuple(tuple(number))) FROM numbers(10) GROUP BY GROUPING SETS (('str', tuple(tuple(number))), ('str')) order by all;
