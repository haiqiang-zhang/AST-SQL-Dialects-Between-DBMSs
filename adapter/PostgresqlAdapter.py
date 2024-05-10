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




    def query(self, sql_query: str, filename: str, timeout_duration:int = 10):
        # Execute the SQL query
        combined_result = None
        try:
            with self.conn.cursor() as cur:
                cur.execute(sql_query)
                result = cur.fetchall()
                self.conn.commit()
                combined_result = (True, result)
            # print(f"Filename: {filename}")
            # print(f"SQL: {sql_query}")
            # print("Success")
            # print("-"*50)
        except Exception as e:
            self.conn.rollback()
            combined_result = (False, [str(e)])

            print_prevent_stopping(f"Filename: {filename}")
            print_prevent_stopping(f"SQL: {sql_query}")
            print_prevent_stopping(f"Error executing test case '{filename}': {e}")
            print("-"*50)
        return combined_result
    
    def close_connection(self):
        self.conn.close()

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
        cur.execute("GRANT ALL PRIVILEGES ON DATABASE test_db TO tester")
        conn.commit()
        
        conn.close()
        print("Postgresql initialized")