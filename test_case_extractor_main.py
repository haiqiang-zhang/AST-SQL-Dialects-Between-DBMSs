from test_case_extractor.extract_testcase_clickhouse import extract_clickhouse


except_query = [
    "rand()",
    "format",
    "remote",
    "s3Cluster(",
    "s3(",
]


test_raw_path = "./test_case/clickhouse/test_raw"
cleaned_test_path = "./test_case/clickhouse/test"


extract_clickhouse(test_raw_path, cleaned_test_path, except_query)
