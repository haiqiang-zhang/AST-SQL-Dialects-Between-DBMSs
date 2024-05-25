SELECT name, type, serialization_kind FROM system.parts_columns
WHERE database = currentDatabase() AND table = 't_modify_to_nullable' AND column = 's' AND active
ORDER BY name;
SELECT count(s), countIf(s != ''), arraySort(groupUniqArray(s)) FROM t_modify_to_nullable;
SET mutations_sync = 2;
ALTER TABLE t_modify_to_nullable MODIFY COLUMN s Nullable(String);
SELECT name, type, serialization_kind FROM system.parts_columns
WHERE database = currentDatabase() AND table = 't_modify_to_nullable' AND column = 's' AND active
ORDER BY name;
SELECT count(s), countIf(s != ''), arraySort(groupUniqArray(s)) FROM t_modify_to_nullable;
SYSTEM FLUSH LOGS;
DROP TABLE t_modify_to_nullable;
