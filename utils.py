import os
from typing import List
import re
import sqlparse



def save_result_to_csv(df, filename:str):
    # Save the result to a CSV file
    df.to_csv(f"{filename}.csv", index=False)
    print(f"Save the result to {filename}.csv")



def append_result_to_csv(df, filename:str):
    # Save the result to a CSV file
    df.to_csv(f"{filename}.csv", mode='a', header=False, index=False)


def print_prevent_stopping(string:str):
    string = string.replace(b'\xc2\x9e'.decode(), " ")
    print(string)



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
    cleaning_list = ["test.db", "cannot-read", "no-such-file", "blob"]
    print(f"Cleaning...")
    for file in os.listdir(os.getcwd()):
        if file.endswith(".db") or any(keyword.lower() in file.lower() for keyword in cleaning_list):
            os.remove(os.path.join(os.getcwd(), file))

def clean_query(query:str)->List[str]:
    # split sql_query with ';'
    # if ; is in "" or '', it is not a split point
    # sql_query = re.split(r';(?=(?:[^"\']*["\'][^"\']*["\'])[^"\']*$)', query, flags=re.MULTILINE)
    # sql_query = sqlparse.split(query)
    sql_query = query.split(';')

    i = 0
    while i < len(sql_query):
        sql_query[i] = sql_query[i].strip()     

        # remove comments
        sql_query[i] = re.sub(r'^--.*', '', sql_query[i])
        sql_query[i] = re.sub(r'^/\*.*?\*/', '', sql_query[i], flags=re.DOTALL|re.MULTILINE)

        # remove empty strings
        if not sql_query[i]:
            sql_query.pop(i)
            continue
        i += 1
    return sql_query

def clean_query_postgresql(query:str)->List[str]:
    # split sql_query with ';'
    # if ; is in "" or '' or $TAG$  ;  $TAG$, it is not a split point
    # if ; is in $tag$ ;  $tag$ (please note the left and right tag must be match($tag$...$tag$ matched, $tag$...$tag111$ do not matched ) and case sensitive), it is not a split point too.
    pattern = re.compile(
    r""";(?=(?:[^$]|(?:\$[0-9]+?)|(?:'.*?\$.*?')|(?:".*?\$.*?")|(?:\$(?:\w*?)\$(?:(?!\$\$).)*\$(?:\w*?)\$))*$)""", re.DOTALL)

    sql_query = re.split(pattern, query)

    # remove None values
    sql_query = [i for i in sql_query if i is not None]


    i = 0
    while i < len(sql_query):
        sql_query[i] = sql_query[i].strip()     

        sql_query[i] = re.sub(r'^--.*', '', sql_query[i])
        sql_query[i] = re.sub(r'^/\*.*?\*/', '', sql_query[i], flags=re.DOTALL|re.MULTILINE)

        
        # remove empty strings
        if not sql_query[i]:
            sql_query.pop(i)
            continue
        i += 1
    return sql_query



def clean_query_char(query:str) -> str:
    query = query.strip()
    query = query.replace("\n", "")
    query = query.replace("\t", "")
    query = query.replace("\r", "")
    query = query.replace(" ", "")
    return query




