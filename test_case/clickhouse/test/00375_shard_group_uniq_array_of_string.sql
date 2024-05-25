SELECT length(groupUniqArray(v)) FROM group_uniq_str GROUP BY id ORDER BY id;
SELECT length(groupUniqArray(10)(v)) FROM group_uniq_str GROUP BY id ORDER BY id;
SELECT length(groupUniqArray(10000)(v)) FROM group_uniq_str GROUP BY id ORDER BY id;
DROP TABLE IF EXISTS group_uniq_str;
