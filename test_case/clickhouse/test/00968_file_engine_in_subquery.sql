SELECT id FROM tableMergeTree_00968 WHERE id IN (SELECT number FROM tableFile_00968) ORDER BY id;
DROP TABLE tableFile_00968;
DROP TABLE tableMergeTree_00968;
