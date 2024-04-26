import sqlite3
import os
from query_runner import run_all



test_case_path = './test_case'




# Iterate over the test case files in the folder (it is a multi-level folder)
for dbmss in os.listdir(test_case_path):
    # for test_group in os.listdir(os.path.join(test_case_path, dbmss)):

    success_all = 0
    failure_all = 0
    skip_file_list = []
    test_folder=os.path.join(test_case_path, dbmss, 'test')
    for filename in os.listdir(test_folder):
        if filename.endswith('.sql'):
            # setup database
            

            test_paths = os.path.join(test_case_path, dbmss, 'test', filename)
            # setup_paths = os.path.join(test_case_path, dbmss, test_group, 'setup', filename)
            # result_paths = os.path.join(test_case_path, dbmss, test_group, 'result', filename)

            

            try:
                success_counter, failure_counter, df = run_all(test_paths, filename)
            except UnicodeDecodeError as e:
                print(f"Error decode sql file '{filename}': {e}")
                skip_file_list.append(filename)
                continue


            success_all += success_counter
            failure_all += failure_counter
    print(f"Success: {success_all}")
    print(f"Failure: {failure_all}")
    print(f"Skip: {skip_file_list}")
            



if os.path.exists('sqlite_test.db'):
    os.remove('sqlite_test.db')