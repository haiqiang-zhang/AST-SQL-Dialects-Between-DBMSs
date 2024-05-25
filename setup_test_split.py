import os
from utils import clean_query, clean_query_postgresql

dbms_tests = ['clickhouse', 'mysql', 'postgresql', 'sqlite', 'duckdb']

def extract_and_save_sql_statements(input_sql_file, setup_directory, dbms_test):
    # setup keywords
    keywords = ["create table", "insert into", "drop table", "create database"]

    # setup dir path
    if not os.path.exists(setup_directory):
        os.makedirs(setup_directory)
    
    with open(input_sql_file, 'r', encoding='utf-8') as sql_file:
        content = sql_file.read()
    
    clean_query_list = None
    if dbms_test == 'postgresql':
        clean_query_list = clean_query_postgresql(content)
    else:
        clean_query_list = clean_query(content)
    
    extracted_statements = []
    remaining_statements = []
    extraction_done = False
    
    for q in clean_query_list:
        if not extraction_done:
            if any(keyword in q.lower() for keyword in keywords):
                q = q + ';\n'
                extracted_statements.append(q)
            else:
                extraction_done = True
                q = q + ';\n'
                remaining_statements.append(q)
        else:
            q = q + ';\n'
            remaining_statements.append(q)
    
    output_txt_file = os.path.join(setup_directory, os.path.basename(input_sql_file).replace('.sql', '.txt').strip())
    # print(output_txt_file)
    
    with open(output_txt_file, 'w', encoding='utf-8') as txt_file:
        txt_file.writelines(extracted_statements)
    
    with open(input_sql_file, 'w', encoding='utf-8') as sql_file:
        sql_file.writelines(remaining_statements)

for dbms_test in dbms_tests:
    test_directory = f'./test_case/{dbms_test}/test'
    setup_directory = f'./test_case/{dbms_test}/setup'
    for filename in os.listdir(test_directory):
        if filename.endswith('.sql'):
            input_sql_file = os.path.join(test_directory, filename)
            extract_and_save_sql_statements(input_sql_file, setup_directory, dbms_test)
