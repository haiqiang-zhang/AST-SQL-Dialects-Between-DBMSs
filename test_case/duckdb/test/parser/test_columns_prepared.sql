prepare v1 as
select
	COLUMNS(?)
from my_table;
EXECUTE v1('col.*1');
EXECUTE v1('col.*2');
EXECUTE v1('col.*3');
EXECUTE v1(['column1', 'column2']);
