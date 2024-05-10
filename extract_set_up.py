import os
import re

test_case_path = './test_case'
dbms_test_case_used = ['mysql']

# Iterate over the test case files in the folder (it is a multi-level folder)
for dbms in os.listdir(test_case_path):
    # for test_group in os.listdir(os.path.join(test_case_path, dbmss)):
    if dbms not in dbms_test_case_used:
        continue
    print(f"Running test cases of {dbms}")

    test_folder=os.path.join(test_case_path, dbms, 'test')

    # iterate all files in the test folder(it is a multi-level folder, the level is not fixed)
    for dirpath, dirnames, filenames in os.walk(test_folder):
        for filename in filenames:
            if filename.endswith('.sql'):
                test_paths = os.path.join(dirpath, filename)
                setup_paths = os.path.join(test_case_path, dbms, 'setup', filename)
                # result_paths = os.path.join(test_case_path, dbmss, test_group, 'result', filename)
                
                # if os.path.getsize(test_paths) == 0:
                #     continue
                
                sql_queries = re.findall(b'^\s*(?:(?:SELECT|INSERT|UPDATE|DELETE|CREATE|ALTER|DROP|...)\s.*?);', test_content, re.MULTILINE | re.DOTALL | re.IGNORECASE)
