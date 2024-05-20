import os
from time import sleep
from typing import List
import threading
import clickhouse_driver
import clickhouse_driver.errors
from .DBMSAdapter import DBMSAdapter

timeout_occurred = threading.Event()
ECHO_SUCC = True
ECHO_ERR = True

config = {
    'host': 'localhost',
    # 'port': 9000,
}


config_tester = {
    'host': 'localhost',
    'user': 'tester',
    'password': '123456',
}

class ClickHouseAdapter(DBMSAdapter):
    @staticmethod
    def init_dbms():
            
        return True
    
    def __init__(self):
    
        # Connect to the SQLite database
        self.conn = None
        self.cursor = None
        self.connection(config)

        timeout_occurred.clear()

        # reset mysql
        #self.reset_mysql()

        # Create a new database and use it
        self.cursor.execute("DROP DATABASE IF EXISTS test")
        self.conn.commit()
        
    def create_test_db(self):
        try:
            self.cursor.execute("CREATE DATABASE test")
            self.cursor.execute("USE test")
            self.conn.commit()
        except Exception as e:
            self.conn.rollback()
            self.cursor.execute("USE test")
    
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
        timeout_occurred.set()
        print(f"Timeout occurred for query: {query}, killing query...")
        conn = clickhouse_driver.connect(**config_tester)
        cursor = conn.cursor()
        # process_list = cursor.execute('SELECT * FROM system.processes ORDER BY \'create_time\' DESC')
        # if process_list:
        #     print("--------++++++++", process_list)
        #     # process_list_sorted = sorted(process_list, key=lambda x: x['create_time'], reverse=True)
        #     last_query_id = process_list[0]
        #     # print("--------++++++++++", process_list_sorted)
        #     cursor.execute("KILL QUERY WHERE query_id = '%s'", (last_query_id,))
        #     conn.commit()
        cursor.execute("KILL QUERY WHERE user = 'default' SYNC")
        conn.close()
        # self.conn.close()
        # self.conn = clickhouse_driver.connect(**config)
        # self.cursor = self.conn.cursor()

    def query(self, sql_query:str, filename:str, timeout_duration=10):
        self.create_test_db()
        combined_result = None
        timeout_occurred.clear()
        timer = threading.Timer(timeout_duration, self.interrupt_connection, args=[sql_query])

        
        try:
            # print(query)
            timer.start()
            self.cursor.execute(sql_query)
            result = self.cursor.fetchall()
            self.conn.commit()
            # keyword include in query
            # if any(keyword in query.lower() for keyword in setup_query_keyword):
            # timer.join()
            combined_result = (True, result)
            if ECHO_SUCC:
                print(f"Filename: {filename}")
                print(f"SQL: {sql_query}")
                print("Success")
                print("-"*50)
                


        except Exception as e:
            # if any(keyword in query.lower() for keyword in setup_query_keyword):
            if timeout_occurred.is_set():
                sleep(2)
                self.connection(config)
            error_type = e.__class__.__name__  
            combined_result = (False, [error_type, f"{e}"])
            if ECHO_ERR:
                print(f"Filename: {filename}")
                print(f"SQL: {sql_query}")
                print(f"Error executing test case '{filename}': {e}")
                print("-"*50)
            
        finally:
            timer.cancel()
        
        return combined_result

    def close_connection(self):
        # Close the database connection
        # self.reset_mysql()
        self.conn.close() 
    
        
    def connection(self, config:dict):
        try:
            self.conn = clickhouse_driver.connect(**config)
            self.cursor = self.conn.cursor()
            print(self.conn)
        except Exception as e:
            print(f"Error connecting to the database: {e}")
            # self.init_dbms()
            # self.conn = mysql.connector.connect(**config)
            # self.cursor = self.conn.cursor()
        return self.conn, self.cursor