-- 添加课程表脚本
-- 此脚本演示数据库的修改和扩展

USE student_management;

-- 创建课程表
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

-- 创建选课表（学生与课程的关联表）
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

-- 查询验证
SELECT * FROM courses;
SELECT * FROM enrollments;
