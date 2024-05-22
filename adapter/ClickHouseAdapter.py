import os
from time import sleep
from typing import List
import threading
import clickhouse_driver
import clickhouse_driver.errors
from .DBMSAdapter import DBMSAdapter
from utils import clean_query_char

timeout_occurred = threading.Event()
ECHO_SUCC = True
ECHO_ERR = True
EXECUTE_TIMEOUT = 1

config = {
    'host': 'localhost',
    'settings': {
        'connections_with_failover_max_tries': 1,
        'connect_timeout_with_failover_ms': EXECUTE_TIMEOUT*1000,
        'max_execution_time': EXECUTE_TIMEOUT,
    }
    # 'port': 9000,
}


config_tester = {
    'host': 'localhost',
    'user': 'tester',
}

class ClickHouseAdapter(DBMSAdapter):
    @staticmethod
    def init_dbms():
        pass
    
    def __init__(self):
    
        # Connect to the SQLite database
        self.conn = None
        # self.cursor = None
        self.connection(config)
        


        # Create a new database and use it
        self.conn.execute("DROP DATABASE IF EXISTS test")
        self.create_test_db()
        
    def create_test_db(self):
        try:
            self.conn.execute("CREATE DATABASE IF NOT EXISTS test")
            self.conn.execute("USE test")
        except Exception as e:
            self.conn.execute("USE test")
    

    def interrupt_connection(self, query:str):
        timeout_occurred.set()
        # print(f"Timeout occurred for query: '{query}', killing query...")
        

        conn = clickhouse_driver.Client(**config_tester)
        # cursor = conn.cursor()
        # process_list = conn.execute('SELECT query_id, query FROM system.processes ORDER BY \'create_time\' DESC')
        # # process_list = cursor.fetchall()

        # query = clean_query_char(query)
        # for p in process_list:
        #     selected_query = clean_query_char(p[1])

        #     if query.startswith(selected_query):
        #         print(f"Killing query: {p[1]}")
        #         conn.execute(f'KILL QUERY WHERE query_id = \'{p[0]}\'')
        result = conn.execute("KILL QUERY WHERE user = 'default'")
        print(result)
        print("Connection closed")
        # sleep(1)
        # self.conn.disconnect_connection()
        conn.disconnect_connection()

    def interrupt_connection_safe(self, query:str):
        timeout_occurred.set()
        self.conn.disconnect_connection()
        print("Connection closed")
        

    def query(self, sql_query:str, filename:str, timeout_duration=EXECUTE_TIMEOUT+2):

        print(f"Filename: {filename}")
        # print(f"SQL: {sql_query}")


        # check the 'format' keyword in the query
        if 'format' in sql_query.lower():
            print("FormatNotSupportError: Format keyword is not supported")
            return (False, ["FormatNotSupportError", "Format keyword is not supported"])



        combined_result = None
        timeout_occurred.clear()
        timer = threading.Timer(timeout_duration, self.interrupt_connection, args=[sql_query])
        timer_safe = threading.Timer(timeout_duration+2, self.interrupt_connection_safe, args=[sql_query])
        try:
            # print(query)
            timer.start()
            timer_safe.start()
            result = self.conn.execute(sql_query)
            # self.conn.commit()
            # keyword include in query
            # if any(keyword in query.lower() for keyword in setup_query_keyword):
            # timer.join()
            if timeout_occurred.is_set():
                raise TimeoutError("Timeout occurred")


            combined_result = (True, result)
            

            if ECHO_SUCC:
                print("Success\n")

        except Exception as e:
            # if any(keyword in query.lower() for keyword in setup_query_keyword):
            if timeout_occurred.is_set():
                combined_result = (False, ["TimeoutError", f"{e}"])
                if ECHO_ERR:
                    print(f"Failed: TimeoutError\n")

            else:
                error_type = e.__class__.__name__  
                combined_result = (False, [error_type, f"{e}"])
                if ECHO_ERR:
                    print(f"Failed: {error_type}\n")

            
        finally:
            timer.cancel()
            timer_safe.cancel()
        
        return combined_result

    def close_connection(self):
        # Close the database connection
        # self.reset_mysql()
        if self.conn:
            self.conn.disconnect_connection()
    
        
    def connection(self, config:dict):
        self.conn = clickhouse_driver.Client(**config)
        self.conn.execute(f"SET max_execution_time={EXECUTE_TIMEOUT}")
        # self.cursor = self.conn.cursor()
        # self.conn.autocommit = True

        return self.conn