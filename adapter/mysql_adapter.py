import os
import sqlite3
from typing import List
import threading
import mysql.connector


ECHO = False

config = {
    'host': 'localhost',
    'user': 'root',
    'password': '123456',
    # 'database': 'your_database',
}

setup_query_keyword = [
    # "create table",
    # "insert into",
    # "drop table"
]

class MYSQL:
    def reset_mysql(self):
        try:
            # 创建游标对象
            conn = mysql.connector.connect(**config)
            cursor = conn.cursor()

            # 获取所有数据库名
            cursor.execute("SHOW DATABASES")
            databases = cursor.fetchall()

            # 循环遍历所有数据库，并逐个清空
            for db in databases:
                db_name = db[0]
                if db_name not in ['information_schema', 'mysql', 'performance_schema', 'sys']:
                    cursor.execute(f"DROP DATABASE {db_name}")
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
                if user not in ['root', 'mysql.session', 'mysql.sys', 'mysql.infoschema'] and host == 'localhost':
                    cursor.execute(f"DROP USER '{user}'@'localhost'")
                    print(f"User {user} dropped successfully.")
            cursor.execute("FLUSH PRIVILEGES")

            conn.commit()
            print("MySQL reset successfully.")
        except Exception as e:
            print("An error occurred:", e)
            
    def __init__(self):
    
        # Connect to the SQLite database
        self.conn = mysql.connector.connect(**config)
        # Create a cursor object to execute SQL queries
        self.cursor = self.conn.cursor()
        
        # reset mysql
        self.reset_mysql()
    
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
            print(f"Error executing test case '{filename}': {e}")
            print("=================================")
        finally:
            timer.cancel()
        
        return combined_result

    def close_connection(self):
        # Close the database connection
        self.reset_mysql()
        self.conn.close()
    
        