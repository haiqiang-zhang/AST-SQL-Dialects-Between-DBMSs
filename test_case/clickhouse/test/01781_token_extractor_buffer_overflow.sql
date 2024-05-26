SELECT max(id) FROM bloom_filter WHERE hasToken(s, 'abc');
DROP TABLE bloom_filter;
