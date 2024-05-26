import os
from time import sleep
from typing import List
import threading
import mysql.connector
from mysql.connector.errors import Error as DatabaseError
from .DBMSAdapter import DBMSAdapter

timeout_occurred = threading.Event()
ECHO_SUCC = True
ECHO_ERR = True

config = {
    'host': 'localhost',
    'user': 'tester',
    'password': '123456',
    'connection_timeout': 2 
}


config_root = {
    'host': 'localhost',
    'user': 'root',
    'password': '123456',
    'connection_timeout': 2 
}

class MySQLAdapter(DBMSAdapter):

    @staticmethod
    def init_dbms():

        try:
            command = ["rm -rf /opt/homebrew/var/mysql/", 
                    "mysqld --initialize-insecure",
                    "brew services restart mysql"]
            
            for cmd in command:
                response = os.system(cmd)
                if response != 0:
                    print(f"Error executing command: {cmd}")
                    return False
            
            sleep(2)


            conn = mysql.connector.connect(host='localhost', user='root')
            cursor = conn.cursor()
            cursor.execute("alter user 'root'@'localhost' identified by '123456';")
            cursor.execute("CREATE USER 'tester'@'localhost' IDENTIFIED BY '123456';")
            cursor.execute("CREATE DATABASE test_db")
            cursor.execute("GRANT ALL PRIVILEGES on test_db.* TO 'tester'@'localhost';")
            cursor.execute("GRANT CREATE, DROP, ALTER, CREATE TABLESPACE, PROCESS, BACKUP_ADMIN, FILE  on *.* TO 'tester'@'localhost';")
            cursor.execute("FLUSH PRIVILEGES")

            # cursor.execute("GRANT ALL PRIVILEGES on *.* TO 'root'@'localhost' WITH GRANT OPTION;")
            conn.commit()
            conn.close()

            # Grant required privileges to the tester user
            # conn = mysql.connector.connect(**config_root)
            # cursor = conn.cursor()
            # # cursor.execute("GRANT ALL PRIVILEGES on *.* TO 'tester'@'localhost';")
            # # cursor.execute("REVOKE ALL PRIVILEGES on information_schema.* FROM 'tester'@'localhost';")
            # # cursor.execute("REVOKE ALL PRIVILEGES on performance_schema.* FROM 'tester'@'localhost';")
            # # cursor.execute("REVOKE ALL PRIVILEGES on sys.* FROM 'tester'@'localhost';")
            # # cursor.execute("REVOKE ALL PRIVILEGES FROM 'tester'@'localhost';")
            # cursor.execute("FLUSH PRIVILEGES")
            # conn.commit()
            # conn.close()
        except Exception as e:
            MySQLAdapter.init_dbms()
            
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
        self.cursor.execute("DROP DATABASE IF EXISTS test_db")
        self.create_test_db()
        
    def create_test_db(self):
        try:
            self.cursor.execute("CREATE DATABASE test_db")
            self.cursor.execute("USE test_db")
            # self.conn.commit()
        except DatabaseError as e:
            self.cursor.execute("USE test_db")

    
    def run_setup(self, setup_query:List, filename:str):
        # Execute the SQL query
        for query in setup_query:
            # try:
            self.cursor.execute(query)
            # self.conn.commit()

            # except:
            #     print(f"[Setup Error] Error setup database in '{filename}': {e}")
            #     continue

    def interrupt_connection(self, query:str):
        timeout_occurred.set()
        print(f"Timeout occurred for query: {query}, killing query...")
        conn = mysql.connector.connect(**config_root)
        cursor = conn.cursor()
        cursor.execute("KILL QUERY %s", (self.conn.connection_id,))
        conn.commit()
        conn.close()

    def query(self, sql_query:str, filename:str, timeout_duration=10):
        print(f"DBMS: MySQL")
        print(f"Filename: {filename}")
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
                print("Success")

                


        except Exception as e:
            # if any(keyword in query.lower() for keyword in setup_query_keyword):
            if timeout_occurred.is_set():
                sleep(2)
                self.connection(config)
            error_type = e.__class__.__name__  
            combined_result = (False, [error_type, f"{e}"])
            if ECHO_ERR:
                print(f"Error: {e}")

            
        finally:
            timer.cancel()
            print()
        
        return combined_result

    def close_connection(self):
        # Close the database connection
        # self.reset_mysql()
        self.conn.close() 
    
        
    def connection(self, config:dict):
        try:
            self.conn = mysql.connector.connect(**config)
            self.cursor = self.conn.cursor()
            self.conn.autocommit = True
        except Exception as e:
            print(f"Error connecting to the database: {e}")
            self.init_dbms()
            self.conn = mysql.connector.connect(**config)
            self.cursor = self.conn.cursor()
            self.conn.autocommit = True
        return self.conn, self.cursor