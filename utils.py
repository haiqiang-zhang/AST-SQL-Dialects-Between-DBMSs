import os
from typing import List
from dbms_adapter import SQLITE3
import pandas as pd

DBMS_ADAPTERS = {
    "sqlite3": SQLITE3
}

setup_query_keyword = [
    "create table",
    "insert into",
    "drop table"
]


encodings = ['utf-8', 'Windows-1252', 'koi8-r', 'iso8859-1']


# define a Error class for SQLFileEmptyError
class SQLFileEmptyError(Exception):
    pass

def clean_test_garbage():
    # Delete all files in test_case_path
    print(f"Cleaning...")
    for file in os.listdir(os.getcwd()):
        if file.startswith("test.db") or file.endswith(".db"):
            os.remove(os.path.join(os.getcwd(), file))

def clean_query(query)->List[str]:
    # split sql_query with ';'
    sql_query = query.split(';')
    sql_query.pop()
    i = 0
    while i < len(sql_query):
        sql_query[i] = sql_query[i].strip()     
        # remove empty strings
        if not sql_query[i]:
            sql_query.pop(i)
            continue
        i += 1
    return sql_query



def run_setup_in_all_dbms(setup_paths:str):
    # check setup_paths exists
    if os.path.exists(setup_paths):
        with open(setup_paths, 'r') as file:
            setup_query = file.read()
        setup_query = clean_query(setup_query)

        # Execute the SQL query
        for dbms in DBMS_ADAPTERS:
            DBMS_ADAPTERS[dbms].run_setup(setup_query, setup_paths)


def run_test_in_all_dbms(test_paths:str, filename:str)->pd.DataFrame:
    # Read the contents of the test case file
    sql_query = None
    for encoding in encodings:
        try:
            with open(test_paths, 'r', encoding=encoding) as file:
                sql_query = file.read()
        except UnicodeDecodeError as e:
            continue
    
    if not sql_query:
        raise ValueError(f"Error decode sql file '{filename}'")

    # clean the query
    sql_query = clean_query(sql_query)
    # Execute the SQL query
    df = pd.DataFrame(columns=['DBMS','Status', 'result'])

    success_counter = 0
    failure_counter = 0

    for dbms in DBMS_ADAPTERS:
        db_adaptor = DBMS_ADAPTERS[dbms]()
        for query in sql_query:
            result = db_adaptor.query(query, filename)
            if any(keyword.lower() in query.lower() for keyword in setup_query_keyword):
                if result[0]:
                    success_counter += 1
                else:
                    failure_counter += 1
        df.apply(lambda x: x.append([dbms, result[0], result[1]]), axis=1)
        db_adaptor.close_connection()

    
    return success_counter, failure_counter, df


def run_all(test_paths:str, filename:str, setup_paths:str="")->pd.DataFrame:
    if setup_paths:
        run_setup_in_all_dbms(setup_paths)
    return run_test_in_all_dbms(test_paths, filename)