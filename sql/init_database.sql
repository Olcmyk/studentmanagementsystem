-- 学生信息管理系统数据库初始化脚本

-- 创建数据库
CREATE DATABASE IF NOT EXISTS student_management
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- 使用数据库
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

-- 插入示例数据
INSERT INTO students (student_no, name, gender, age, major, email, phone, enrollment_date) VALUES
('2024001', '张三', '男', 20, '计算机科学与技术', 'zhangsan@example.com', '13800138001', '2024-09-01'),
('2024002', '李四', '女', 19, '软件工程', 'lisi@example.com', '13800138002', '2024-09-01'),
('2024003', '王五', '男', 21, '数据科学与大数据技术', 'wangwu@example.com', '13800138003', '2024-09-01'),
('2024004', '赵六', '女', 20, '人工智能', 'zhaoliu@example.com', '13800138004', '2024-09-01'),
('2024005', '钱七', '男', 22, '网络工程', 'qianqi@example.com', '13800138005', '2024-09-01');

-- 查询验证
SELECT * FROM students;
