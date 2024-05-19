import threading
import psycopg2
from .DBMSAdapter import DBMSAdapter
from utils import print_prevent_stopping


config = {
    'host': 'localhost',
    'port': 5432,
    'user': 'tester',
    'password': '123456',
    'database': 'test_db'
}

config_root = {
    'host': 'localhost',
    'port': 5432,
    'user': 'larryzhang',
    'password': '123456',
    'database': 'postgres'
}



class PostgresqlAdapter(DBMSAdapter):

    def __init__(self):
        PostgresqlAdapter.init_dbms()
        self.conn = psycopg2.connect(**config)
        self.conn.autocommit = True


    def interrupt_connection(self, query:str):
        print("Interrupting connection")
        conn = psycopg2.connect(**config_root)
        pid = self.conn.get_backend_pid()
        cur = conn.cursor()
        cur.execute(f"SELECT pg_cancel_backend({pid})")

        raise TimeoutError(f"Query timed out: '{query}'")


    def query(self, sql_query: str, filename: str, timeout_duration:int = 10):
        # Execute the SQL query
        combined_result = None
        timer = threading.Timer(timeout_duration, self.interrupt_connection, args=[sql_query])
        try:
            with self.conn.cursor() as cur:
                timer.start()

                print_prevent_stopping(f"Filename: {filename}")
                print_prevent_stopping(f"SQL: {sql_query}")

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
            error_type = e.__class__.__name__  
            combined_result = (False, [error_type, str(e)])
            print_prevent_stopping(f"Error : {error_type}: {e}")
            print("-"*50)

        # finally:
        #     timer.cancel()

        return combined_result
    
    def close_connection(self):
        self.conn.close()

        conn = psycopg2.connect(**config_root)
        cur = conn.cursor()
        cur.execute("""SELECT pg_terminate_backend(pg_stat_activity.pid)
                    FROM pg_stat_activity
                    WHERE pg_stat_activity.datname = 'test_db'""")
        cur.execute("COMMIT;")
        cur.execute("DROP DATABASE IF EXISTS test_db")
        cur.execute("COMMIT;")
        conn.close()

    @staticmethod
    def init_dbms():
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
        cur.execute("GRANT ALL ON DATABASE test_db TO tester")
        cur.execute("COMMIT;")
        cur.execute("ALTER DATABASE test_db OWNER TO tester;")
        cur.execute("COMMIT;")
        cur.execute("GRANT ALL ON SCHEMA public TO tester;")
        cur.execute("COMMIT;")
        
        conn.close()
        print("Postgresql initialized")