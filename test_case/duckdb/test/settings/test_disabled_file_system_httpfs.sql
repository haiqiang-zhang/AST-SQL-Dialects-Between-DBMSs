PRAGMA enable_verification;
SET disabled_filesystems='LocalFileSystem';;
from read_csv_auto('https://github.com/duckdb/duckdb/raw/main/data/csv/customer.csv');;
SET disabled_filesystems='LocalFileSystem,HTTPFileSystem';;
from read_csv_auto('https://github.com/duckdb/duckdb/raw/main/data/csv/customer.csv');;
