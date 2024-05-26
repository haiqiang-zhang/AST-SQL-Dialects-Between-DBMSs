select * from tbl where str in ('AbCdE');
select * from tbl where str collate nocase in ('abcde');
select * from tbl where str collate noaccent in ('abcde');
select * from tbl where str collate nocase.noaccent in ('abcde');
