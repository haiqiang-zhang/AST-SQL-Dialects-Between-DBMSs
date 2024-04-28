# delete the file other than *.test

import os


relative_path = "./test_case/sqlite/test_raw"

for file in os.listdir(relative_path):
    if not file.endswith(".test"):
        print(f"Deleting {file}")
        os.remove(os.path.join(relative_path, file))
