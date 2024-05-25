SELECT toNullable(toInt32(2)) user_id WHERE joinGet(test_joinGet, 'name', user_id) != '';
SELECT cast(null AS Nullable(Int32)) user_id WHERE joinGet(test_joinGet, 'name', user_id) != '';
DROP TABLE test_joinGet;
