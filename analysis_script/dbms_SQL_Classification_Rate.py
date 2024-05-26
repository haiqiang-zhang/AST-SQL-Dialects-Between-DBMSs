import pandas as pd

# Creating the DataFrame from the provided CSV data
data = {
    "DBMS_Base": ["clickhouse", "clickhouse", "clickhouse", "clickhouse", "clickhouse", "clickhouse", "clickhouse", "clickhouse", "clickhouse", "clickhouse", "clickhouse"],
    "DBMS_Tested": ["mysql", "sqlite", "postgresql", "duckdb", "clickhouse", "mysql", "sqlite", "postgresql", "duckdb", "clickhouse", "mysql"],
    "SQL_Query": ["SELECT 1", "SELECT 1", "SELECT 1", "SELECT 1", "SELECT 1", "system flush logs", "system flush logs", "system flush logs", "system flush logs", "system flush logs", "SELECT * FROM system.numbers LIMIT 3"],
    "SQL_Type": [["other"], ["other"], ["other"], ["other"], ["other"], ["system_command"], ["system_command"], ["system_command"], ["system_command"], ["system_command"], ["limit", "system_command"]],
    "SQL_File_Name": ["00001_select_1.sql", "00001_select_1.sql", "00001_select_1.sql", "00001_select_1.sql", "00001_select_1.sql", "00002_log_and_exception_messages_formatting.sql", "00002_log_and_exception_messages_formatting.sql", "00002_log_and_exception_messages_formatting.sql", "00002_log_and_exception_messages_formatting.sql", "00002_log_and_exception_messages_formatting.sql", "00002_system_numbers.sql"],
    "Result": ["SAME", "SAME", "SAME", "SAME", "SAME", "ERROR", "ERROR", "ERROR", "ERROR", "SAME", "ERROR"],
    "ERROR_Type": ["", "", "", "", "", "ProgrammingError", "OperationalError", "SyntaxError", "ParserException", "", "ProgrammingError"],
    "Message": ["[(1,)]", "[(1,)]", "[(1,)]", "[(1,)]", "[(1,)]", "1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'system flush logs' at line 1", "near 'system': syntax error", "syntax error at or near 'system' LINE 1: system flush logs", "Parser Error: syntax error at or near 'system'", "[]", "1142 (42000): SELECT command denied to user 'tester'@'localhost' for table 'numbers'"]
}



df = pd.read_csv('init_result_reserve.csv')

# Delete the rows if DBMS_Base == DBMS_Tested
df = df[df['DBMS_Base'] != df['DBMS_Tested']]

# Expand the SQL_Type list into separate rows
# SQL_Type is now a string, but you should be able to convert it back to a list if needed
df['SQL_Type'] = df['SQL_Type'].apply(eval)
df_expanded = df.explode("SQL_Type")




# Group by DBMS_Tested and SQL_Type and calculate the SAME, DIFFERENT, ERROR rate
grouped = df_expanded.groupby(["DBMS_Tested", "SQL_Type", "Result"]).size().unstack(fill_value=0)

# Calculate rates
grouped['Total'] = grouped.sum(axis=1)
grouped['SAME_Rate'] = grouped['SAME'] / grouped['Total']
grouped['ERROR_Rate'] = grouped['ERROR'] / grouped['Total']
grouped['DIFFERENT_Rate'] = grouped['DIFFERENT'] / grouped['Total'] if 'DIFFERENT' in grouped.columns else 0


grouped = grouped[['SAME_Rate', 'DIFFERENT_Rate', 'ERROR_Rate']]


# sort by DBMS_Tested, SAME_Rate
grouped = grouped.sort_values(by=['DBMS_Tested', 'SAME_Rate'], ascending=[True, False])

# to_csv
grouped.to_csv('classification_rate.csv')
