import os
from typing import List
from adapter.sqlite import SQLITE3
from adapter.mysql_adapter import MYSQL
import pandas as pd
from query_runner import clean_query

DBMS_ADAPTERS = {
    # "sqlite3": SQLITE3,
    "mysql": MYSQL
}

encodings = ['utf-8', 'Windows-1252', 'koi8-r', 'iso8859-1']



def delete_sql_file(file_path:str):
    # delete the specified file
    os.remove(file_path)


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
        result = DBMS_ADAPTERS[dbms]().query(sql_query, filename)
        for res in result:
            if res[0]:
                success_counter += 1
            else:
                failure_counter += 1
        df.apply(lambda x: x.append([dbms, result[0], result[1]]), axis=1)
        
    return success_counter, failure_counter, df

