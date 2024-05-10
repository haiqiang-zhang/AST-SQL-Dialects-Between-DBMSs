import os
import duckdb
from typing import List
import threading
from utils import print_prevent_stopping
from .DBMSAdapter import DBMSAdapter

ECHO = False

# setup_query_keyword = [
#     "create table",
#     "insert into",
#     "drop table"
# ]

class DUCKDB(DBMSAdapter):
    def __init__(self, filename:str="duckdb.db"):
        if os.path.exists(filename):
            os.remove(filename)

        self.filename = filename
        # Connect to the SQLite database
        self.conn = duckdb.connect(filename)
        # Create a cursor object to execute SQL queries
        self.cursor = self.conn.cursor()

    def run_setup(self, setup_query:List, filename:str):
        # Execute the SQL query
        for query in setup_query:
            # try:
            self.cursor.execute(query)
            self.conn.commit()

            # except:
            #     print(f"[Setup Error] Error setup database in '{filename}': {e}")
            #     continue

    def interrupt_connection(self, query:str):
        self.conn.interrupt()
        raise TimeoutError(f"Query timed out: '{query}'")

    def query(self, sql_query:str, filename:str, timeout_duration=5):
        # Execute the SQL query
        combined_result = None
        timer = threading.Timer(timeout_duration, self.interrupt_connection, args=[sql_query])
        try:
            # print(query)
            timer.start()
            self.cursor.execute(sql_query)
            self.conn.commit()
            result = self.cursor.fetchall()
            # keyword include in query
            # if any(keyword in query.lower() for keyword in setup_query_keyword):
            # timer.join()
            combined_result = (True, result)
            # print(result)
            # print("=================================")

        except Exception as e:
            # if any(keyword in query.lower() for keyword in setup_query_keyword):
            combined_result = (False, ["Error executing test case '{filename}': {e}"])
            print_prevent_stopping(f"Error executing test case '{filename}': {e}")
            print_prevent_stopping("=================================")
        finally:
            timer.cancel()
        
        return combined_result

    def close_connection(self):
        # Close the database connection
        self.conn.close()

        if os.path.exists(self.filename):
            os.remove(self.filename)

    @staticmethod
    def init_dbms():
        pass
    