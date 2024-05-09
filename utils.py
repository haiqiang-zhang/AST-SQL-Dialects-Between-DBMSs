import os
from typing import List



def first_init_dbmss(DBMS_ADAPTERS:dict):
    print("Start init DBMSs...")
    for dbms in DBMS_ADAPTERS:
        # check dbms adapter exist init_dbms method or not
        if hasattr(DBMS_ADAPTERS[dbms], 'init_dbms'):
            DBMS_ADAPTERS[dbms].init_dbms()
        print(f"DBMS {dbms} init done")


# define a Error class for SQLFileEmptyError
class SQLFileEmptyError(Exception):
    pass

def clean_test_garbage():
    # Delete all files in test_case_path
    cleaning_list = ["test.db", "cannot-read", "no-such-file"]
    print(f"Cleaning...")
    for file in os.listdir(os.getcwd()):
        if file.endswith(".db") or any(keyword.lower() in file.lower() for keyword in cleaning_list):
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



