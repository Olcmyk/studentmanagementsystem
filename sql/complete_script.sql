-- ============================================
-- Git + MySQL 协作式数据库脚本管理 - 完整脚本
-- ============================================
-- 执行此脚本将完整创建学生管理系统数据库

-- 第1部分：初始化数据库
-- ============================================
CREATE DATABASE IF NOT EXISTS student_management
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE student_management;

-- 创建学生表
CREATE TABLE IF NOT EXISTS students (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT '学生ID',
    student_no VARCHAR(20) NOT NULL UNIQUE COMMENT '学号',
    name VARCHAR(50) NOT NULL COMMENT '姓名',
    gender ENUM('男', '女', '其他') DEFAULT '男' COMMENT '性别',
    age INT COMMENT '年龄',
    major VARCHAR(100) COMMENT '专业',
    email VARCHAR(100) COMMENT '邮箱',
    phone VARCHAR(20) COMMENT '电话',
    enrollment_date DATE COMMENT '入学日期',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX idx_student_no (student_no),
    INDEX idx_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学生信息表';

-- 插入学生示例数据
INSERT INTO students (student_no, name, gender, age, major, email, phone, enrollment_date) VALUES
('2024001', '张三', '男', 20, '计算机科学与技术', 'zhangsan@example.com', '13800138001', '2024-09-01'),
('2024002', '李四', '女', 19, '软件工程', 'lisi@example.com', '13800138002', '2024-09-01'),
('2024003', '王五', '男', 21, '数据科学与大数据技术', 'wangwu@example.com', '13800138003', '2024-09-01'),
('2024004', '赵六', '女', 20, '人工智能', 'zhaoliu@example.com', '13800138004', '2024-09-01'),
('2024005', '钱七', '男', 22, '网络工程', 'qianqi@example.com', '13800138005', '2024-09-01');

-- 第2部分：添加课程表和选课表
-- ============================================
CREATE TABLE IF NOT EXISTS courses (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT '课程ID',
    course_code VARCHAR(20) NOT NULL UNIQUE COMMENT '课程代码',
    course_name VARCHAR(100) NOT NULL COMMENT '课程名称',
    credits INT COMMENT '学分',
    instructor VARCHAR(50) COMMENT '授课教师',
    semester VARCHAR(20) COMMENT '学期',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    INDEX idx_course_code (course_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='课程信息表';

CREATE TABLE IF NOT EXISTS enrollments (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT '选课ID',
    student_id INT NOT NULL COMMENT '学生ID',
    course_id INT NOT NULL COMMENT '课程ID',
    grade DECIMAL(5, 2) COMMENT '成绩',
    enrollment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '选课时间',
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
    UNIQUE KEY unique_enrollment (student_id, course_id),
    INDEX idx_student_id (student_id),
    INDEX idx_course_id (course_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学生选课表';

-- 插入课程示例数据
INSERT INTO courses (course_code, course_name, credits, instructor, semester) VALUES
('CS101', '数据结构', 3, '王教授', '2024-1'),
('CS102', '算法设计', 3, '李教授', '2024-1'),
('CS103', '数据库原理', 3, '张教授', '2024-1'),
('CS104', '操作系统', 4, '刘教授', '2024-2'),
('CS105', '计算机网络', 3, '陈教授', '2024-2');

-- 插入选课示例数据
INSERT INTO enrollments (student_id, course_id, grade) VALUES
(1, 1, 85.5),
(1, 2, 88.0),
(2, 1, 92.0),
(2, 3, 78.5),
(3, 2, 95.0),
(3, 4, 87.0),
(4, 3, 81.0),
(5, 5, 89.5);

-- 第3部分：修改表结构
-- ============================================
ALTER TABLE students ADD COLUMN gpa DECIMAL(3, 2) COMMENT '绩点' AFTER age;
ALTER TABLE students ADD COLUMN status ENUM('在读', '休学', '毕业', '退学') DEFAULT '在读' COMMENT '学生状态' AFTER gpa;

ALTER TABLE courses ADD COLUMN max_students INT DEFAULT 50 COMMENT '最大选课人数' AFTER semester;
ALTER TABLE courses ADD COLUMN description TEXT COMMENT '课程描述' AFTER max_students;

-- 更新学生数据
UPDATE students SET gpa = 3.5 WHERE student_no = '2024001';
UPDATE students SET gpa = 3.8 WHERE student_no = '2024002';
UPDATE students SET gpa = 3.9 WHERE student_no = '2024003';
UPDATE students SET gpa = 3.6 WHERE student_no = '2024004';
UPDATE students SET gpa = 3.7 WHERE student_no = '2024005';

-- 更新课程描述
UPDATE courses SET description = '学习基本数据结构如数组、链表、树等' WHERE course_code = 'CS101';
UPDATE courses SET description = '深入学习算法设计与分析方法' WHERE course_code = 'CS102';
UPDATE courses SET description = '数据库设计、SQL语言和事务管理' WHERE course_code = 'CS103';

-- 第4部分：验证和查询
-- ============================================
SELECT '========== 学生信息表 ==========' AS result;
SELECT * FROM students;

SELECT '========== 课程信息表 ==========' AS result;
SELECT * FROM courses;

SELECT '========== 选课信息表 ==========' AS result;
SELECT * FROM enrollments;

SELECT '========== 学生选课详情 ==========' AS result;
SELECT s.student_no, s.name, c.course_name, e.grade
FROM students s
JOIN enrollments e ON s.id = e.student_id
JOIN courses c ON e.course_id = c.id
ORDER BY s.student_no;

SELECT '========== 学生统计信息 ==========' AS result;
SELECT COUNT(*) AS 学生总数, AVG(age) AS 平均年龄, MIN(age) AS 最小年龄, MAX(age) AS 最大年龄 FROM students;

SELECT '========== 按专业统计 ==========' AS result;
SELECT major, COUNT(*) AS 学生数 FROM students GROUP BY major;

SELECT '========== 每门课程的选课人数 ==========' AS result;
SELECT c.course_code, c.course_name, COUNT(e.id) AS 选课人数
FROM courses c
LEFT JOIN enrollments e ON c.id = e.course_id
GROUP BY c.id;

SELECT '========== 成绩在80分以上的选课记录 ==========' AS result;
SELECT s.name, c.course_name, e.grade
FROM enrollments e
JOIN students s ON e.student_id = s.id
JOIN courses c ON e.course_id = c.id
WHERE e.grade >= 80
ORDER BY e.grade DESC;
