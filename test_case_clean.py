import os
from time import sleep
from typing import List
from adapter.DBMSAdapter import DBMSAdapter
from adapter.SQLiteAdapter import SQLiteAdapter
from adapter.MySQLAdapter import MySQLAdapter
from adapter.PostgresqlAdapter import PostgresqlAdapter
from adapter.DuckDBAdapter import DuckDBAdapter
from adapter.ClickHouseAdapter import ClickHouseAdapter

from result_generate import save_result_to_txt

import pandas as pd
from utils import clean_query, clean_test_garbage, SQLFileEmptyError, first_init_dbmss, clean_query_postgresql, get_test_result_path, parse_result_file, convert_decimals, clean_empty_dir, remove_duplicate_sql


COMPARE_SAME = True

setup_query_keyword = [
    # DDL
    "create",
    "alter",
    "drop",
    # DML
    "insert",
    "update",
    "delete",
    # SET
    "set",
    "reset",
    "pragma",
    # TRANSACTION
    "begin",
    "commit",
    "rollback",
    "end",
]



DBMS_ADAPTERS = {
    "sqlite": SQLiteAdapter,
    "mysql": MySQLAdapter,
    "postgresql": PostgresqlAdapter,
    "duckdb": DuckDBAdapter,
    "clickhouse": ClickHouseAdapter
}


test_case_path = './test_case'
dbms_test_case_used = ['sqlite']
encodings = ['utf-8', 'Windows-1252', 'koi8-r', 'iso8859-1']
fail_queries = []




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


    # remove duplicate sql queries
    num_sql_queries = len(sql_queries)
    sql_queries = remove_duplicate_sql(sql_queries, setup_query_keyword)
    num_duplicate_sql_queries = num_sql_queries - len(sql_queries)

    db_adaptor = DBMS_ADAPTERS[dbms]()
    success_counter = 0
    failure_counter = 0
    i = 0
    output = []
    while i < len(sql_queries):
        # Execute the SQL query
        o = db_adaptor.query(sql_queries[i], filename)
        if o[0]:
            success_counter += 1
            i += 1
            output.append(o[1])
        else:
            failure_counter += 1
            q = sql_queries.pop(i)
            fail_queries.append((filename, q, o[1]))

    db_adaptor.close_connection()

    if not sql_queries:
        raise SQLFileEmptyError(f"Error: SQL file '{filename}' is empty")
    


    
    test_counter = 0
    for query in sql_queries:
        if not any(query.lower().startswith(keyword.lower()) for keyword in setup_query_keyword):
            test_counter += 1

    if test_counter == 0:
        raise SQLFileEmptyError(f"Error: SQL file '{filename}' is empty")
    

    if len(output) != len(sql_queries):
        raise IndexError(f"Error: Output length is different from the SQL queries length in file '{filename}'")
    


    same_sql_queries = []
    same_output = []
    different_counter = 0
    result_counter = 0
    # remove the different query
    result_list = []
    if os.path.exists(get_test_result_path(test_paths)):
        result_list = parse_result_file(get_test_result_path(test_paths))
    if result_list and COMPARE_SAME:
        # for i in range(len(sql_queries)):
        i = 0
        while i < len(sql_queries):
            if any(sql_queries[i].lower().startswith(keyword.lower()) for keyword in setup_query_keyword):
                i += 1
                continue
            result_output = convert_decimals(output[i])
            is_same = str(result_output) == result_list[result_counter]

            if is_same:
                same_sql_queries.append(sql_queries[i])
                same_output.append(result_output)
                i += 1
            else:
                query = sql_queries.pop(i)
                output.pop(i)
                different_counter += 1
                print(f"SQL query {query} is different from the result")
                print(f"Expected: {result_list[result_counter]}")
                print(f"Actual: {result_output}")
                print(f"filename: {filename}")
            result_counter += 1
        if not same_sql_queries:
            raise SQLFileEmptyError(f"Error: SQL file '{filename}' is empty")
        
        if different_counter > 0:
            save_result_to_txt(same_sql_queries, same_output, filename, dbms, test_paths)

   
    overwrite_sql_file(test_paths, sql_queries)  

    success_counter = success_counter - different_counter

    return success_counter, failure_counter, different_counter, num_duplicate_sql_queries

deleted_file_list = []



# Iterate over the test case files in the folder (it is a multi-level folder)
for dbms in os.listdir(test_case_path):
    # for test_group in os.listdir(os.path.join(test_case_path, dbmss)):
    if dbms not in dbms_test_case_used:
        continue
    first_init_dbmss({dbms: DBMS_ADAPTERS[dbms]})
    print(f"clean test cases of {dbms}")
    success_all = 0
    failure_all = 0
    different_all = 0

    test_folder=os.path.join(test_case_path, dbms, 'unsplit')
    file_counter = 0

    # iterate all files in the test folder(it is a multi-level folder, the level is not fixed)
    for dirpath, dirnames, filenames in os.walk(test_folder):
        for filename in sorted(filenames):
            if filename.endswith('.sql'):
                test_paths = os.path.join(dirpath, filename)
                try:
                    
                    success_counter, failure_counter, different_counter, num_duplicate_sql_queries = run_test_in_all_dbms(test_paths, filename, dbms)
                    file_counter += 1
                except (UnicodeError, SQLFileEmptyError) as e:
                    print(e)
                    deleted_file_list.append((filename, e))
                    delete_sql_file(test_paths)
                    continue
                    
                success_all += success_counter
                failure_all += failure_counter
                different_all += different_counter


    clean_empty_dir(test_folder)

    print(f"Duplicated SQL query removed: {num_duplicate_sql_queries}")
    print(f"Failure SQL query: {failure_all}")
    print(f"Different SQL query: {different_all}")
    print(f"Total remained SQL query: {success_all}")
    print(f"Total remained .sql file: {file_counter}")
    print(f"Deleted .sql file: {len(deleted_file_list)}")
    print(f"Deleted files: {deleted_file_list}")
            
    print(f"Fail queries: {fail_queries}")
    
    # write the fail queries to a file
    with open(f"{dbms}_fail_queries.txt", 'w') as file:
        for query in fail_queries:
            file.write(f"{query}\n")


clean_test_garbage()