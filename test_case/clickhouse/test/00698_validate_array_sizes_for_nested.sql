SELECT * FROM mergetree_00698;
INSERT INTO mergetree_00698 VALUES (3, [4, 5, 6], [1, 2, 3]), (1, [111], [222]), (2, [], []);
SELECT * FROM mergetree_00698;
DROP TABLE mergetree_00698;
