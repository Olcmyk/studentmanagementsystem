# 实验快速参考指南

## 📁 项目文件结构

```
sql/
├── init_database.sql          # 第1步：初始化数据库和学生表
├── add_courses_table.sql      # 第2步：添加课程表和选课表
├── modify_tables.sql          # 第3步：修改表结构，添加新字段
└── query_examples.sql         # 第4步：演示各种查询操作

EXPERIMENT_REPORT.md           # 完整的实验报告
QUICK_REFERENCE.md             # 本文件
```

## 🚀 快速开始

### 1. 在 MySQL 中执行脚本（按顺序）

```bash
# 方式1：使用 MySQL 命令行
mysql -u root -p < sql/init_database.sql
mysql -u root -p < sql/add_courses_table.sql
mysql -u root -p < sql/modify_tables.sql
mysql -u root -p < sql/query_examples.sql

# 方式2：使用 MySQL Workbench
# 1. 打开 MySQL Workbench
# 2. 连接到本地 MySQL 服务器
# 3. File → Open SQL Script → 选择脚本文件
# 4. 点击执行按钮（或 Ctrl+Shift+Enter）
```

### 2. 验证数据库创建成功

```sql
-- 在 MySQL 中执行
USE student_management;
SHOW TABLES;
SELECT COUNT(*) FROM students;
SELECT COUNT(*) FROM courses;
SELECT COUNT(*) FROM enrollments;
```

## 📊 数据库概览

| 表名 | 记录数 | 说明 |
|------|--------|------|
| students | 5 | 学生信息表 |
| courses | 5 | 课程信息表 |
| enrollments | 8 | 学生选课表 |

## 🔍 常用查询

```sql
-- 查看所有学生
SELECT * FROM students;

-- 查看所有课程
SELECT * FROM courses;

-- 查看学生选课情况
SELECT s.name, c.course_name, e.grade
FROM students s
JOIN enrollments e ON s.id = e.student_id
JOIN courses c ON e.course_id = c.id;

-- 统计每个学生的选课数
SELECT s.name, COUNT(e.id) AS 选课数
FROM students s
LEFT JOIN enrollments e ON s.id = e.student_id
GROUP BY s.id;
```

## 📝 Git 操作记录

```bash
# 查看所有提交
git log --oneline

# 查看特定提交的详细信息
git show 74718e7

# 查看文件变化
git diff HEAD~1 sql/add_courses_table.sql
```

## ✅ 实验检查清单

- [x] 创建了 4 个 SQL 脚本文件
- [x] 脚本包含 DDL（CREATE、ALTER）和 DML（INSERT、UPDATE）操作
- [x] 脚本包含查询示例
- [x] 所有文件已提交到 Git
- [x] 提交已推送到远程仓库
- [x] 完成了详细的实验报告
- [x] 报告包含了 2 个基础问题的回答

## 🎯 实验成果

✨ **完成的工作：**
1. 设计了完整的学生管理系统数据库
2. 创建了 4 个 SQL 脚本，演示了数据库的创建、修改和查询
3. 通过 Git 进行了版本管理和提交
4. 编写了详细的实验报告，包含步骤说明和理论分析

📚 **学到的知识：**
- Git 的基本工作流程（add、commit、push）
- MySQL 数据库的创建和管理
- SQL 脚本的编写和执行
- 数据库设计的基本原则（表设计、关系、索引）
- 团队协作中脚本管理的最佳实践

## 📞 常见问题

**Q: 如何重新执行脚本？**
A: 先删除数据库，再执行初始化脚本：
```sql
DROP DATABASE IF EXISTS student_management;
-- 然后执行 init_database.sql
```

**Q: 如何查看表的结构？**
A: 使用 DESC 命令：
```sql
DESC students;
DESC courses;
DESC enrollments;
```

**Q: 如何导出数据？**
A: 使用 MySQL 导出功能或命令：
```bash
mysqldump -u root -p student_management > backup.sql
```

---

**实验完成时间：** 2024-03-18
**Git 仓库：** https://github.com/Olcmyk/studentmanagementsystem
