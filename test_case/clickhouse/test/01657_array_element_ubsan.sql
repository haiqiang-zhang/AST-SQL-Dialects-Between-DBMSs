SELECT [number][10000000000] FROM numbers(1);
SELECT '---';
SELECT [materialize(1)][0xFFFFFFFFFFFFFFFF];
SELECT [materialize(1)][materialize(18446744073709551615)];
SELECT [materialize(1)][-0x8000000000000000];
SELECT '---';
SELECT '---';
