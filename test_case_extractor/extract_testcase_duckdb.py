import re
import os
import shutil

test_folder = './test_case/duckdb/test_raw'
output_folder = './test_case/duckdb/unsplit'

encodings = ['utf-8', 'Windows-1252', 'koi8-r', 'iso8859-1']


def extract_sql_queries(test_file, output_file, except_query):
    test_content = None
    for encoding in encodings:
        try:
            with open(test_file, 'r', encoding=encoding) as f:
                test_content = f.read()
        except UnicodeDecodeError as e:
            continue

    if not test_content:
        print(f"Error decoding {test_file}")
        return

    
    sql_queries = []
    statement_pattern = re.compile(r"^statement[^\n]*\n(.*?)(?=(----|\n\n|\Z))", re.S | re.M)
    statements = statement_pattern.findall(test_content)
    for statement in statements:
        if type(statement) == tuple:
            statement = statement[0]
        sql_queries.append(statement.strip())

    query_pattern = re.compile(r"^query[^\n]*\n(.*?)(?=----)", re.S | re.M)
    queries = query_pattern.findall(test_content)
    for query in queries:
        if any(keyword.lower() in query.lower() for keyword in except_query):
                continue
        sql_queries.append(query.strip())

    if not sql_queries:
        return


    try:
        with open(output_file, 'w') as f:  
            for query in sql_queries:
                query = query.strip()
                if query[-1] != ';':
                    query += ';'
                f.write(query + '\n')
    except FileNotFoundError as e:
        os.makedirs(os.path.dirname(output_file))
        with open(output_file, 'w') as f: 
            for query in sql_queries:
                query = query.strip()
                if query[-1] != ';' or query[-1] != ';':
                    query += ';'
                f.write(query + '\n')


def extract_duckdb(except_query:list):

    # delete the file in output folder
    for folder in os.listdir(output_folder):
        print(f"Deleting {folder}")
        shutil.rmtree(os.path.join(output_folder, folder))
        


    for group in os.listdir(test_folder):
        group_folder = os.path.join(test_folder, group)
        for filename in os.listdir(group_folder):
            if filename.endswith('.test'):
                test_file = os.path.join(group_folder, filename)
                output_file = os.path.join(output_folder, group, filename[:-5] + '.sql') 
                extract_sql_queries(test_file, output_file, except_query)
