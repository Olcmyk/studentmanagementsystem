"""数据库连接管理模块"""

import mysql.connector
from mysql.connector import Error
from config.database import DATABASE_CONFIG


class DatabaseConnection:
    """数据库连接上下文管理器"""

    def __init__(self):
        self.connection = None
        self.cursor = None

    def __enter__(self):
        try:
            self.connection = mysql.connector.connect(**DATABASE_CONFIG)
            return self.connection
        except Error as e:
            raise Exception(f"数据库连接失败: {e}")

    def __exit__(self, exc_type, exc_val, exc_tb):
        if self.connection and self.connection.is_connected():
            self.connection.close()


def test_connection():
    """测试数据库连接"""
    try:
        with DatabaseConnection() as conn:
            cursor = conn.cursor()
            cursor.execute("SELECT VERSION()")
            version = cursor.fetchone()
            cursor.close()
            return True, f"连接成功! MySQL 版本: {version[0]}"
    except Exception as e:
        return False, str(e)
