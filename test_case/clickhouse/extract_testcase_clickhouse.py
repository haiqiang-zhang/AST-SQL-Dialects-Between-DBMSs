import os


# delete the file other than *.sql and *.reference

relative_path = "./test_case/clickhouse"

for dirpath, dirnames, filenames in os.walk(relative_path):
    for file in filenames:
        if not file.endswith(".sql") and not file.endswith(".reference") and not file.endswith(".py"):
            print(f"Deleting {file}")
            os.remove(os.path.join(dirpath, file))