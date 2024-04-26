SELECT COUNT(*) FROM performance_schema.error_log
  WHERE DATA LIKE '%new%deprecated%';
SELECT COUNT(*) FROM performance_schema.error_log
  WHERE DATA LIKE '%old%deprecated%';
SET @@global.new=1;
SET @@session.new=1;
