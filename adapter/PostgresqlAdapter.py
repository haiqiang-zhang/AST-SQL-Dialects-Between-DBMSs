import threading
import psycopg2
from .DBMSAdapter import DBMSAdapter
from utils import print_prevent_stopping

tester_role = "tester"

config_root = {
    'host': 'localhost',
    'port': 5432,
    'user': 'larryzhang',
    'password': '123456',
    'database': 'postgres'
}

config = {
    'host': 'localhost',
    'port': 5432,
    'user': tester_role,
    'password': '123456',
    'database': 'test_db'
}



class PostgresqlAdapter(DBMSAdapter):


    def __init__(self):
        self.init_each_test()
        self.conn = psycopg2.connect(**config)
        self.conn.autocommit = True
        self.timeout_occurred = threading.Event()


    def interrupt_connection(self, query:str):
        print("Interrupting connection")
        # set timeout_occurred
        self.timeout_occurred.set()
        conn = psycopg2.connect(**config_root)
        pid = self.conn.get_backend_pid()
        cur = conn.cursor()
        cur.execute(f"SELECT pg_cancel_backend({pid})")
        conn.close()
        print("Connection interrupted")




    def query(self, sql_query: str, filename: str, timeout_duration:int = 5):
        # Execute the SQL query
        print(f"DBMS: Postgresql")
        print_prevent_stopping(f"Filename: {filename}")
        print_prevent_stopping(f"SQL: {sql_query}")
        combined_result = None
        self.timeout_occurred.clear()
        timer = threading.Timer(timeout_duration, self.interrupt_connection, args=[sql_query])
        try:
            with self.conn.cursor() as cur:
                timer.start()

                

                cur.execute(sql_query)
                result = cur.fetchall()
                combined_result = (True, result)
                print_prevent_stopping("Success")

                

        except psycopg2.ProgrammingError as e:
            if "no results to fetch" in str(e):
                combined_result = (True, [])
            else:
                error_type = e.__class__.__name__  
                combined_result = (False, [error_type, str(e)])
                
                print_prevent_stopping(f"Error : {error_type}: {e}")
                print("-"*50)

        except Exception as e:
            if self.timeout_occurred.is_set():
                self.conn = psycopg2.connect(**config)
                combined_result = (False, ["TimeoutError", f"Query timed out"])
                print_prevent_stopping(f"Timeout occurred for query: {sql_query}, killing query...")
                print("-"*50)
            else:
                error_type = e.__class__.__name__  
                combined_result = (False, [error_type, str(e)])
                print_prevent_stopping(f"Error : {error_type}: {e}")
                print("-"*50)

        finally:
            timer.cancel()

        return combined_result
    
    def close_connection(self):
        self.conn.close()

    def init_each_test(self):
        conn = psycopg2.connect(**config_root)

        cur = conn.cursor()
        cur.execute("""SELECT pg_terminate_backend(pg_stat_activity.pid)
                    FROM pg_stat_activity
                    WHERE pg_stat_activity.datname = 'test_db'""")
        cur.execute("COMMIT;")
        cur.execute("DROP DATABASE IF EXISTS test_db")
        cur.execute("COMMIT;")
        cur.execute("CREATE DATABASE test_db")
        cur.execute("COMMIT;")
        cur.execute(f"GRANT ALL ON DATABASE test_db TO {tester_role}")
        cur.execute("COMMIT;")
        cur.execute(f"ALTER DATABASE test_db OWNER TO {tester_role};")
        cur.execute("COMMIT;")
        conn.close()

        print("Each test initialized")



    @staticmethod
    def init_dbms():
        conn = psycopg2.connect(**config_root)

        cur = conn.cursor()
        # delete the tester role owned database (search these databases)
        cur.execute(f"SELECT datname FROM pg_database WHERE datdba = (SELECT oid FROM pg_roles WHERE rolname = '{tester_role}');")
        try:
            databases = cur.fetchall()
            for database in databases:
                cur.execute(f"SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = '{database[0]}'")
                cur.execute("COMMIT;")
                cur.execute(f"DROP DATABASE IF EXISTS {database[0]}")
                cur.execute("COMMIT;")
        except psycopg2.ProgrammingError:
            print("No database owned by tester role")


        cur.execute(f"REVOKE ALL ON SCHEMA public FROM {tester_role};")
        
        # delete tester role if exists
        cur.execute(f"DROP ROLE IF EXISTS {tester_role};")
        cur.execute("COMMIT;")
        cur.execute(f"CREATE ROLE {tester_role} WITH LOGIN PASSWORD '123456';")
        cur.execute("COMMIT;")
        cur.execute(f"ALTER ROLE {tester_role} WITH CREATEDB;")
        cur.execute("COMMIT;")
        cur.execute(f"GRANT ALL ON SCHEMA public TO {tester_role};")
        cur.execute("COMMIT;")
        
        conn.close()
        print("Postgresql initialized")