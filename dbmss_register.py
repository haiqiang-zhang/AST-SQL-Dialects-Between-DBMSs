from adapter.mysql_adapter import MYSQL
from adapter.sqlite import SQLiteAdapter
from adapter.PostgresqlAdapter import PostgresqlAdapter
from adapter.duckdb_adapter import DUCKDB
from test_case_extractor.extract_testcase_mysql import extract_mysql
from test_case_extractor.extract_testcase_sqlite import extract_sqlite
from test_case_extractor.extract_testcase_postgresql import extract_postgresql
from test_case_extractor.extract_testcase_duckdb import extract_duckdb


DBMSS_SUPPORT = {
    "sqlite": (SQLiteAdapter, extract_sqlite),
    "mysql": (MYSQL, extract_mysql),
    "postgresql": (PostgresqlAdapter, extract_postgresql),
    "duckdb": (DUCKDB, extract_duckdb)
}