"""主窗口模块"""

import tkinter as tk
from tkinter import ttk, messagebox
from database import operations
from gui.dialogs import InsertDialog, UpdateDialog


class MainWindow:
    """主窗口类"""

    def __init__(self, root):
        self.root = root
        self.root.title("学生信息管理系统")
        self.root.geometry("1000x600")

        self.create_widgets()
        self.load_data()

    def create_widgets(self):
        """创建界面组件"""
        # 工具栏
        toolbar = ttk.Frame(self.root)
        toolbar.pack(side=tk.TOP, fill=tk.X, padx=5, pady=5)

        ttk.Button(toolbar, text="新增学生", command=self.add_student).pack(side=tk.LEFT, padx=2)
        ttk.Button(toolbar, text="修改学生", command=self.update_student).pack(side=tk.LEFT, padx=2)
        ttk.Button(toolbar, text="删除学生", command=self.delete_student).pack(side=tk.LEFT, padx=2)
        ttk.Button(toolbar, text="刷新", command=self.load_data).pack(side=tk.LEFT, padx=2)

        ttk.Separator(toolbar, orient=tk.VERTICAL).pack(side=tk.LEFT, fill=tk.Y, padx=10)

        ttk.Label(toolbar, text="搜索:").pack(side=tk.LEFT, padx=5)
        self.search_var = tk.StringVar()
        search_entry = ttk.Entry(toolbar, textvariable=self.search_var, width=20)
        search_entry.pack(side=tk.LEFT, padx=2)
        ttk.Button(toolbar, text="搜索", command=self.search_students).pack(side=tk.LEFT, padx=2)

        # 数据表格
        table_frame = ttk.Frame(self.root)
        table_frame.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)

        # 滚动条
        scrollbar_y = ttk.Scrollbar(table_frame, orient=tk.VERTICAL)
        scrollbar_y.pack(side=tk.RIGHT, fill=tk.Y)

        scrollbar_x = ttk.Scrollbar(table_frame, orient=tk.HORIZONTAL)
        scrollbar_x.pack(side=tk.BOTTOM, fill=tk.X)

        # Treeview
        columns = ("ID", "学号", "姓名", "性别", "年龄", "专业", "邮箱", "电话", "入学日期")
        self.tree = ttk.Treeview(table_frame, columns=columns, show="headings",
                                 yscrollcommand=scrollbar_y.set,
                                 xscrollcommand=scrollbar_x.set)

        scrollbar_y.config(command=self.tree.yview)
        scrollbar_x.config(command=self.tree.xview)

        # 设置列
        widths = [50, 100, 80, 60, 60, 120, 150, 100, 100]
        for col, width in zip(columns, widths):
            self.tree.heading(col, text=col)
            self.tree.column(col, width=width, anchor=tk.CENTER)

        self.tree.pack(fill=tk.BOTH, expand=True)

        # 状态栏
        self.status_bar = ttk.Label(self.root, text="就绪", relief=tk.SUNKEN, anchor=tk.W)
        self.status_bar.pack(side=tk.BOTTOM, fill=tk.X)

    def load_data(self):
        """加载数据"""
        # 清空表格
        for item in self.tree.get_children():
            self.tree.delete(item)

        # 查询数据
        students, error = operations.get_all_students()
        if error:
            messagebox.showerror("错误", error)
            self.status_bar.config(text=f"错误: {error}")
            return

        # 填充数据
        for student in students:
            self.tree.insert('', 'end', values=student)

        self.status_bar.config(text=f"共 {len(students)} 条记录")

    def add_student(self):
        """添加学生"""
        dialog = InsertDialog(self.root)
        self.root.wait_window(dialog)

        if dialog.result:
            success, message = operations.insert_student(dialog.result)
            if success:
                messagebox.showinfo("成功", message)
                self.load_data()
            else:
                messagebox.showerror("错误", message)

    def update_student(self):
        """修改学生"""
        selection = self.tree.selection()
        if not selection:
            messagebox.showwarning("提示", "请先选择要修改的学生")
            return

        item = self.tree.item(selection[0])
        student_data = item['values']

        dialog = UpdateDialog(self.root, student_data)
        self.root.wait_window(dialog)

        if dialog.result:
            student_id = student_data[0]
            success, message = operations.update_student(student_id, dialog.result)
            if success:
                messagebox.showinfo("成功", message)
                self.load_data()
            else:
                messagebox.showerror("错误", message)

    def delete_student(self):
        """删除学生"""
        selection = self.tree.selection()
        if not selection:
            messagebox.showwarning("提示", "请先选择要删除的学生")
            return

        item = self.tree.item(selection[0])
        student_data = item['values']
        student_name = student_data[2]

        if messagebox.askyesno("确认", f"确定要删除学生 {student_name} 吗？"):
            student_id = student_data[0]
            success, message = operations.delete_student(student_id)
            if success:
                messagebox.showinfo("成功", message)
                self.load_data()
            else:
                messagebox.showerror("错误", message)

    def search_students(self):
        """搜索学生"""
        keyword = self.search_var.get().strip()
        if not keyword:
            self.load_data()
            return

        # 清空表格
        for item in self.tree.get_children():
            self.tree.delete(item)

        # 搜索
        students, error = operations.search_students(keyword)
        if error:
            messagebox.showerror("错误", error)
            return

        # 填充结果
        for student in students:
            self.tree.insert('', 'end', values=student)

        self.status_bar.config(text=f"找到 {len(students)} 条记录")
