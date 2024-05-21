import os
import re


from utils import clean_query

encodings = ['utf-8', 'Windows-1252', 'koi8-r', 'iso8859-1']

def extract_clickhouse(test_raw_path:str, output_path:str, except_query:list):

    # Delete all files in cleaned_test_path
    for dirpath, dirnames, filenames in os.walk(output_path):
        for file in filenames:
            print(f"Deleting {file}")
            os.remove(os.path.join(dirpath, file))


    for dirpath, dirnames, filenames in os.walk(test_raw_path):
        for file in sorted(filenames):
            # with open(os.path.join(dirpath, file), "r") as f:
            #     sql_file = f.read()
            sql_file = None
            for encoding in encodings:
                try:
                    with open(os.path.join(dirpath, file), 'r', encoding=encoding) as f:
                        sql_file = f.read()
                except UnicodeDecodeError as e:
                    continue

            if not sql_file:
                print(f"Error decoding {file}")
                continue

            sql_list = clean_query(sql_file)
            result_sql_list = []
            for sql in sql_list:
                if any(keyword.lower() in sql.lower() for keyword in except_query):
                    continue
                # remove comments
                sql = sql.strip()
                sql = re.sub(r'^--.*', '', sql)
                sql = sql.strip()
                # remove empty lines
                if not sql:
                    continue
                result_sql_list.append(sql)

            if not result_sql_list:
                print(f"Empty file {file}")
                continue
            else:
                with open(os.path.join(output_path, file), "w") as f:
                    f.write(";\n".join(result_sql_list)+";")
                print(f"Writing {file}")


            