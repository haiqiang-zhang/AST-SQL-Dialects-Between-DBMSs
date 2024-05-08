import sqlite3
import os
from query_runner import run_all




test_case_path = './test_case'
dbms_test_case_used = ['sqlite']




# Iterate over the test case files in the folder (it is a multi-level folder)
for dbms in os.listdir(test_case_path):
    # for test_group in os.listdir(os.path.join(test_case_path, dbmss)):
    if dbms not in dbms_test_case_used:
        continue
    print(f"Running test cases of {dbms}")
    success_all = 0
    failure_all = 0
    skip_file_list = []
    test_folder=os.path.join(test_case_path, dbms, 'test')
    file_counter = 0

    # iterate all files in the test folder(it is a multi-level folder, the level is not fixed)
    for dirpath, dirnames, filenames in os.walk(test_folder):
        for filename in filenames:
            if filename.endswith('.sql'):
                test_paths = os.path.join(dirpath, filename)
                # setup_paths = os.path.join(test_case_path, dbmss, test_group, 'setup', filename)
                # result_paths = os.path.join(test_case_path, dbmss, test_group, 'result', filename)
                try:
                    success_counter, failure_counter, df = run_all(test_paths, filename)
                    file_counter += 1
                except ValueError as e:
                    print(f"Error decode sql file '{filename}': {e}")
                    skip_file_list.append(filename)
                    continue

                success_all += success_counter
                failure_all += failure_counter
    print(f"Success: {success_all}")
    print(f"Failure: {failure_all}")
    print(f"Total sql query: {success_all + failure_all}")
    print(f"Total .sql file: {file_counter}")
    print(f"Skip: {skip_file_list}")
            



if os.path.exists('sqlite_test.db'):
    os.remove('sqlite_test.db')