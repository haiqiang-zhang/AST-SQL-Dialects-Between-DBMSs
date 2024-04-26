UPDATE performance_schema.setup_instruments SET enabled = 'NO', timed = 'YES';

UPDATE performance_schema.setup_instruments SET enabled = 'YES'
WHERE name IN ('wait/io/table/sql/handler',
               'wait/lock/table/sql/handler',
               'wait/lock/metadata/sql/mdl');
INSERT INTO performance_schema.setup_objects (object_type, object_schema, object_name, enabled, timed)
  VALUES ('TABLE', 'mtr', '%', 'NO', 'NO');

DO version_tokens_set('vt1=11;
SELECT version_tokens_show();

DO version_tokens_lock_exclusive('vt3', 'vt5', 'vt1', 0);
SELECT OBJECT_NAME, LOCK_TYPE, LOCK_DURATION, LOCK_STATUS
  FROM performance_schema.metadata_locks
  WHERE OBJECT_NAME in ('vt1','vt3','vt5') AND
        LOCK_TYPE='EXCLUSIVE'
  ORDER BY OBJECT_NAME;

DO version_tokens_unlock();
SELECT OBJECT_NAME, LOCK_TYPE, LOCK_DURATION, LOCK_STATUS
  FROM performance_schema.metadata_locks
  WHERE OBJECT_NAME in ('vt1','vt3','vt5') AND
        LOCK_TYPE='EXCLUSIVE'
  ORDER BY OBJECT_NAME;
UPDATE performance_schema.setup_instruments SET enabled = 'YES', timed = 'YES';
DELETE FROM performance_schema.setup_objects WHERE object_schema='mtr';
DROP FUNCTION version_tokens_set;
DROP FUNCTION version_tokens_show;
DROP FUNCTION version_tokens_edit;
DROP FUNCTION version_tokens_delete;
DROP FUNCTION version_tokens_lock_shared;
DROP FUNCTION version_tokens_lock_exclusive;
DROP FUNCTION version_tokens_unlock;
