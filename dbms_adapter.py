import os
import sqlite3
from typing import List


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

    def query(self, sql_query:List, filename:str):
        # Execute the SQL query

        combined_result = []
        for query in sql_query:
            try:
                print(query)
                self.cursor.execute(query)
                self.conn.commit()
                result = self.cursor.fetchall()
                combined_result.append((True, result))
                print(result)
                print("=================================")

            except Exception as e:
                combined_result.append((False, ["Error executing test case '{filename}': {e}"]))
                print(f"Error executing test case '{filename}': {e}")
                print("=================================")
                continue
            
        self.close_connection()
        return combined_result

    def close_connection(self):
        # Close the database connection
        self.conn.close()