import os
import re

testcase_path = "./test_case/postgresql/test_raw"
output_folder = "./test_case/postgresql/test"
encodings = ['utf-8', 'Windows-1252', 'koi8-r', 'iso8859-1']


# delete the file in output folder
for folder in os.listdir(output_folder):
    print(f"Deleting {folder}")
    os.remove(os.path.join(output_folder, folder))

for file in os.listdir(testcase_path):
    if file.endswith(".sql"):
        lines = None
        file_path = os.path.join(testcase_path, file)
        for encoding in encodings:
            try:
                with open(file_path, 'r', encoding=encoding) as f:
                    lines = f.readlines()
            except UnicodeDecodeError as e:
                continue

        if not lines:
            print(f"Error decoding {testcase_path}")
            continue

        for i in range(len(lines)):
            match = re.search(r'^\s*\\', lines[i])
            
            if match:
                print(f"add ; to {lines[i]} in {file}")
                lines[i] = lines[i].strip().strip("\n") + ";\n"
        output_folder_path = os.path.join(output_folder, file)
        with open(output_folder_path, "w") as f:
            f.writelines(lines)
            print(f"Writing {output_folder_path}")
