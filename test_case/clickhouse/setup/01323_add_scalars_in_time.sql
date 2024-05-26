SET optimize_on_insert = 0;
DROP TABLE IF EXISTS tags;
CREATE TABLE tags (
    id String,
    seqs Array(UInt8),
    create_time DateTime DEFAULT now()
) engine=ReplacingMergeTree()
ORDER BY (id);
INSERT INTO tags(id, seqs) VALUES ('id1', [1,2,3]), ('id2', [0,2,3]), ('id1', [1,3]);
