"""对话框模块 - 用于添加和修改学生信息"""

import tkinter as tk
from tkinter import ttk, messagebox
from datetime import date


class InsertDialog(tk.Toplevel):
    """添加学生对话框"""

    def __init__(self, parent):
        super().__init__(parent)
        self.title("添加学生")
        self.result = None

        self.create_widgets()
        self.center_window()

        self.transient(parent)
        self.grab_set()

    def create_widgets(self):
        """创建表单控件"""
        frame = ttk.Frame(self, padding="10")
        frame.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))

        # 学号
        ttk.Label(frame, text="学号:").grid(row=0, column=0, sticky=tk.W, pady=5)
        self.student_no_var = tk.StringVar()
        ttk.Entry(frame, textvariable=self.student_no_var, width=30).grid(row=0, column=1, pady=5)

        # 姓名
        ttk.Label(frame, text="姓名:").grid(row=1, column=0, sticky=tk.W, pady=5)
        self.name_var = tk.StringVar()
        ttk.Entry(frame, textvariable=self.name_var, width=30).grid(row=1, column=1, pady=5)

        # 性别
        ttk.Label(frame, text="性别:").grid(row=2, column=0, sticky=tk.W, pady=5)
        self.gender_var = tk.StringVar(value="男")
        ttk.Combobox(frame, textvariable=self.gender_var, values=["男", "女", "其他"],
                     state="readonly", width=28).grid(row=2, column=1, pady=5)

        # 年龄
        ttk.Label(frame, text="年龄:").grid(row=3, column=0, sticky=tk.W, pady=5)
        self.age_var = tk.StringVar()
        ttk.Entry(frame, textvariable=self.age_var, width=30).grid(row=3, column=1, pady=5)

        # 专业
        ttk.Label(frame, text="专业:").grid(row=4, column=0, sticky=tk.W, pady=5)
        self.major_var = tk.StringVar()
        ttk.Entry(frame, textvariable=self.major_var, width=30).grid(row=4, column=1, pady=5)

        # 邮箱
        ttk.Label(frame, text="邮箱:").grid(row=5, column=0, sticky=tk.W, pady=5)
        self.email_var = tk.StringVar()
        ttk.Entry(frame, textvariable=self.email_var, width=30).grid(row=5, column=1, pady=5)

        # 电话
        ttk.Label(frame, text="电话:").grid(row=6, column=0, sticky=tk.W, pady=5)
        self.phone_var = tk.StringVar()
        ttk.Entry(frame, textvariable=self.phone_var, width=30).grid(row=6, column=1, pady=5)

        # 入学日期
        ttk.Label(frame, text="入学日期:").grid(row=7, column=0, sticky=tk.W, pady=5)
        self.date_var = tk.StringVar(value=str(date.today()))
        ttk.Entry(frame, textvariable=self.date_var, width=30).grid(row=7, column=1, pady=5)
        ttk.Label(frame, text="(格式: YYYY-MM-DD)", font=("", 8)).grid(row=8, column=1, sticky=tk.W)

        # 按钮
        btn_frame = ttk.Frame(frame)
        btn_frame.grid(row=9, column=0, columnspan=2, pady=15)
        ttk.Button(btn_frame, text="确定", command=self.on_ok).pack(side=tk.LEFT, padx=5)
        ttk.Button(btn_frame, text="取消", command=self.on_cancel).pack(side=tk.LEFT, padx=5)

    def center_window(self):
        """窗口居中"""
        self.update_idletasks()
        width = self.winfo_width()
        height = self.winfo_height()
        x = (self.winfo_screenwidth() // 2) - (width // 2)
        y = (self.winfo_screenheight() // 2) - (height // 2)
        self.geometry(f'+{x}+{y}')

    def validate_input(self):
        """验证输入"""
        if not self.student_no_var.get().strip():
            messagebox.showerror("错误", "学号不能为空", parent=self)
            return False
        if not self.name_var.get().strip():
            messagebox.showerror("错误", "姓名不能为空", parent=self)
            return False
        try:
            age = int(self.age_var.get())
            if age < 0 or age > 150:
                raise ValueError
        except ValueError:
            messagebox.showerror("错误", "请输入有效的年龄", parent=self)
            return False
        return True

    def on_ok(self):
        """确定按钮"""
        if self.validate_input():
            self.result = {
                'student_no': self.student_no_var.get().strip(),
                'name': self.name_var.get().strip(),
                'gender': self.gender_var.get(),
                'age': int(self.age_var.get()),
                'major': self.major_var.get().strip(),
                'email': self.email_var.get().strip(),
                'phone': self.phone_var.get().strip(),
                'enrollment_date': self.date_var.get().strip()
            }
            self.destroy()

    def on_cancel(self):
        """取消按钮"""
        self.result = None
        self.destroy()


class UpdateDialog(InsertDialog):
    """修改学生对话框"""

    def __init__(self, parent, student_data):
        self.student_data = student_data
        super().__init__(parent)
        self.title("修改学生信息")
        self.load_data()

    def load_data(self):
        """加载现有数据"""
        self.student_no_var.set(self.student_data[1])
        self.name_var.set(self.student_data[2])
        self.gender_var.set(self.student_data[3])
        self.age_var.set(str(self.student_data[4]))
        self.major_var.set(self.student_data[5])
        self.email_var.set(self.student_data[6])
        self.phone_var.set(self.student_data[7])
        self.date_var.set(str(self.student_data[8]))
