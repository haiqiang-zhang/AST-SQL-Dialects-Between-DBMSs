# import pandas as pd
import csv

def analyze_csv(input_file, output_file):
    # 读取CSV文件
    with open(input_file, 'r', newline='') as csvfile:
        reader = csv.DictReader(csvfile)
        rows = list(reader)
    
    # 统计每一对DBMS_Base和DBMS_Tested的数量
    dbms_pairs = {}
    for row in rows:
        key = (row['DBMS_Base'], row['DBMS_Tested'])
        if key not in dbms_pairs:
            dbms_pairs[key] = {'SAME': 0, 'DIFFERENT': 0, 'ERROR': 0}
        result = row['Result']
        dbms_pairs[key][result] += 1
    
    # 计算Rate
    for key in dbms_pairs:
        total = sum(dbms_pairs[key].values())
        same_rate = dbms_pairs[key]['SAME'] / total * 100
        different_rate = dbms_pairs[key]['DIFFERENT'] / total * 100
        error_rate = dbms_pairs[key]['ERROR'] / total * 100
        dbms_pairs[key]['SAME Rate'] = same_rate
        dbms_pairs[key]['DIFFERENT Rate'] = different_rate
        dbms_pairs[key]['ERROR Rate'] = error_rate
    
    # 生成新的表格
    with open(output_file, 'w', newline='') as csvfile:
        fieldnames = ['DBMS Baseline', 'DBMS Tested', 'SAME Rate', 'DIFFERENT Rate', 'ERROR Rate']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        
        writer.writeheader()
        for key, value in dbms_pairs.items():
            writer.writerow({'DBMS Baseline': key[0], 'DBMS Tested': key[1],
                             'SAME Rate': value['SAME Rate'], 'DIFFERENT Rate': value['DIFFERENT Rate'],
                             'ERROR Rate': value['ERROR Rate']})

input_file = './init_result.csv'
output_file = './tables/compatibility_rates_table.csv'
analyze_csv(input_file, output_file)
