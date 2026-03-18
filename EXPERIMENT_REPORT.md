# Git + MySQL 协作式数据库脚本管理 - 实验报告

**学生姓名：** [学生姓名]
**学号：** [学号]
**实验日期：** 2024年3月18日
**课程：** 数据库基础

---

## 一、实验目标

1. 体验 Git 版本管理的核心流程（克隆、提交、推送），理解其对文件的版本管控作用
2. 借助可视化工具执行 MySQL 脚本，完成数据库与数据表的创建及修改
3. 初步认知「Git 管理脚本、MySQL 管理数据」的协作逻辑

---

## 二、实验环境

- **操作系统：** macOS 13.0+
- **Git 版本：** 2.40+
- **MySQL 版本：** 8.0+
- **可视化工具：** MySQL Workbench / Navicat / DBeaver
- **代码仓库：** GitHub/Gitee

---

## 三、实验步骤

### 3.1 Git 版本管理流程

#### 步骤1：克隆仓库
```bash
git clone https://github.com/[username]/database-firstclass.git
cd database-firstclass
```

#### 步骤2：查看项目结构
```
sql/
├── init_database.sql          # 初始化脚本：创建数据库和学生表
├── add_courses_table.sql      # 扩展脚本：添加课程表和选课表
├── modify_tables.sql          # 修改脚本：为表添加新字段
└── query_examples.sql         # 查询脚本：演示各种查询操作
```

#### 步骤3：提交脚本到 Git

**第一次提交 - 初始化脚本：**
```bash
git add sql/init_database.sql
git commit -m "feat: 初始化学生管理系统数据库和学生表"
git push origin main
```

**第二次提交 - 添加课程表：**
```bash
git add sql/add_courses_table.sql
git commit -m "feat: 添加课程表和选课表，建立学生与课程的关联"
git push origin main
```

**第三次提交 - 修改表结构：**
```bash
git add sql/modify_tables.sql
git commit -m "feat: 为学生表和课程表添加新字段，完善数据模型"
git push origin main
```

**第四次提交 - 查询脚本：**
```bash
git add sql/query_examples.sql
git commit -m "docs: 添加数据库查询示例脚本"
git push origin main
```

#### 步骤4：查看提交历史
```bash
git log --oneline
```

**输出示例：**
```
abc1234 docs: 添加数据库查询示例脚本
def5678 feat: 为学生表和课程表添加新字段，完善数据模型
ghi9012 feat: 添加课程表和选课表，建立学生与课程的关联
jkl3456 feat: 初始化学生管理系统数据库和学生表
```

---

### 3.2 MySQL 脚本执行流程

#### 步骤1：连接 MySQL 数据库
在 MySQL Workbench 或其他可视化工具中：
- 创建新连接
- 输入主机名：localhost
- 输入用户名：root
- 输入密码：[你的密码]
- 点击连接

#### 步骤2：执行初始化脚本
1. 打开 `sql/init_database.sql` 文件
2. 执行脚本（Ctrl+Shift+Enter 或点击执行按钮）
3. 验证结果：
   - 数据库 `student_management` 已创建
   - 表 `students` 已创建
   - 5条示例数据已插入

**执行结果截图：**
```
Query OK, 1 row affected (0.05 sec)
Query OK, 0 rows affected (0.08 sec)
Query OK, 0 rows affected (0.12 sec)
5 rows in set (0.00 sec)
```

#### 步骤3：执行扩展脚本
1. 打开 `sql/add_courses_table.sql` 文件
2. 执行脚本
3. 验证结果：
   - 表 `courses` 已创建（5条课程数据）
   - 表 `enrollments` 已创建（8条选课记录）

#### 步骤4：执行修改脚本
1. 打开 `sql/modify_tables.sql` 文件
2. 执行脚本
3. 验证结果：
   - `students` 表新增 `gpa` 和 `status` 字段
   - `courses` 表新增 `max_students` 和 `description` 字段
   - 数据已成功更新

#### 步骤5：执行查询脚本
1. 打开 `sql/query_examples.sql` 文件
2. 执行脚本
3. 查看各种查询结果：
   - 学生基本信息
   - 按专业分类统计
   - 学生选课情况
   - 成绩统计等

---

## 四、实验结果

### 4.1 数据库结构

**学生表 (students)：**
| 字段 | 类型 | 说明 |
|------|------|------|
| id | INT | 学生ID（主键） |
| student_no | VARCHAR(20) | 学号（唯一） |
| name | VARCHAR(50) | 姓名 |
| gender | ENUM | 性别 |
| age | INT | 年龄 |
| gpa | DECIMAL(3,2) | 绩点 |
| status | ENUM | 学生状态 |
| major | VARCHAR(100) | 专业 |
| email | VARCHAR(100) | 邮箱 |
| phone | VARCHAR(20) | 电话 |
| enrollment_date | DATE | 入学日期 |

**课程表 (courses)：**
| 字段 | 类型 | 说明 |
|------|------|------|
| id | INT | 课程ID（主键） |
| course_code | VARCHAR(20) | 课程代码（唯一） |
| course_name | VARCHAR(100) | 课程名称 |
| credits | INT | 学分 |
| instructor | VARCHAR(50) | 授课教师 |
| semester | VARCHAR(20) | 学期 |
| max_students | INT | 最大选课人数 |
| description | TEXT | 课程描述 |

**选课表 (enrollments)：**
| 字段 | 类型 | 说明 |
|------|------|------|
| id | INT | 选课ID（主键） |
| student_id | INT | 学生ID（外键） |
| course_id | INT | 课程ID（外键） |
| grade | DECIMAL(5,2) | 成绩 |

### 4.2 关键查询结果

**查询1：学生选课统计**
```
学生总数：5
平均年龄：20.4
最小年龄：19
最大年龄：22
```

**查询2：按专业统计**
```
计算机科学与技术：1人
软件工程：1人
数据科学与大数据技术：1人
人工智能：1人
网络工程：1人
```

**查询3：学生选课情况**
```
张三 选修了 数据结构 (85.5分)
张三 选修了 算法设计 (88.0分)
李四 选修了 数据结构 (92.0分)
...
```

---

## 五、基础问题回答

### 问题1：Git 版本管理对数据库脚本的作用是什么？

**答：**

Git 版本管理对数据库脚本的作用主要体现在以下几个方面：

1. **版本追踪**：每次提交都记录了脚本的变化历史，可以清楚地看到数据库结构的演变过程。例如，从初始化脚本到添加课程表，再到修改表结构，每一步都有明确的提交记录。

2. **协作管理**：在团队开发中，多个开发者可以同时修改不同的脚本文件，Git 能够自动合并这些更改（如果没有冲突），避免覆盖他人的工作。

3. **回滚能力**：如果某个脚本修改导致问题，可以通过 `git revert` 或 `git reset` 快速回到之前的版本，降低风险。

4. **代码审查**：通过 Pull Request 机制，团队成员可以在脚本合并前进行审查，确保脚本质量和正确性。

5. **文档记录**：提交信息（commit message）作为脚本变更的文档，清晰地说明了每次修改的目的和内容。

在本实验中，我们通过四次提交分别完成了数据库初始化、表扩展、结构修改和查询示例，这样的版本管理方式使得整个数据库开发过程清晰可追踪。

---

### 问题2：「Git 管理脚本、MySQL 管理数据」的协作逻辑是什么？

**答：**

这个协作逻辑体现了数据库开发中的职责分离原则：

1. **Git 的职责 - 管理脚本（结构）**：
   - Git 版本控制系统负责管理 SQL 脚本文件
   - 记录数据库结构的定义和变化（CREATE、ALTER 等 DDL 语句）
   - 保存数据库初始化和升级的完整历史
   - 支持团队协作和代码审查

2. **MySQL 的职责 - 管理数据（内容）**：
   - MySQL 数据库引擎负责实际存储和管理数据
   - 执行 SQL 脚本，将结构定义转化为实际的表和索引
   - 管理数据的增删改查（DML 操作）
   - 保证数据的一致性、完整性和安全性

3. **协作流程**：
   ```
   开发者编写 SQL 脚本 → Git 版本控制 → 推送到仓库 →
   其他开发者拉取脚本 → 在 MySQL 中执行脚本 → 数据库结构同步
   ```

4. **实际应用场景**：
   - 在本实验中，我们先在 Git 中管理了四个 SQL 脚本文件
   - 然后在 MySQL 中依次执行这些脚本
   - 最终实现了从简单的学生表到完整的学生管理系统的演进
   - 这样做的好处是：脚本可以版本控制、可以审查、可以回滚，而数据则安全地存储在数据库中

5. **优势**：
   - **可重复性**：任何人都可以通过执行相同的脚本快速重建相同的数据库结构
   - **可追踪性**：数据库结构的每一次变化都有记录
   - **可扩展性**：新的开发者可以通过查看脚本历史快速了解系统演进
   - **安全性**：脚本和数据分离，降低了误操作的风险

---

## 六、实验总结

通过本次实验，我们成功地：

1. ✅ 体验了 Git 的完整工作流程（克隆、提交、推送）
2. ✅ 使用 MySQL 可视化工具执行了多个 SQL 脚本
3. ✅ 完成了从数据库初始化到结构修改的全过程
4. ✅ 理解了「Git 管理脚本、MySQL 管理数据」的协作模式

这个实验为我们后续的数据库开发和团队协作奠定了基础。在实际项目中，这种模式能够确保数据库结构的版本控制和团队的高效协作。

---

## 七、附录

### 常用 Git 命令速查表

| 命令 | 说明 |
|------|------|
| `git clone <url>` | 克隆远程仓库 |
| `git add <file>` | 暂存文件 |
| `git commit -m "message"` | 提交更改 |
| `git push origin main` | 推送到远程仓库 |
| `git pull origin main` | 拉取远程更新 |
| `git log --oneline` | 查看提交历史 |
| `git status` | 查看工作区状态 |
| `git diff` | 查看文件差异 |

### 常用 MySQL 命令速查表

| 命令 | 说明 |
|------|------|
| `SHOW DATABASES;` | 显示所有数据库 |
| `USE database_name;` | 选择数据库 |
| `SHOW TABLES;` | 显示所有表 |
| `DESC table_name;` | 查看表结构 |
| `SELECT * FROM table_name;` | 查询表数据 |
| `SOURCE script.sql;` | 执行 SQL 脚本 |

---

**实验完成日期：** 2024年3月18日
**指导教师签名：** ________________
**学生签名：** ________________
