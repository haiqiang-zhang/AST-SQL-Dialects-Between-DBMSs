import os
import sqlite3
from typing import List
import threading

ECHO = False

setup_query_keyword = [
    "create table",
    "insert into",
    "drop table"
]

class SQLITE3:
    def __init__(self, filename:str="sqlite_test") -> None:
        # check if sqlite_test.dbe exists. If it does, delete it, then create a new one
        if os.path.exists(filename):
            os.remove(filename)

        # Connect to the SQLite database
        self.conn = sqlite3.connect(filename, timeout=2)
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

    def query(self, sql_queries:List, filename:str, timeout_duration=2):
        # Execute the SQL query

        combined_result = []
        for query in sql_queries:
            timer = threading.Timer(timeout_duration, self.interrupt_connection, args=[query])
            try:
                # print(query)
                timer.start()
                self.cursor.execute(query)
                self.conn.commit()
                result = self.cursor.fetchall()
                # keyword include in query
                if any(keyword in query.lower() for keyword in setup_query_keyword):
                    combined_result.append((True, result))

                # print(result)
                # print("=================================")

            except Exception as e:
                if any(keyword in query.lower() for keyword in setup_query_keyword):
                    combined_result.append((False, ["Error executing test case '{filename}': {e}"]))
                print(f"Error executing test case '{filename}': {e}")
                print("=================================")
                continue
            finally:
                timer.cancel()
            
        self.close_connection()
        return combined_result

    def close_connection(self):
        # Close the database connection
        self.conn.close()