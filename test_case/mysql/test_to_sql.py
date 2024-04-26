import re
import os

def extract_sql_queries(test_file, output_file):
    with open(test_file, 'rb') as f:  # 以二进制模式打开文件
        test_content = f.read()

    # 替换注释语句
    test_content = re.sub(b'#.*?\n', lambda match: b'--' + match.group(0)[1:], test_content)

    sql_queries = re.findall(b'^\s*(?:(?:SELECT|INSERT|UPDATE|DELETE|CREATE|ALTER|DROP|...)\s.*?);', test_content, re.MULTILINE | re.DOTALL | re.IGNORECASE)

    with open(output_file, 'wb') as f:  # 以二进制模式写入文件
        for query in sql_queries:
            f.write(query + b'\n')

# 输入文件夹和输出文件夹的路径
test_folder = './test_raw'
output_folder = './test'

for filename in os.listdir(test_folder):
    if filename.endswith('.test'):
        test_file = os.path.join(test_folder, filename)
        output_file = os.path.join(output_folder, filename[:-5] + '.sql')  # 将文件扩展名从 .test 改为 .sql

        extract_sql_queries(test_file, output_file)
