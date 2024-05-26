import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# 定义数据
data = {
    'DBMS_Base': ['clickhouse', 'clickhouse', 'clickhouse', 'clickhouse', 'duckdb', 'duckdb', 'duckdb', 'duckdb', 'mysql', 'mysql', 'mysql', 'mysql', 'postgresql', 'postgresql', 'postgresql', 'postgresql', 'sqlite', 'sqlite', 'sqlite', 'sqlite'],
    'DBMS_Tested': ['duckdb', 'mysql', 'sqlite', 'postgresql', 'postgresql', 'sqlite', 'mysql', 'clickhouse', 'duckdb', 'sqlite', 'postgresql', 'clickhouse', 'duckdb', 'sqlite', 'mysql', 'clickhouse', 'mysql', 'duckdb', 'clickhouse', 'postgresql'],
    'SAME_Number': [5537, 5497, 5492, 5403, 1182, 929, 554, 230, 3058, 3049, 2909, 1026, 1478, 688, 537, 160, 8167, 4591, 4225, 3320],
    'DIFFERENT_Number': [474, 327, 175, 355, 367, 508, 342, 132, 1809, 2135, 1553, 1063, 1036, 945, 539, 186, 2280, 5996, 678, 2615],
    'ERROR_Number': [19530, 19717, 19874, 19783, 2646, 2758, 3299, 3833, 15059, 14742, 15464, 17837, 6571, 7452, 8009, 8739, 17510, 17370, 23054, 22022],
    'SAME_RATE': [21.68, 21.52, 21.50, 21.15, 28.18, 22.15, 13.21, 5.48, 15.35, 15.30, 14.60, 5.15, 16.27, 7.57, 5.91, 1.76, 29.21, 16.42, 15.11, 11.88],
    'DIFFERENT_RATE': [1.86, 1.28, 0.69, 1.39, 8.75, 12.11, 8.15, 3.15, 9.08, 10.71, 7.79, 5.33, 11.40, 10.40, 5.93, 2.05, 8.16, 21.45, 2.43, 9.35],
    'ERROR_RATE': [76.47, 77.20, 77.81, 77.46, 63.08, 65.74, 78.64, 91.37, 75.57, 73.98, 77.61, 89.52, 72.33, 82.03, 88.16, 96.19, 62.63, 62.13, 82.46, 78.77]
}

# 创建DataFrame
df = pd.DataFrame(data)

# 设置Seaborn样式
sns.set(style="whitegrid")

# 创建一个绘图区域，包含三个子图
fig, axes = plt.subplots(nrows=3, ncols=1, figsize=(14, 18))

# 绘制SAME_RATE图表
sns.barplot(ax=axes[0], x='SAME_RATE', y='DBMS_Base', hue='DBMS_Tested', data=df)
axes[0].set_title('SAME_RATE for Different DBMS Comparisons')
axes[0].set_xlabel('SAME_RATE (%)')
axes[0].set_ylabel('DBMS_Base')
axes[0].legend(title='DBMS_Tested')

# 绘制DIFFERENT_RATE图表
sns.barplot(ax=axes[1], x='DIFFERENT_RATE', y='DBMS_Base', hue='DBMS_Tested', data=df)
axes[1].set_title('DIFFERENT_RATE for Different DBMS Comparisons')
axes[1].set_xlabel('DIFFERENT_RATE (%)')
axes[1].set_ylabel('DBMS_Base')
axes[1].legend(title='DBMS_Tested')

# 绘制ERROR_RATE图表
sns.barplot(ax=axes[2], x='ERROR_RATE', y='DBMS_Base', hue='DBMS_Tested', data=df)
axes[2].set_title('ERROR_RATE for Different DBMS Comparisons')
axes[2].set_xlabel('ERROR_RATE (%)')
axes[2].set_ylabel('DBMS_Base')
axes[2].legend(title='DBMS_Tested')

# 调整布局
plt.tight_layout()
plt.show()