SELECT length(groupUniqArray(v)) FROM group_uniq_arr_int GROUP BY id ORDER BY id;
SELECT length(groupUniqArray(10)(v)) FROM group_uniq_arr_int GROUP BY id ORDER BY id;
SELECT length(groupUniqArray(100000)(v)) FROM group_uniq_arr_int GROUP BY id ORDER BY id;
DROP TABLE IF EXISTS group_uniq_arr_int;
