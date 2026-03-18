-- 数据库修改脚本
-- 演示对现有表结构的修改

USE student_management;

-- 为students表添加新字段
ALTER TABLE students ADD COLUMN gpa DECIMAL(3, 2) COMMENT '绩点' AFTER age;
ALTER TABLE students ADD COLUMN status ENUM('在读', '休学', '毕业', '退学') DEFAULT '在读' COMMENT '学生状态' AFTER gpa;

-- 为courses表添加新字段
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

-- 查询验证修改后的表结构
DESC students;
DESC courses;
DESC enrollments;

-- 查询修改后的数据
SELECT student_no, name, age, gpa, status FROM students;
SELECT course_code, course_name, credits, max_students, description FROM courses;
