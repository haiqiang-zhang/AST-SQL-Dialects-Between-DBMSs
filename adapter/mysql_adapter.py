import os
import sqlite3
from time import sleep
from typing import List
import threading
import mysql.connector
from mysql.connector.errors import DatabaseError


ECHO = False

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

setup_query_keyword = [
    # "create table",
    # "insert into",
    # "drop table"
]

class MYSQL:

    def kill_mysql(self):
        # kill mysql process
        os.system("ps aux | grep mysqld | grep -v grep | awk '{print $2}' | xargs kill -9")
        
        

    def reset_mysql(self):
        timer = threading.Timer(5, self.interrupt_connection_root)
        try:
            timer.start()
            conn = mysql.connector.connect(**config_root)
            cursor = conn.cursor()

            # 获取所有数据库名
            cursor.execute("SHOW DATABASES")
            databases = cursor.fetchall()

            print(f"after show databases: {databases}")

            # 循环遍历所有数据库，并逐个清空
            for db in databases:
                db_name = db[0]
                if db_name not in ['information_schema', 'mysql', 'performance_schema', 'sys']:
                    cursor.execute(f"DROP DATABASE {db_name}")
                    conn.commit()
                    print(f"Database {db_name} dropped successfully.")
            

            # # 重新创建系统数据库
            # cursor.execute("CREATE DATABASE IF NOT EXISTS mysql")
            # cursor.execute("CREATE DATABASE IF NOT EXISTS performance_schema")
            # cursor.execute("CREATE DATABASE IF NOT EXISTS sys")

            # 重置角色和权限
            cursor.execute("SELECT user, host FROM mysql.user")
            users = cursor.fetchall()

            # 循环遍历所有用户，并逐个删除除了默认用户之外的用户
            for user, host in users:
                if user not in ['tester', 'root', 'mysql.session', 'mysql.sys', 'mysql.infoschema'] and host == 'localhost':
                    cursor.execute(f"DROP USER '{user}'@'localhost'")
                    conn.commit()
                    print(f"User {user} dropped successfully.")
            cursor.execute("FLUSH PRIVILEGES")
            conn.commit()
            print("MySQL reset successfully.")

            conn.close()

        except DatabaseError as e:
            sleep(5)
            self.reset_mysql()

        except Exception as e:
            print("An error occurred:", e)
            self.reset_mysql()
        finally:
            timer.cancel()
            
    def __init__(self):
    
        # Connect to the SQLite database
        self.conn = mysql.connector.connect(**config)
        # Create a cursor object to execute SQL queries
        self.cursor = self.conn.cursor()

        # reset mysql
        #self.reset_mysql()

        # Create a new database and use it
        self.cursor.execute("DROP DATABASE IF EXISTS test_db")
        self.cursor.execute("CREATE DATABASE test_db")
        self.cursor.execute("USE test_db")
        
        
    
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
        raise TimeoutError(f"Query timed out: '{query}'")

    def query(self, sql_query:str, filename:str, timeout_duration=10):
        # Execute the SQL query
        combined_result = None
        timer = threading.Timer(timeout_duration, self.interrupt_connection, args=[sql_query])
        print(f"Filename: {filename}")
        print(f"SQL: {sql_query}")
       
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
            print("Success")
            print("=================================")

        except TimeoutError as e:
            self.cursor.execute("KILL QUERY %s", (self.cursor.connection_id,))
            self.conn.rollback()

        except Exception as e:
            # if any(keyword in query.lower() for keyword in setup_query_keyword):
            combined_result = (False, ["Error executing test case '{filename}': {e}"])
            print(f"Error executing test case '{filename}': {e}")
            print("=================================")
        finally:
            timer.cancel()
        
        return combined_result

    def close_connection(self):
        # Close the database connection
        # self.reset_mysql()
        self.conn.close() 
    
        