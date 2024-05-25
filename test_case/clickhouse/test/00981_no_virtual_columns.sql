SELECT name FROM system.columns WHERE database = currentDatabase() AND table = 'merge_ab';
DROP TABLE merge_a;
DROP TABLE merge_b;
DROP TABLE merge_ab;
