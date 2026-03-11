"""学生信息管理系统 - 程序入口"""

import tkinter as tk
from tkinter import messagebox
from database.connection import test_connection
from gui.main_window import MainWindow


def main():
    """主函数"""
    # 测试数据库连接
    success, message = test_connection()
    if not success:
        root = tk.Tk()
        root.withdraw()
        messagebox.showerror("数据库连接失败",
                           f"{message}\n\n请确保:\n1. MySQL 服务已启动\n2. 端口为 3307\n3. 已创建 student_management 数据库")
        return

    # 启动主窗口
    root = tk.Tk()
    app = MainWindow(root)
    root.mainloop()


if __name__ == "__main__":
    main()
