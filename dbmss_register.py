from adapter.mysql_adapter import MYSQL
from adapter.sqlite import SQLITE3
from test_case_extractor.extract_testcase_mysql import extract_mysql
from test_case_extractor.extract_testcase_sqlite import extract_sqlite


DBMSS_SUPPORT = {
    "sqlite": (SQLITE3, extract_sqlite),
    "mysql": (MYSQL, extract_mysql)
}