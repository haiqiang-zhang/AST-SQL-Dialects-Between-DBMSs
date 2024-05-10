import re
import os
import shutil

test_folder = './test_case/duckdb/test_raw'
output_folder = './test_case/duckdb/test'


def extract_sql_queries(test_file, output_file):
    with open(test_file, 'rb') as f:  
        test_content = f.read()

    
    sql_queries = []
    statement_pattern = re.compile(rb"^statement[^\n]*\n(.*?)(?=(----|\n\n|\Z))", re.S | re.M)
    statements = statement_pattern.findall(test_content)
    for statement in statements:
        if type(statement) == tuple:
            statement = statement[0]
        sql_queries.append(statement.strip())

    query_pattern = re.compile(rb"^query[^\n]*\n(.*?)(?=----)", re.S | re.M)
    queries = query_pattern.findall(test_content)
    for query in queries:
        sql_queries.append(query.strip())


    try:
        with open(output_file, 'wb') as f:  
            for query in sql_queries:
                query = query.strip()
                if query[-1] != b';':
                    query += b';'
                f.write(query + b'\n')
    except FileNotFoundError as e:
        os.makedirs(os.path.dirname(output_file))
        with open(output_file, 'wb') as f: 
            for query in sql_queries:
                query = query.strip()
                if query[-1] != b';' or query[-1] != b';':
                    print(query)
                    query += b';'
                f.write(query + b'\n')




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
            extract_sql_queries(test_file, output_file)
