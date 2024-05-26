import re
from typing import List, Dict

def classify_sql(sql: str) -> List[str]:
    # Define patterns for different types of SELECT statements and functions
    patterns = {
        "aggregate": r"\b(COUNT|SUM|AVG|MIN|MAX|MEDIAN|MODE|STDDEV|VARIANCE|GROUP_CONCAT|ARRAY_AGG)\b",
        "join": r"\bJOIN\b",
        "subquery": r"\b(SELECT\s+.*\s+FROM\s+\(.*\bSELECT\b|SELECT\s+\(.*\bSELECT\b|SELECT\s+.*\s+WHERE\s+\(.*\bSELECT\b)\b",
        "distinct": r"\bDISTINCT\b",
        "where": r"\bWHERE\b",
        "group_by": r"\bGROUP BY\b",
        "order_by": r"\bORDER BY\b",
        "limit": r"\bLIMIT\b",
        "union": r"\bUNION\b",
        "date_function": r"\b(CURRENT_DATE|CURRENT_TIMESTAMP|DATE_ADD|DATE_SUB|DATEDIFF|TIMESTAMPDIFF|NOW|YEAR|MONTH|DAY|HOUR|MINUTE|SECOND|STR_TO_DATE|toDateTime|today)\b",
        "string_function": r"\b(CONCAT|SUBSTRING|LENGTH|UPPER|LOWER|TRIM|REPLACE)\b",
        "math_function": r"\b(ABS|CEIL|FLOOR|ROUND|MOD|POWER|SQRT|EXP|LN|LOG|PI|RADIANS|DEGREES)\b",
        "analytic_function": r"\b(ROW_NUMBER|RANK|DENSE_RANK|NTILE|LEAD|LAG|CUME_DIST|PERCENT_RANK)\b",
        "window_function": r"\bOVER\s*\(.*?\)",
        "conditional_function": r"\b(CASE|IF|COALESCE|NULLIF)\b",
        "set_function": r"\b(INTERSECT|EXCEPT)\b",
        "array_function": r"\b(ARRAY|UNNEST|ARRAY_LENGTH)\b",
        "other_function": r"\b([a-zA-Z_]+\s*\(.*?\))\b",
        "json": r"JSON|{.*}",
        "system_command": r"\b(SYSTEM|SHOW PROCESSLIST|KILL QUERY|RESET QUERY CACHE|PURGE BINARY LOGS)\b",
    }
    
    categories = []
    for category, pattern in patterns.items():
        if re.search(pattern, sql, re.IGNORECASE):
            categories.append(category)
    
    if not categories:
        categories.append("other")
    
    return categories

def classify_sql_statements(sql_statements: List[str]) -> Dict[str, List[str]]:
    categories = {
        "aggregate": [],
        "join": [],
        "subquery": [],
        "distinct": [],
        "where": [],
        "group_by": [],
        "order_by": [],
        "limit": [],
        "union": [],
        "date_function": [],
        "string_function": [],
        "math_function": [],
        "analytic_function": [],
        "window_function": [],
        "conditional_function": [],
        "set_function": [],
        "array_function": [],
        "other_function": [],
        "json": [],  # JSON functions are classified separately
        "other": [],
        "system_command": [],
    }
    
    for sql in sql_statements:
        sql_categories = classify_sql(sql)
        for category in sql_categories:
            if sql not in categories[category]:
                categories[category].append(sql)
    
    return categories
