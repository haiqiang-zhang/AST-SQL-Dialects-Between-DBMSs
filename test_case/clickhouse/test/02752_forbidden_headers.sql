-- Tag no-fasttest: Depends on AWS

SELECT * FROM url('http://localhost:8123/', LineAsString, headers('exact_header' = 'value'));
SELECT * FROM url('http://localhost:8123/', LineAsString, headers('cAsE_INSENSITIVE_header' = 'value'));
SELECT * FROM url('http://localhost:8123/', LineAsString, headers('bad_header_name: test\nexact_header' = 'value'));
SELECT * FROM url('http://localhost:8123/', LineAsString, headers('bad_header_value' = 'test\nexact_header: value'));
SELECT * FROM urlCluster('test_cluster_two_shards_localhost', 'http://localhost:8123/', LineAsString, headers('exact_header' = 'value'));
SELECT * FROM urlCluster('test_cluster_two_shards_localhost', 'http://localhost:8123/', LineAsString, headers('cAsE_INSENSITIVE_header' = 'value'));
SELECT * FROM urlCluster('test_cluster_two_shards_localhost', 'http://localhost:8123/', LineAsString, headers('bad_header_name: test\nexact_header' = 'value'));
SELECT * FROM urlCluster('test_cluster_two_shards_localhost', 'http://localhost:8123/', LineAsString, headers('bad_header_value' = 'test\nexact_header: value'));