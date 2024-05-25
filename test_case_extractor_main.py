from test_case_extractor.extract_testcase_clickhouse import extract_clickhouse
from test_case_extractor.extract_testcase_sqlite import extract_sqlite
from test_case_extractor.extract_testcase_duckdb import extract_duckdb



except_query = [
    "rand()",
    "format",
    "remote",
    "s3Cluster(",
    "s3(",
    "savepoint",
    "random",
]


test_raw_path = "./test_case/clickhouse/test_raw"
cleaned_test_path = "./test_case/clickhouse/test"
# extract_clickhouse(test_raw_path, cleaned_test_path, except_query)
# extract_sqlite(except_query)
extract_duckdb(except_query)