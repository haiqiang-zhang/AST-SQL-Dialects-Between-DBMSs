-- Tag no-fasttest: Depends on AWS

SELECT * FROM url('http://localhost:8123/', LineAsString, headers('exact_header' = 'value'));
SELECT * FROM url('http://localhost:8123/', LineAsString, headers('cAsE_INSENSITIVE_header' = 'value'));
