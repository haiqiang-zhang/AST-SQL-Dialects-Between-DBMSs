SELECT 'masked flush only';
system stop distributed sends dist_01555;
SELECT 'masked';
SELECT 'no masking';
drop table data_01555;
