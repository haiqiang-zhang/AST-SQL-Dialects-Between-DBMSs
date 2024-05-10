import re
import os



WITH_SET = False
raw_test_case_folder = './test_case/mysql/test_raw'
output_folder = './test_case/mysql/test'

encodings = ['utf-8', 'Windows-1252', 'koi8-r', 'iso8859-1']
except_query = [
    "rand()",
    "mysql.",
    "sys.",
    "ALTER USER"
]



def extract_sql_queries(test_file, output_file):
    test_content = None
    for encoding in encodings:
        try:
            with open(test_file, 'r', encoding=encoding) as file:
                test_content = file.read()
        except UnicodeDecodeError as e:
            continue
    
    if not test_content:
        print(f'Error decoding {test_file}')
        return
    # 替换注释语句
    # test_content = re.sub(b'#.*?\n', lambda match: b'--' + match.group(0)[1:], test_content)
    if WITH_SET == False:
        sql_queries = re.findall(r'^\s*(?:SELECT|INSERT|UPDATE|DELETE|CREATE|ALTER|DROP|LOCK|UNLOCK|PREPARE|DEALLOCATE)\s.*?;', test_content, re.MULTILINE | re.DOTALL | re.IGNORECASE)
    else:
        sql_queries = re.findall(r'^\s*(?:SELECT|INSERT|UPDATE|DELETE|CREATE|ALTER|DROP|LOCK|UNLOCK|PREPARE|DEALLOCATE|SET)\s.*?;', test_content, re.MULTILINE | re.DOTALL | re.IGNORECASE)
    i = 0
    while i < len(sql_queries):
        if any(keyword.lower() in sql_queries[i].lower() for keyword in except_query):
            sql_queries.pop(i)
        else:
            i += 1
    if not sql_queries:
        print(f'No SQL queries found in {test_file}')
        return
    with open(output_file, 'w') as f:  
        for query in sql_queries:
            f.write(query + '\n')



def extract_mysql():
    # Delete all files in test_case_path
    for dirpath, dirnames, filenames in os.walk(output_folder):
        for file in filenames:
            print(f"Deleting {file}")
            os.remove(os.path.join(dirpath, file))


    for filename in os.listdir(raw_test_case_folder):
        if filename.endswith('.test'):
            test_file = os.path.join(raw_test_case_folder, filename)
            output_file = os.path.join(output_folder, filename[:-5] + '.sql')  

            extract_sql_queries(test_file, output_file)


if __name__ == '__main__':
    extract_mysql()