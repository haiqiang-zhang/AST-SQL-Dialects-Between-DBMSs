import os
from adapter.SQLiteAdapter import SQLiteAdapter
from adapter.MySQLAdapter import MySQLAdapter
from adapter.PostgresqlAdapter import PostgresqlAdapter
from adapter.DBMSAdapter import DBMSAdapter
from adapter.DuckDBAdapter import DuckDBAdapter
from adapter.ClickHouseAdapter import ClickHouseAdapter
import pandas as pd
from utils import clean_query, clean_test_garbage, first_init_dbmss, clean_query_postgresql, save_result_to_csv, append_result_to_csv, convert_decimals, remove_rf
import decimal


test_case_path = './test_case'
test_case_folder_name = "unsplit"
result_folder_name = "result"
dbms_test_case_used = ['sqlite']

DBMS_ADAPTERS:dict[str, type[DBMSAdapter]] = {
    "mysql": MySQLAdapter,
    "sqlite": SQLiteAdapter,
    "postgresql": PostgresqlAdapter,
    "duckdb": DuckDBAdapter,
    "clickhouse": ClickHouseAdapter

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

    
def save_result_to_txt(query_list:list, result_list:list, filename:str, dbms:str, test_path:str):
    # get the relative path of test_path, assume we are in the /test_case/{dbms}/{test_case_folder_name}
    test_path = test_path.split(f"{dbms}/{test_case_folder_name}/")[1]
    test_dir_path = os.path.dirname(test_path)
    print(test_dir_path)

    test_path = os.path.dirname(test_path)
    result_list = convert_decimals(result_list)
    filename = os.path.splitext(filename)[0]
    # if not the folder exists, create the folder
    if not os.path.exists(f"./test_case/{dbms}/{result_folder_name}/{test_dir_path}"):
        os.makedirs(f"./test_case/{dbms}/{result_folder_name}/{test_dir_path}")
    with open(f"./test_case/{dbms}/{result_folder_name}/{test_dir_path}/{filename}.txt", 'w') as file:
        for index, result in enumerate(result_list):
            file.write("--Query--\n")
            file.write(query_list[index] + "\n")
            file.write("--Result--\n")
            if result == "QUERY ERROR":
                file.write("QUERY ERROR\n")
            else:
                file.write(str(result) + '\n')

            file.write("+"+"-"*20+"+\n")
            
    print(f"Save the result to {filename}.txt")

def run_setup_in_all_dbms(setup_paths:str):
    # check setup_paths exists
    if os.path.exists(setup_paths):
        with open(setup_paths, 'r') as file:
            setup_query = file.read()
        setup_query = clean_query(setup_query)

        # Execute the SQL query
        for dbms in DBMS_ADAPTERS:
            DBMS_ADAPTERS[dbms].run_setup(setup_query, setup_paths)


def run_test_in_all_dbms(test_paths:str, filename:str, dbms:str):
    result_list = []
    result_query_list = []
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
    print("Start parsing SQL file: ", filename)
    if 'postgresql' in test_paths:
        sql_queries = clean_query_postgresql(sql_queries)
    else:
        sql_queries = clean_query(sql_queries)


    df = pd.DataFrame(columns=['DBMS', 'SAME_Number', 'DIFFERENT_Number', 'ERROR_Number'])
    df_verbose_all_result_one_file = pd.DataFrame(columns=['DBMS', 'SQL_Query', 'Result', 'ERROR_Type', 'Message'])
    


    db_adaptor = DBMS_ADAPTERS[dbms]()
    success_counter = 0
    failure_counter = 0
    for query in sql_queries:
        query = query.strip()
        result = db_adaptor.query(query, filename)
        if not any(query.lower().startswith(keyword.lower()) for keyword in setup_query_keyword):
            query = query.replace('\n', ' ')
            result_query_list.append(query)
            if result[0]:
                result_list.append(result[1])
                success_counter += 1
                df_verbose_all_result_one_file = df_verbose_all_result_one_file._append({'DBMS': dbms, 'SQL_Query': query, 'Result': "SAME", 'ERROR_Type': None, 'Message': result[1]}, ignore_index=True)
            else:

                result_list.append("QUERY ERROR")
                failure_counter += 1
                error_message = result[1][1]
                error_message = error_message.replace('\n', ' ')
                error_message = error_message.replace('^', '')
                error_message = error_message.strip()
                df_verbose_all_result_one_file = df_verbose_all_result_one_file._append({'DBMS': dbms, 'SQL_Query': query, 'Result': "ERROR", 'ERROR_Type': result[1][0], 'Message': error_message}, ignore_index=True)
    df = df._append({'DBMS': dbms, 'SAME_Number': success_counter, 'DIFFERENT_Number': 0, 'ERROR_Number': failure_counter}, ignore_index=True)
    db_adaptor.close_connection()
    


    save_result_to_txt(result_query_list, result_list, filename, dbms, test_paths)
    
    return success_counter, failure_counter, df, df_verbose_all_result_one_file


def run_all(test_paths:str, filename:str, dbms:str, setup_paths:str=""):
    if setup_paths:
        run_setup_in_all_dbms(setup_paths)
    return run_test_in_all_dbms(test_paths, filename, dbms)


if __name__ == "__main__":

    # Define a pd.DataFrame to store the test results
    df = pd.DataFrame(columns=['DBMS_Base', 'DBMS_Tested', 'SAME_Number', 'DIFFERENT_Number', 'ERROR_Number', 'Total_Number_of_SQL_files'])

    df_verbose_all_result = pd.DataFrame(columns=['DBMS_Base', 'DBMS_Tested', 'SQL_Query', 'SQL_File_Name', 'Result', 'ERROR_Type', 'ERROR_Message'])
    save_result_to_csv(df_verbose_all_result, "init_result")


    # Iterate over the test case files in the folder (it is a multi-level folder)
    for dbms in os.listdir(test_case_path):
        
        # for test_group in os.listdir(os.path.join(test_case_path, dbmss)):
        if dbms not in dbms_test_case_used:
            continue


        remove_rf(f"./test_case/{dbms}/{result_folder_name}")
        
        # if test_extract_mode and dbms in DBMS_ADAPTERS:
        #     dbms_dict = {dbms: DBMS_ADAPTERS[dbms]}
        # else:
        #     continue

        
        first_init_dbmss({dbms: DBMS_ADAPTERS[dbms]})
        print(f"Running test cases of {dbms}")
        test_folder=os.path.join(test_case_path, dbms, test_case_folder_name)
        file_counter = 0

        

        # iterate all files in the test folder(it is a multi-level folder, the level is not fixed)
        for dirpath, dirnames, filenames in os.walk(test_folder):
            for filename in sorted(filenames):
                if filename.endswith('.sql'):
                    test_paths = os.path.join(dirpath, filename)
                    # setup_paths = os.path.join(test_case_path, dbmss, test_group, 'setup', filename)
                    # result_paths = os.path.join(test_case_path, dbmss, test_group, 'result', filename)

                    if os.path.getsize(test_paths) == 0:
                        continue

                    df_verbose_all_result = pd.DataFrame(columns=['DBMS_Base', 'DBMS_Tested', 'SQL_Query', 'SQL_File_Name', 'Result', 'ERROR_Type', 'Message'])

                    
                    try:
                        success_counter, failure_counter, df_one_file, df_verbose_all_result_one_file = run_all(test_paths, filename, dbms)
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
                            df_verbose_all_result = df_verbose_all_result._append({'DBMS_Base': dbms, 'DBMS_Tested': df_verbose_all_result_one_file.iloc[i]['DBMS'], 'SQL_Query': df_verbose_all_result_one_file.iloc[i]['SQL_Query'], 'SQL_File_Name': filename, 'Result': df_verbose_all_result_one_file.iloc[i]['Result'], 'ERROR_Type': df_verbose_all_result_one_file.iloc[i]['ERROR_Type'], 'Message': df_verbose_all_result_one_file.iloc[i]['Message']}, ignore_index=True)
                        file_counter += 1
                    except ValueError as e:
                        print(f"Error decode sql file '{filename}': {e}")
                        continue

                    append_result_to_csv(df_verbose_all_result, "init_result")
                    del df_verbose_all_result


        clean_test_garbage()



    print()
    print(df)

        
                


