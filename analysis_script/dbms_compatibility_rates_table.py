import pandas as pd

def analyze_csv(input_file, output_file):
    df = pd.read_csv(input_file)
    
    df['Total'] = df['SAME_Number'] + df['DIFFERENT_Number'] + df['ERROR_Number']
    grouped = df.groupby('DBMS_Tested').sum()

    grouped['SAME_RATE'] = grouped['SAME_Number'] / grouped['Total']
    grouped['DIFFERENT_RATE'] = grouped['DIFFERENT_Number'] / grouped['Total']
    grouped['ERROR_RATE'] = grouped['ERROR_Number'] / grouped['Total']

    results = grouped[['SAME_RATE', 'DIFFERENT_RATE', 'ERROR_RATE', 'Total']]

    print(results)

input_file = './analysis_script/summary_result_reserve.csv'
output_file = './analysis_script/compatibility_rates_table.csv'
analyze_csv(input_file, output_file)
