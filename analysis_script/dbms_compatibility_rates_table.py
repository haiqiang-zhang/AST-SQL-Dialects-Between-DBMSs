import pandas as pd

def analyze_csv(input_file, output_file):
    df = pd.read_csv(input_file)
    
    result_counts = df.groupby(['DBMS_Base', 'DBMS_Tested', 'Result']).size().unstack(fill_value=0)
    
    result_counts['Total'] = result_counts.sum(axis=1)
    
    result_counts['SAME Rate'] = (result_counts['SAME'] / result_counts['Total']) * 100
    result_counts['DIFFERENT Rate'] = (result_counts['DIFFERENT'] / result_counts['Total']) * 100
    result_counts['ERROR Rate'] = (result_counts['ERROR'] / result_counts['Total']) * 100
    
    result_counts = result_counts[['SAME Rate', 'DIFFERENT Rate', 'ERROR Rate']].reset_index()
    result_counts.columns = ['DBMS Tested', 'DIFFERENT Rate', 'SAME Rate', 'ERROR Rate']
    
    result_counts.to_csv(output_file, index=False)

input_file = './init_result.csv'
output_file = './tables/compatibility_rates_table.csv'
analyze_csv(input_file, output_file)
