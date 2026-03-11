# 学生信息管理系统

基于 MySQL 和 Python tkinter 的学生信息管理系统，实现学生数据的增删改查功能。

## 功能特性

- 查看所有学生信息
- 添加新学生记录
- 修改学生信息
- 删除学生记录
- 按姓名或学号搜索学生
- 简洁直观的图形界面

## 技术栈

- Python 3.x
- MySQL 8.x
- tkinter (Python 自带 GUI 库)
- mysql-connector-python

## 数据库设计

**数据库名称:** `student_management`

**表结构:**
- id: 学生ID (主键，自增)
- student_no: 学号 (唯一)
- name: 姓名
- gender: 性别
- age: 年龄
- major: 专业
- email: 邮箱
- phone: 电话
- enrollment_date: 入学日期
- created_at: 创建时间
- updated_at: 更新时间

## 安装步骤

### 1. 创建虚拟环境（如果还没有）

```bash
python3 -m venv venv
```

### 2. 激活虚拟环境并安装依赖

```bash
source venv/bin/activate
pip install -r requirements.txt
```

### 3. 配置 MySQL

确保 MySQL 服务运行在端口 3306，使用 root 用户（无密码）。

### 4. 初始化数据库

使用 MySQL 客户端执行初始化脚本:

```bash
/Users/Shared/DBngin/mysql/8.0.33/bin/mysql -u root --socket=/tmp/mysql_3306.sock < sql/init_database.sql
```

或者使用 MySQL Workbench 等工具导入 `sql/init_database.sql` 文件。

## 运行程序

```bash
source venv/bin/activate
python3 main.py
```

## 使用说明

### 主界面

- **新增学生**: 点击工具栏的"新增学生"按钮，填写学生信息后保存
- **修改学生**: 选中表格中的学生记录，点击"修改学生"按钮进行编辑
- **删除学生**: 选中表格中的学生记录，点击"删除学生"按钮并确认删除
- **搜索功能**: 在搜索框输入姓名或学号，点击"搜索"按钮
- **刷新数据**: 点击"刷新"按钮重新加载所有数据

### 添加/修改学生

表单字段说明:
- 学号: 必填，唯一标识
- 姓名: 必填
- 性别: 下拉选择（男/女/其他）
- 年龄: 必填，数字
- 专业: 选填
- 邮箱: 选填
- 电话: 选填
- 入学日期: 格式 YYYY-MM-DD

## 项目结构

```
firstclass/
├── config/
│   ├── __init__.py
│   └── database.py          # 数据库配置
├── database/
│   ├── __init__.py
│   ├── connection.py        # 数据库连接管理
│   └── operations.py        # CRUD 操作
├── gui/
│   ├── __init__.py
│   ├── main_window.py       # 主窗口
│   └── dialogs.py           # 对话框
├── sql/
│   └── init_database.sql    # 数据库初始化脚本
├── main.py                  # 程序入口
├── requirements.txt         # 依赖包
└── README.md               # 项目说明
```

## 注意事项

1. 确保 MySQL 服务已启动并运行在端口 3307
2. 学号必须唯一，重复添加会提示错误
3. 年龄必须为有效数字
4. 入学日期格式必须为 YYYY-MM-DD

## 常见问题

**Q: 启动时提示"数据库连接失败"**

A: 请检查:
- MySQL 服务是否已启动
- 端口是否为 3307
- 是否已创建 student_management 数据库
- root 用户是否可以无密码登录

**Q: 如何修改数据库连接配置？**

A: 编辑 `config/database.py` 文件中的 `DATABASE_CONFIG` 字典。

## 开发环境

- Python 3.8+
- MySQL 8.0+
- macOS / Windows / Linux

## 许可证

本项目仅用于学习和演示目的。
