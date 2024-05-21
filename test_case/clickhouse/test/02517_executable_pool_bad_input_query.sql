CREATE TABLE test_table (value String) ENGINE=ExecutablePool('nonexist.py', 'TabSeparated', (foobar));
CREATE TABLE test_table (value String) ENGINE=ExecutablePool('nonexist.py', 'TabSeparated', '(SELECT 1)');
CREATE TABLE test_table (value String) ENGINE=ExecutablePool('nonexist.py', 'TabSeparated', [1,2,3]);