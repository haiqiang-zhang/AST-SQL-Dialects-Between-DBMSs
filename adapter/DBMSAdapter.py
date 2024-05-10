import abc


class DBMSAdapter(metaclass=abc.ABCMeta):
    @staticmethod
    @abc.abstractmethod
    def init_dbms():
        pass

    @abc.abstractmethod
    def query(self, sql_query:str, filename:str, timeout_duration:int):
        pass

    @abc.abstractmethod
    def close_connection(self):
        pass

    