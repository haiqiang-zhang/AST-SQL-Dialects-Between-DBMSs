import os
from adapter.SQLiteAdapter import SQLiteAdapter
from adapter.MySQLAdapter import MySQLAdapter
from adapter.PostgresqlAdapter import PostgresqlAdapter
from adapter.DBMSAdapter import DBMSAdapter
from adapter.DuckDBAdapter import DuckDBAdapter
from adapter.ClickHouseAdapter import ClickHouseAdapter
import pandas as pd
from utils import clean_query, clean_test_garbage, first_init_dbmss, clean_query_postgresql, save_result_to_csv, append_result_to_csv, parse_result_file, get_test_result_path
import decimal
from sql_classifer import classify_sql


# ================== Configuration ==================

test_case_path = './test_case'
test_case_folder_name = "unsplit"

# Configure which test cases to run
dbms_test_case_used = ['postgresql']

# Configure Which DBMS to be tested
DBMS_ADAPTERS:dict[str, type[DBMSAdapter]] = {
    # "mysql": MySQLAdapter,
    # "sqlite": SQLiteAdapter,
    "postgresql": PostgresqlAdapter,
    # "duckdb": DuckDBAdapter,
    # "clickhouse": ClickHouseAdapter

}

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

encodings = ['utf-8', 'Windows-1252', 'koi8-r', 'iso8859-1']

# ================== End of Configuration ==================

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

def read_sql_file(test_paths:str, filename:str, encodings:list):
    sql_query = None
    for encoding in encodings:
        try:
            with open(test_paths, 'r', encoding=encoding) as file:
                sql_query = file.read()
        except UnicodeDecodeError as e:
            continue
    
    if sql_query is None:
        raise UnicodeError(f"Error decode sql file '{filename}'")
    
    return sql_query


def run_test_in_all_dbms(test_paths:str, filename:str, setup_paths:str=""):
    result_list = []
    # Read the contents of the test case file

    # clean the query
    print("Start parsing SQL file: ", filename)
    sql_query = read_sql_file(test_paths, filename, encodings)
    if 'postgresql' in test_paths:
        sql_query = clean_query_postgresql(sql_query)
    else:
        sql_query = clean_query(sql_query)

    if setup_paths:
        setup_query = read_sql_file(setup_paths, filename, encodings)

        if setup_query.strip() != "":
            if 'postgresql' in setup_paths:
                setup_query = clean_query_postgresql(setup_query)
            else:
                setup_query = clean_query(setup_query)

            sql_query = setup_query + sql_query

    
    print("Finish parsing SQL file: ", filename)

    # get the result of the test case
    
    result_list = parse_result_file(get_test_result_path(test_paths, test_dir_name=test_case_folder_name))


    df = pd.DataFrame(columns=['DBMS', 'SAME_Number', 'DIFFERENT_Number', 'ERROR_Number'])
    df_verbose_all_result_one_file = pd.DataFrame(columns=['DBMS', 'SQL_Query', 'SQL_Type', 'Result', 'ERROR_Type', 'Message'])
    

    for dbms in DBMS_ADAPTERS:
        result_index_counter = 0
        db_adaptor = DBMS_ADAPTERS[dbms]()

        success_counter = 0
        diff_counter = 0
        failure_counter = 0
        for query in sql_query:
            result = db_adaptor.query(query, filename, timeout_duration=10)

            if not any(query.lower().startswith(keyword.lower()) for keyword in setup_query_keyword):
                result_output = convert_decimals(result[1])
                print(query)
                is_same = str(result_output) == result_list[result_index_counter]
                
                query = query.replace('\n', ' ')
                if is_same:
                    success_counter += 1
                    df_verbose_all_result_one_file = df_verbose_all_result_one_file._append({'DBMS': dbms, 'SQL_Query': query, 'SQL_Type':classify_sql(query), 'Result': "SAME", 'ERROR_Type': None, 'Message': result[1]}, ignore_index=True)
                elif result[0]:
                    diff_counter += 1
                    df_verbose_all_result_one_file = df_verbose_all_result_one_file._append({'DBMS': dbms, 'SQL_Query': query,'SQL_Type':classify_sql(query), 'Result': "DIFFERENT", 'ERROR_Type': None, 'Message': result[1]}, ignore_index=True)
                else:
                    failure_counter += 1
                    error_message = result[1][1]
                    error_message = error_message.replace('\n', ' ')
                    error_message = error_message.replace('^', '')
                    error_message = error_message.strip()
                    df_verbose_all_result_one_file = df_verbose_all_result_one_file._append({'DBMS': dbms, 'SQL_Query': query, 'SQL_Type':classify_sql(query), 'Result': "ERROR", 'ERROR_Type': result[1][0], 'Message': error_message}, ignore_index=True)
                result_index_counter += 1
        df = df._append({'DBMS': dbms, 'SAME_Number': success_counter, 'DIFFERENT_Number': diff_counter, 'ERROR_Number': failure_counter}, ignore_index=True)
        db_adaptor.close_connection()
        

    
    return df, df_verbose_all_result_one_file


# def run_all(test_paths:str, filename:str, setup_paths:str=""):
#     return run_test_in_all_dbms(test_paths, filename, setup_paths)





# Define a pd.DataFrame to store the test results
df = pd.DataFrame(columns=['DBMS_Base', 'DBMS_Tested', 'SAME_Number', 'DIFFERENT_Number', 'ERROR_Number', 'Total_Number_of_SQL_files'])
df['SAME_RATE'] = df['SAME_Number'] / (df['SAME_Number'] + df['DIFFERENT_Number'] + df['ERROR_Number'])
df['DIFFERENT_RATE'] = df['DIFFERENT_Number'] / (df['SAME_Number'] + df['DIFFERENT_Number'] + df['ERROR_Number'])
df['ERROR_RATE'] = df['ERROR_Number'] / (df['SAME_Number'] + df['DIFFERENT_Number'] + df['ERROR_Number'])

df_verbose_all_result = pd.DataFrame(columns=['DBMS_Base', 'DBMS_Tested', 'SQL_Query', 'SQL_Type', 'SQL_File_Name', 'Result', 'ERROR_Type', 'Message'])
save_result_to_csv(df_verbose_all_result, "init_result")
save_result_to_csv(df, "summary_result")


# Iterate over the test case files in the folder (it is a multi-level folder)
for dbms in os.listdir(test_case_path):
    
    # for test_group in os.listdir(os.path.join(test_case_path, dbmss)):
    if dbms not in dbms_test_case_used:
        continue
    
    # if test_extract_mode and dbms in DBMS_ADAPTERS:
    #     dbms_dict = {dbms: DBMS_ADAPTERS[dbms]}
    # else:
    #     continue
        
    first_init_dbmss(DBMS_ADAPTERS)
    print(f"Running test cases of {dbms}")
    test_folder=os.path.join(test_case_path, dbms, test_case_folder_name)
    file_counter = 0

    # iterate all files in the test folder(it is a multi-level folder, the level is not fixed)
    for dirpath, dirnames, filenames in os.walk(test_folder):
        for filename in sorted(filenames):
            if filename.endswith('.sql'):
                test_paths = os.path.join(dirpath, filename)
                # setup_paths = test_paths.replace(f"/{dbms}/{test_case_folder_name}", f"/{dbms}/setup")

                if os.path.getsize(test_paths) == 0:
                    continue

                df_verbose_all_result = pd.DataFrame(columns=['DBMS_Base', 'DBMS_Tested', 'SQL_Query', 'SQL_Type', 'SQL_File_Name', 'Result', 'ERROR_Type', 'Message'])
                
                try:
                    df_one_file, df_verbose_all_result_one_file = run_test_in_all_dbms(test_paths, filename)
                    for i in range(len(df_one_file)):
                        # check DBMS_Base = dbms, DBMS_Tested = df_one_file[i]['DBMS'] exist or not
                        if df[(df['DBMS_Base'] == dbms) & (df['DBMS_Tested'] == df_one_file.iloc[i]['DBMS'])].empty:
                            df = df._append({'DBMS_Base': dbms, 'DBMS_Tested': df_one_file.iloc[i]['DBMS'], 'SAME_Number': df_one_file.iloc[i]['SAME_Number'], 'DIFFERENT_Number': df_one_file.iloc[i]['DIFFERENT_Number'], 'ERROR_Number': df_one_file.iloc[i]['ERROR_Number'], 'Total_Number_of_SQL_files': 1}, ignore_index=True)
                        else:
                            df.loc[(df['DBMS_Base'] == dbms) & (df['DBMS_Tested'] == df_one_file.iloc[i]['DBMS']), 'SAME_Number'] += df_one_file.iloc[i]['SAME_Number']
                            df.loc[(df['DBMS_Base'] == dbms) & (df['DBMS_Tested'] == df_one_file.iloc[i]['DBMS']), 'DIFFERENT_Number'] += df_one_file.iloc[i]['DIFFERENT_Number']
                            df.loc[(df['DBMS_Base'] == dbms) & (df['DBMS_Tested'] == df_one_file.iloc[i]['DBMS']), 'ERROR_Number'] += df_one_file.iloc[i]['ERROR_Number']
                            df.loc[(df['DBMS_Base'] == dbms) & (df['DBMS_Tested'] == df_one_file.iloc[i]['DBMS']), 'Total_Number_of_SQL_files'] += 1
                    
                    for i in range(len(df_verbose_all_result_one_file)):
                        df_verbose_all_result = df_verbose_all_result._append({'DBMS_Base': dbms, 'DBMS_Tested': df_verbose_all_result_one_file.iloc[i]['DBMS'], 'SQL_Query': df_verbose_all_result_one_file.iloc[i]['SQL_Query'],  'SQL_Type':df_verbose_all_result_one_file.iloc[i]['SQL_Type'], 'SQL_File_Name': filename, 'Result': df_verbose_all_result_one_file.iloc[i]['Result'], 'ERROR_Type': df_verbose_all_result_one_file.iloc[i]['ERROR_Type'], 'Message': df_verbose_all_result_one_file.iloc[i]['Message']}, ignore_index=True)
                    file_counter += 1
                except ValueError as e:
                    print(f"Error decode sql file '{filename}': {e}")
                    continue

                df['SAME_RATE'] = df['SAME_Number'] / (df['SAME_Number'] + df['DIFFERENT_Number'] + df['ERROR_Number'])
                df['DIFFERENT_RATE'] = df['DIFFERENT_Number'] / (df['SAME_Number'] + df['DIFFERENT_Number'] + df['ERROR_Number'])
                df['ERROR_RATE'] = df['ERROR_Number'] / (df['SAME_Number'] + df['DIFFERENT_Number'] + df['ERROR_Number'])

                append_result_to_csv(df_verbose_all_result, "init_result")
                save_result_to_csv(df, "summary_result")

                del df_verbose_all_result


    clean_test_garbage()


# analyze the df

# add columns: SAME RATE, DIFFERENT RATE, ERROR RATE 




print()
print(df)


    
            


