import os
from time import sleep
from typing import List
from adapter.DBMSAdapter import DBMSAdapter
from adapter.SQLiteAdapter import SQLiteAdapter
from adapter.MySQLAdapter import MySQLAdapter
from adapter.PostgresqlAdapter import PostgresqlAdapter
from adapter.DuckDBAdapter import DuckDBAdapter
from adapter.ClickHouseAdapter import ClickHouseAdapter

import pandas as pd
from utils import clean_query, clean_test_garbage, SQLFileEmptyError, first_init_dbmss, clean_query_postgresql

DBMS_ADAPTERS = {
    # "sqlite": SQLiteAdapter,
    # "mysql": MySQLAdapter,
    # "postgresql": PostgresqlAdapter,
    # "duckdb": DuckDBAdapter,
    "clickhouse": ClickHouseAdapter
}

test_case_path = './test_case'
dbms_test_case_used = ['clickhouse']
encodings = ['utf-8', 'Windows-1252', 'koi8-r', 'iso8859-1']






def delete_sql_file(file_path:str):
    # delete the specified file
    os.remove(file_path)

def overwrite_sql_file(file_path:str, sql_queries:List[str]):
    # write the sql_queries to the file
    with open(file_path, 'w') as file:
        for query in sql_queries:
            query += ';\n'
            file.write(query)

def run_test_in_all_dbms(test_paths:str, filename:str, dbms:str)->pd.DataFrame:
    # Read the contents of the test case file
    sql_queries = None
    for encoding in encodings:
        try:
            with open(test_paths, 'r', encoding=encoding) as file:
                sql_queries = file.read()
        except UnicodeDecodeError as e:
            continue
    
    if not sql_queries:
        raise UnicodeError(f"Error decode sql file '{filename}'")
    
    # clean the query
    if dbms == 'postgresql':
        sql_queries = clean_query_postgresql(sql_queries)
    else:
        sql_queries = clean_query(sql_queries)


    db_adaptor = DBMS_ADAPTERS[dbms]()
    success_counter = 0
    failure_counter = 0
    i = 0
    while i < len(sql_queries):
        # Execute the SQL query
        result = db_adaptor.query(sql_queries[i], filename)

        if result[0]:
            success_counter += 1
            i += 1
        else:
            failure_counter += 1
            sql_queries.pop(i)

    db_adaptor.close_connection()

    if not sql_queries:
        raise SQLFileEmptyError(f"Error: SQL file '{filename}' is empty")

    overwrite_sql_file(test_paths, sql_queries)        
    return success_counter, failure_counter



# Iterate over the test case files in the folder (it is a multi-level folder)
for dbms in os.listdir(test_case_path):
    # for test_group in os.listdir(os.path.join(test_case_path, dbmss)):
    if dbms not in dbms_test_case_used:
        continue
    first_init_dbmss({dbms: DBMS_ADAPTERS[dbms]})
    print(f"clean test cases of {dbms}")
    success_all = 0
    failure_all = 0
    deleted_file_list = []
    test_folder=os.path.join(test_case_path, dbms, 'test')
    file_counter = 0

    # iterate all files in the test folder(it is a multi-level folder, the level is not fixed)
    for dirpath, dirnames, filenames in os.walk(test_folder):
        for filename in filenames:
            if filename.endswith('.sql'):
                test_paths = os.path.join(dirpath, filename)
                try:
                    success_counter, failure_counter = run_test_in_all_dbms(test_paths, filename, dbms)
                    file_counter += 1
                except (UnicodeError, SQLFileEmptyError) as e:
                    print(e)
                    deleted_file_list.append((filename, e))
                    delete_sql_file(test_paths)
                    continue
                    
                success_all += success_counter
                failure_all += failure_counter
    print(f"Success (current sql): {success_all}")
    print(f"Failure: {failure_all}")
    print(f"Total uncleaning sql query: {success_all + failure_all}")
    print(f"Total uncleaning .sql file: {file_counter}")
    print(f"Deleted .sql file: {len(deleted_file_list)}")
    print(f"Deleted files: {deleted_file_list}")
            



clean_test_garbage()