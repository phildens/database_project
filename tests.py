import pytest
import psycopg2

# Функция для подключения к базе данных
def connect_db():
    conn = psycopg2.connect(
        dbname="your_database",
        user="your_username",
        password="your_password",
        host="your_host",
        port="your_port"
    )
    return conn

# Пример теста для проверки добавления урока
def test_add_lesson():
    conn = connect_db()
    cur = conn.cursor()

    # Создание тестовых данных для урока
    student_id = 1
    tutor_id = 1
    start_time = '2024-05-13 10:00:00'
    end_time = '2024-05-13 12:00:00'
    subject = 'Math'
    homework = 'Complete exercises 1-5'

    # Вызов процедуры для добавления урока
    cur.callproc('add_lesson', (student_id, tutor_id, start_time, end_time, subject, homework))

    # Проверка добавления урока в базу данных
    cur.execute("SELECT * FROM lessons WHERE fk_student = %s", (student_id,))
    result = cur.fetchone()
    assert result is not None

    conn.commit()
    conn.close()
