copy (select 42 as x) to '__TEST_DIR__/foo';
copy (select 42 as x) to '__TEST_DIR__/foo';
COPY (SELECT 36) TO '__TEST_DIR__/.a.b';
COPY (SELECT 37 as x) TO '__TEST_DIR__/.a.b';
COPY (SELECT 50) TO '__TEST_DIR__/.a.b.c.d.e..';
COPY (SELECT 51) TO '__TEST_DIR__/.a.b.c.d.e..';
FROM read_csv('__TEST_DIR__/.a.b');
