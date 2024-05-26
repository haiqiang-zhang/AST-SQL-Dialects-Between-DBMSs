# Understanding the Difference Between SQL Dialects using DBMS Test Suites

The project website is available at [https://github.com/haiqiang-zhang/AST-SQL-Dialects-Testing-Between-DBMSs](https://github.com/haiqiang-zhang/AST-SQL-Dialects-Testing-Between-DBMSs)


## Introduction
This study addresses the challenges of SQL dialect compatibility across various database management systems
(DBMSs), including MySQL, PostgreSQL, SQLite, DuckDB, ClickHouse. Despite SQL’s standardization, differ-
ences in dialects complicate interoperability and testing. This project introduces a comprehensive methodology
and toolkit to evaluate SQL dialect compatibility by developing an extensive test suite. The test results are
categorized into three classes: SAME, DIFFERENT, and ERROR, providing a granular analysis of compatibility.
The study includes statistical examinations to identify specific areas of discrepancies and explores the causes
at the code and DBMS architecture levels. Ultimately, this research aims to enhance testing efficiency and
foster SQL dialect compatibility, contributing to the broader understanding of SQL interoperability in database
technology

## Test Results
You should download the original test results from the following link:
[https://drive.google.com/file/d/1KuigPPFbBXgtShQpnQdS-ozRxswmJfZn/view?usp=sharing](https://drive.google.com/file/d/1KuigPPFbBXgtShQpnQdS-ozRxswmJfZn/view?usp=sharing)

The test results are available in the `test_result` folder.
* `sql_classification_compatibility.csv` shows success, different and error rate of each SQL category for all the DBMSs involved in the test.
* `sql_classification_rate_in_dbms.csv` shows the sql dialect classification of other DBMS that each dbms is most compatible with.
* `dbms_compatibility_rates.csv` shows the compatibility rate of each DBMS with other DBMSs.


## How to use the test toolkits
* put the test case in the `test_case` folder, the test case structure should be same as the current `test_case` folder.
* install the required packages by running the `pip install -r requirements.txt` command.
* install and configure the DBMSs that you want to test.
    * MySQL
        * if you use MacOS, you can install the DBMSs using the `brew install` command. And the test toolkits will automatically detect the installed DBMSs and auto config.
        * if you use other OS, you should rewrite init_dbms method in the `adapter/MySQLAdapter.py` file to configure the DBMSs.
    * PostgreSQL
        * Please install the PostgreSQL and start the service.
        * add the superuser configuration in the `adapter/PostgreSQLAdapter.py` file.
    * SQLite
        * No need to install, the test toolkits will automatically create a SQLite database in the `test_db` folder.
    * DuckDB
        * Please install the DuckDB and start the service.
    * ClickHouse
        * Please install the ClickHouse and start the service.
* run the `test_main.py` script to test the compatibility of the SQL dialects.


## The test case structure
There are three mandatory folders for each DBMS:
* `setup`: the setup SQL script for the DBMS.
* `test`: the test SQL script for the DBMS.
* `result`: the expected result of the test SQL script. (each test sql script should have a corresponding result file)