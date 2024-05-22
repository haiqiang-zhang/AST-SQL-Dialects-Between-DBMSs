SELECT arrayAUC([1], [1]);
SELECT arrayAUC([1, 1], [1, 1]);
SELECT arrayAUC([1, 1], [0, 0]);
SELECT arrayAUC([1, 1], [0, 1]);
SELECT arrayAUC([0, 1], [0, 1]);
SELECT arrayAUC([1, 0], [0, 1]);
SELECT arrayAUC([0, 0, 1], [0, 1, 1]);
SELECT arrayAUC([0, 1, 1], [0, 1, 1]);
SELECT arrayAUC([0, 1, 1], [0, 0, 1]);
