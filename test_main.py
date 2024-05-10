import sqlite3
import os
from adapter.sqlite import SQLITE3
from adapter.mysql_adapter import MYSQL
from adapter.PostgresqlAdapter import PostgresqlAdapter
from adapter.DBMSAdapter import DBMSAdapter
import pandas as pd
from utils import clean_query, clean_test_garbage, first_init_dbmss


test_case_path = './test_case'
dbms_test_case_used = ['postgresql']

DBMS_ADAPTERS:dict[str, type[DBMSAdapter]] = {
    # "sqlite": SQLITE3,
    # "mysql": MYSQL,
    "postgresql": PostgresqlAdapter
}

setup_query_keyword = [
    "create table",
    "insert into",
    "drop table"
]


encodings = ['utf-8', 'Windows-1252', 'koi8-r', 'iso8859-1']


def run_setup_in_all_dbms(setup_paths:str):
    # check setup_paths exists
    if os.path.exists(setup_paths):
        with open(setup_paths, 'r') as file:
            setup_query = file.read()
        setup_query = clean_query(setup_query)

        # Execute the SQL query
        for dbms in DBMS_ADAPTERS:
            DBMS_ADAPTERS[dbms].run_setup(setup_query, setup_paths)


def run_test_in_all_dbms(test_paths:str, filename:str):
    # Read the contents of the test case file
    sql_query = None
    for encoding in encodings:
        try:
            with open(test_paths, 'r', encoding=encoding) as file:
                sql_query = file.read()
        except UnicodeDecodeError as e:
            continue
    
    if not sql_query:
        raise UnicodeError(f"Error decode sql file '{filename}'")

    # clean the query
    sql_query = clean_query(sql_query)
    # Execute the SQL query
    df = pd.DataFrame(columns=['DBMS', 'SAME_Number', 'DIFFERENT_Number', 'ERROR_Number'])

    

    for dbms in DBMS_ADAPTERS:
        db_adaptor = DBMS_ADAPTERS[dbms]()
        success_counter = 0
        failure_counter = 0
        for query in sql_query:
            result = db_adaptor.query(query, filename)
            if any(keyword.lower() in query.lower() for keyword in setup_query_keyword):
                if result[0]:
                    success_counter += 1
                else:
                    failure_counter += 1
        df = df._append({'DBMS': dbms, 'SAME_Number': success_counter, 'DIFFERENT_Number': 0, 'ERROR_Number': failure_counter}, ignore_index=True)
        db_adaptor.close_connection()

    
    return success_counter, failure_counter, df


def run_all(test_paths:str, filename:str, setup_paths:str=""):
    if setup_paths:
        run_setup_in_all_dbms(setup_paths)
    return run_test_in_all_dbms(test_paths, filename)







first_init_dbmss(DBMS_ADAPTERS)


# Define a pd.DataFrame to store the test results
df = pd.DataFrame(columns=['DBMS_Base', 'DBMS_Tested', 'SAME_Number', 'DIFFERENT_Number', 'ERROR_Number', 'Total_Number_of_SQL_files'])

# Iterate over the test case files in the folder (it is a multi-level folder)
for dbms in os.listdir(test_case_path):
    # for test_group in os.listdir(os.path.join(test_case_path, dbmss)):
    if dbms not in dbms_test_case_used:
        continue
    print(f"Running test cases of {dbms}")
    success_all = 0
    failure_all = 0
    skip_file_list = []
    test_folder=os.path.join(test_case_path, dbms, 'test')
    file_counter = 0

    # iterate all files in the test folder(it is a multi-level folder, the level is not fixed)
    for dirpath, dirnames, filenames in os.walk(test_folder):
        for i in range(100):
            filename = filenames[i]
            if filename.endswith('.sql'):
                test_paths = os.path.join(dirpath, filename)
                # setup_paths = os.path.join(test_case_path, dbmss, test_group, 'setup', filename)
                # result_paths = os.path.join(test_case_path, dbmss, test_group, 'result', filename)
                
                if os.path.getsize(test_paths) == 0:
                    continue
                
                try:
                    success_counter, failure_counter, df_one_file = run_all(test_paths, filename)
                    for i in range(len(df_one_file)):
                        # check DBMS_Base = dbms, DBMS_Tested = df_one_file[i]['DBMS'] exist or not
                        if df[(df['DBMS_Base'] == dbms) & (df['DBMS_Tested'] == df_one_file.iloc[i]['DBMS'])].empty:
                            df = df._append({'DBMS_Base': dbms, 'DBMS_Tested': df_one_file.iloc[i]['DBMS'], 'SAME_Number': df_one_file.iloc[i]['SAME_Number'], 'DIFFERENT_Number': df_one_file.iloc[i]['DIFFERENT_Number'], 'ERROR_Number': df_one_file.iloc[i]['ERROR_Number'], 'Total_Number_of_SQL_files': 1}, ignore_index=True)
                        else:
                            df.loc[(df['DBMS_Base'] == dbms) & (df['DBMS_Tested'] == df_one_file.iloc[i]['DBMS']), 'SAME_Number'] += df_one_file.iloc[i]['SAME_Number']
                            df.loc[(df['DBMS_Base'] == dbms) & (df['DBMS_Tested'] == df_one_file.iloc[i]['DBMS']), 'DIFFERENT_Number'] += df_one_file.iloc[i]['DIFFERENT_Number']
                            df.loc[(df['DBMS_Base'] == dbms) & (df['DBMS_Tested'] == df_one_file.iloc[i]['DBMS']), 'ERROR_Number'] += df_one_file.iloc[i]['ERROR_Number']
                            df.loc[(df['DBMS_Base'] == dbms) & (df['DBMS_Tested'] == df_one_file.iloc[i]['DBMS']), 'Total_Number_of_SQL_files'] += 1
                    file_counter += 1
                except ValueError as e:
                    print(f"Error decode sql file '{filename}': {e}")
                    skip_file_list.append(filename)
                    continue

                success_all += success_counter
                failure_all += failure_counter
    print(f"Success: {success_all}")
    print(f"Failure: {failure_all}")
    print(f"Total sql query: {success_all + failure_all}")
    print(f"Total .sql file: {file_counter}")
    print(f"Skip: {skip_file_list}")

print()
print(df)

    
            



clean_test_garbage()