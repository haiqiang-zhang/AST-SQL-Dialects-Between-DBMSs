SELECT * FROM tokenbf_v1_hasany_test WHERE hasAny(array, ['this is a test']) SETTINGS force_data_skipping_indices='idx_array_tokenbf_v1';
SELECT '--';
SELECT * FROM tokenbf_v1_hasany_test WHERE hasAny(array, ['example.com']) SETTINGS force_data_skipping_indices='idx_array_tokenbf_v1';
SELECT '--';
SELECT * FROM tokenbf_v1_hasany_test WHERE hasAny(array, ['another test']) SETTINGS force_data_skipping_indices='idx_array_tokenbf_v1';
SELECT '--';
SELECT * FROM tokenbf_v1_hasany_test WHERE hasAny(array, ['another example', 'example.com']) ORDER BY id ASC SETTINGS force_data_skipping_indices='idx_array_tokenbf_v1';
SELECT '--';
SELECT * FROM ngrambf_v1_hasany_test WHERE hasAny(array, ['this is a test']) SETTINGS force_data_skipping_indices='idx_array_ngrambf_v1';
SELECT '--';
SELECT * FROM ngrambf_v1_hasany_test WHERE hasAny(array, ['example.com']) SETTINGS force_data_skipping_indices='idx_array_ngrambf_v1';
SELECT '--';
SELECT * FROM ngrambf_v1_hasany_test WHERE hasAny(array, ['another test']) SETTINGS force_data_skipping_indices='idx_array_ngrambf_v1';
SELECT '--';
SELECT * FROM ngrambf_v1_hasany_test WHERE hasAny(array, ['another example', 'example.com']) ORDER BY id ASC SETTINGS force_data_skipping_indices='idx_array_ngrambf_v1';
DROP TABLE tokenbf_v1_hasany_test;
DROP TABLE ngrambf_v1_hasany_test;