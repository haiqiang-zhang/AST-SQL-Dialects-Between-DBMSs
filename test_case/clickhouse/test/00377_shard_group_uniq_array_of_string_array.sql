SELECT length(groupUniqArray(v)) FROM group_uniq_arr_str GROUP BY id ORDER BY id;
DROP TABLE IF EXISTS group_uniq_arr_str;
