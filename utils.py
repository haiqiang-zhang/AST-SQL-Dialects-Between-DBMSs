import os
import shutil
from typing import List
import re
import sqlparse
import decimal


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

        sql_query[i] = sql_query[i].strip()
        sql_query[i] = sql_query[i].strip('\n')

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

        sql_query[i] = sql_query[i].strip()
        sql_query[i] = sql_query[i].strip('\n')

        
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




def parse_result_file(filename:str):
    # Read the result file
    with open(filename, 'r') as file:
        f = file.read()

    # Split the result file
    result = f.split('+--------------------+')
    result_list = []
    for i in range(0, len(result)):
        # --Query--
        # ATTACH '__TEST_DIR__/attach_all_types.db' AS db1
        # --Result--
        # []
        # parse these kind of result

        temp = result[i]
        temp = temp.strip()
    
        if not temp:
            continue

        query = temp.split('--Result--')[0].split('--Query--')[1].strip()
        result_context = temp.split('--Result--')[1].strip()
        result_list.append(result_context)
    return result_list


def get_test_result_path(test_path:str, test_dir_name:str='unsplit'):

    dbms = test_path.split('/')[2]
    # get the result path
    result_path = test_path.replace(f"/{dbms}/{test_dir_name}", f"/{dbms}/result")
    result_path = result_path.replace('.sql', '.txt')
    return result_path


def convert_decimals(obj):
    if isinstance(obj, list):
        return [convert_decimals(item) for item in obj]
    elif isinstance(obj, tuple):
        return tuple(convert_decimals(item) for item in obj)
    elif isinstance(obj, dict):
        return {key: convert_decimals(value) for key, value in obj.items()}
    elif isinstance(obj, decimal.Decimal):
        return float(obj)
    else:
        return obj
    

def remove_rf(path:str):
    # remove the folder
    if os.path.exists(path):
        for folder in os.listdir(path):
            if os.path.isdir(os.path.join(path, folder)):
                shutil.rmtree(os.path.join(path, folder))
            else:
                os.remove(os.path.join(path, folder))
                print(f"Removing {folder}")
    else:
        print(f"{path} not exists")



def clean_empty_dir(path:str):
    # remove the empty folder
    for folder in os.listdir(path):
        # if the folder is a folder and it is empty, remove it
        if os.path.isdir(os.path.join(path, folder)) and not os.listdir(os.path.join(path, folder)):
            shutil.rmtree(os.path.join(path, folder))
            print(f"Removing {folder}")



def remove_duplicate_sql(sql_queries:List[str], except_keyword)->List[str]:
    output = []
    already_scan = []
    for query in sql_queries:
        if not any(query.lower().startswith(keyword.lower()) for keyword in except_keyword):
            parsed = sqlparse.parse(query)[0]
            
            keyword = parsed.tokens[0].value.lower()
            functions = []
            comparison = []

            token_list = flatten_sql_ast(parsed.tokens, [])
            for token in token_list:
                if isinstance(token, sqlparse.sql.Function):
                    if token.get_name():
                        functions.append(token.get_name())

            # remove duplicate function
            functions = list(set(functions)) 
            functions.sort()

            if functions and (keyword, functions) not in already_scan:
                output.append(query)

            if not functions:
                output.append(query)
            
            already_scan.append((keyword, functions))
        else:
            output.append(query)

    return output



def flatten_sql_ast(parsed, output):
    for i in parsed:
        if isinstance(i, sqlparse.sql.IdentifierList):
            flatten_sql_ast(list(i.get_identifiers()), output)
        else:
            output.append(i)

    return output
