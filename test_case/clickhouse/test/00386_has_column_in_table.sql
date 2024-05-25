/* existing column */
SELECT hasColumnInTable(currentDatabase(), 'has_column_in_table', 'i');
SELECT hasColumnInTable('localhost', currentDatabase(), 'has_column_in_table', 'i');
SELECT hasColumnInTable(currentDatabase(), 'has_column_in_table', 's');
SELECT hasColumnInTable('localhost', currentDatabase(), 'has_column_in_table', 's');
SELECT hasColumnInTable(currentDatabase(), 'has_column_in_table', 'nest.x');
SELECT hasColumnInTable('localhost', currentDatabase(), 'has_column_in_table', 'nest.x');
SELECT hasColumnInTable(currentDatabase(), 'has_column_in_table', 'nest.y');
SELECT hasColumnInTable('localhost', currentDatabase(), 'has_column_in_table', 'nest.y');
/* not existing column */
SELECT hasColumnInTable(currentDatabase(), 'has_column_in_table', 'nest');
SELECT hasColumnInTable('localhost', currentDatabase(), 'has_column_in_table', 'nest');
SELECT hasColumnInTable(currentDatabase(), 'has_column_in_table', 'nest.not_existing');
SELECT hasColumnInTable('localhost', currentDatabase(), 'has_column_in_table', 'nest.not_existing');
SELECT hasColumnInTable(currentDatabase(), 'has_column_in_table', 'not_existing');
SELECT hasColumnInTable('localhost', currentDatabase(), 'has_column_in_table', 'not_existing');
SELECT hasColumnInTable('system', 'one', '');
DROP TABLE has_column_in_table;
