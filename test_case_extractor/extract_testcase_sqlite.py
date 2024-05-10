# delete the file other than *.test

import os


log_path = "/Users/larryzhang/Project/sqlite/testrunner.log"
test_case_path = "./test_case/sqlite/test"


except_query = [
    "savepoint",
    "random",
]


except_files = [
    "mmap2"
]

def is_except_file(file_name:str):
    for except_file in except_files:
        if except_file in file_name:
            return True
    return False


def extract_sqlite():

    # Delete all files in test_case_path
    for dirpath, dirnames, filenames in os.walk(test_case_path):
        for file in filenames:
            print(f"Deleting {file}")
            os.remove(os.path.join(dirpath, file))

    if not os.path.exists(log_path):
        print(f"File {log_path} does not exist")

    # Parse testrunner.log

    with open(log_path, "r") as f:
        whole_log = f.read()

        # split by test file
        files = whole_log.split("###+++###")

        for file in files:
            if "++*++SQL=" not in file:
                continue
            else:
                sql_file_name = file.split("\n")[0].split(".test")[0] + ".sql"
                if is_except_file(sql_file_name):
                    continue
                sql_file_name = sql_file_name.replace("/", "_")
                print(f"Writing {sql_file_name}")

                sqls_before_clean = file.split("++*++SQL=")[1:]

                sqls = []
                for sql in sqls_before_clean:
                    temp_sql = sql.split("--*--")[0]

                    if any(keyword.lower() in temp_sql.lower() for keyword in except_query):
                        continue

                    temp_sql = temp_sql.strip()

                    if temp_sql == "":
                        continue
                    if not temp_sql.endswith(";"):
                        temp_sql += ";"
                    temp_sql += "\n"
                    sqls.append(temp_sql)
                        


                with open(os.path.join(test_case_path, sql_file_name), "w") as f:
                    f.write("\n".join(sqls))



if __name__ == '__main__':
    extract_sqlite()


            
