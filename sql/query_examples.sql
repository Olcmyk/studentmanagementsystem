-- 数据库查询脚本
-- 演示各种查询操作

USE student_management;

-- 1. 基础查询：查看所有学生信息
SELECT '=== 所有学生信息 ===' AS query_type;
SELECT student_no, name, gender, age, major FROM students;

-- 2. 条件查询：查询计算机科学与技术专业的学生
SELECT '=== 计算机科学与技术专业学生 ===' AS query_type;
SELECT student_no, name, major, email FROM students WHERE major = '计算机科学与技术';

-- 3. 排序查询：按年龄排序
SELECT '=== 按年龄排序的学生 ===' AS query_type;
SELECT student_no, name, age FROM students ORDER BY age DESC;

-- 4. 聚合查询：统计学生数量和平均年龄
SELECT '=== 学生统计信息 ===' AS query_type;
SELECT COUNT(*) AS 学生总数, AVG(age) AS 平均年龄, MIN(age) AS 最小年龄, MAX(age) AS 最大年龄 FROM students;

-- 5. 分组查询：按专业统计学生数量
SELECT '=== 按专业统计学生数量 ===' AS query_type;
SELECT major, COUNT(*) AS 学生数 FROM students GROUP BY major;

-- 6. 连接查询：查询学生选课情况
SELECT '=== 学生选课情况 ===' AS query_type;
SELECT s.student_no, s.name, c.course_name, e.grade
FROM students s
JOIN enrollments e ON s.id = e.student_id
JOIN courses c ON e.course_id = c.id
ORDER BY s.student_no;

-- 7. 子查询：查询选课数最多的学生
SELECT '=== 选课数最多的学生 ===' AS query_type;
SELECT s.student_no, s.name, COUNT(e.id) AS 选课数
FROM students s
LEFT JOIN enrollments e ON s.id = e.student_id
GROUP BY s.id
HAVING COUNT(e.id) = (
    SELECT MAX(course_count) FROM (
        SELECT COUNT(*) AS course_count FROM enrollments GROUP BY student_id
    ) AS temp
);

-- 8. 统计每门课程的选课人数
SELECT '=== 每门课程的选课人数 ===' AS query_type;
SELECT c.course_code, c.course_name, COUNT(e.id) AS 选课人数
FROM courses c
LEFT JOIN enrollments e ON c.id = e.course_id
GROUP BY c.id;

-- 9. 查询成绩在80分以上的选课记录
SELECT '=== 成绩在80分以上的选课记录 ===' AS query_type;
SELECT s.name, c.course_name, e.grade
FROM enrollments e
JOIN students s ON e.student_id = s.id
JOIN courses c ON e.course_id = c.id
WHERE e.grade >= 80
ORDER BY e.grade DESC;
