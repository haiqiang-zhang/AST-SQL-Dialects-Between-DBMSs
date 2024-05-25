CREATE TABLE table1 (column1 String) ENGINE=MergeTree() ORDER BY tuple();
CREATE TABLE table2 (column1 String, column2 String, column3 String) ENGINE=MergeTree() ORDER BY tuple();
CREATE TABLE table3 (column3 String) ENGINE=MergeTree() ORDER BY tuple();
