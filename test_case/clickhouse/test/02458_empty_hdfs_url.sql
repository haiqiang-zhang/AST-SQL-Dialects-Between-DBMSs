SELECT * FROM hdfsCluster('test_shard_localhost', '', 'TSV');
SELECT * FROM hdfsCluster('test_shard_localhost', ' ', 'TSV');
SELECT * FROM hdfsCluster('test_shard_localhost', '/', 'TSV');
SELECT * FROM hdfsCluster('test_shard_localhost', 'http/', 'TSV');