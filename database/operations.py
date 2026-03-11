"""数据库 CRUD 操作模块"""

from database.connection import DatabaseConnection
from mysql.connector import Error


def get_all_students():
    """查询所有学生记录"""
    try:
        with DatabaseConnection() as conn:
            cursor = conn.cursor()
            cursor.execute("""
                SELECT id, student_no, name, gender, age, major,
                       email, phone, enrollment_date
                FROM students
                ORDER BY id
            """)
            students = cursor.fetchall()
            cursor.close()
            return students, None
    except Exception as e:
        return None, f"查询失败: {e}"


def insert_student(data):
    """插入新学生记录

    Args:
        data: 字典，包含学生信息
    """
    try:
        with DatabaseConnection() as conn:
            cursor = conn.cursor()
            cursor.execute("""
                INSERT INTO students
                (student_no, name, gender, age, major, email, phone, enrollment_date)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
            """, (
                data['student_no'],
                data['name'],
                data['gender'],
                data['age'],
                data['major'],
                data['email'],
                data['phone'],
                data['enrollment_date']
            ))
            conn.commit()
            cursor.close()
            return True, "添加成功"
    except Error as e:
        if e.errno == 1062:  # 重复键错误
            return False, "学号已存在"
        return False, f"添加失败: {e}"
    except Exception as e:
        return False, f"添加失败: {e}"


def update_student(student_id, data):
    """更新学生记录

    Args:
        student_id: 学生ID
        data: 字典，包含更新的学生信息
    """
    try:
        with DatabaseConnection() as conn:
            cursor = conn.cursor()
            cursor.execute("""
                UPDATE students
                SET student_no=%s, name=%s, gender=%s, age=%s,
                    major=%s, email=%s, phone=%s, enrollment_date=%s
                WHERE id=%s
            """, (
                data['student_no'],
                data['name'],
                data['gender'],
                data['age'],
                data['major'],
                data['email'],
                data['phone'],
                data['enrollment_date'],
                student_id
            ))
            conn.commit()
            cursor.close()
            return True, "修改成功"
    except Error as e:
        if e.errno == 1062:
            return False, "学号已存在"
        return False, f"修改失败: {e}"
    except Exception as e:
        return False, f"修改失败: {e}"


def delete_student(student_id):
    """删除学生记录"""
    try:
        with DatabaseConnection() as conn:
            cursor = conn.cursor()
            cursor.execute("DELETE FROM students WHERE id=%s", (student_id,))
            conn.commit()
            cursor.close()
            return True, "删除成功"
    except Exception as e:
        return False, f"删除失败: {e}"


def search_students(keyword):
    """搜索学生（按姓名或学号）"""
    try:
        with DatabaseConnection() as conn:
            cursor = conn.cursor()
            cursor.execute("""
                SELECT id, student_no, name, gender, age, major,
                       email, phone, enrollment_date
                FROM students
                WHERE name LIKE %s OR student_no LIKE %s
                ORDER BY id
            """, (f'%{keyword}%', f'%{keyword}%'))
            students = cursor.fetchall()
            cursor.close()
            return students, None
    except Exception as e:
        return None, f"搜索失败: {e}"
