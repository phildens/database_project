import psycopg2
from psycopg2 import sql
import random
from faker import Faker
from datetime import datetime, timedelta

# Подключение к базе данных
conn = psycopg2.connect(
    dbname="your_database",
    user="your_username",
    password="your_password",
    host="your_host",
    port="your_port"
)
cur = conn.cursor()

# Инициализация Faker для генерации фальшивых данных
fake = Faker()

# Генерация данных для студентов и их родителей
def generate_students_and_parents(num_records):
    for _ in range(num_records):
        parent_name = fake.first_name()
        parent_surname = fake.last_name()
        parent_email = fake.email()

        # Вставка данных родителей
        cur.execute("INSERT INTO parents (name, surname, email_adress) VALUES (%s, %s, %s)", (parent_name, parent_surname, parent_email))
        conn.commit()

        student_name = fake.first_name()
        student_surname = fake.last_name()
        student_email = fake.email()

        # Получение последнего id_parent из таблицы parents
        cur.execute("SELECT id_parent FROM parents ORDER BY id_parent DESC LIMIT 1")
        id_parent = cur.fetchone()[0]

        # Вставка данных студентов
        cur.execute("INSERT INTO students (id_parent, name, surname, email_adress) VALUES (%s, %s, %s, %s)", (id_parent, student_name, student_surname, student_email))
        conn.commit()

# Генерация данных для уроков и транзакций
def generate_lessons_and_transactions(num_records):
    subjects = ['Math', 'Science', 'History', 'English', 'Programming']

    for _ in range(num_records):
        # Получение случайного студента
        cur.execute("SELECT id FROM students ORDER BY RANDOM() LIMIT 1")
        student_id = cur.fetchone()[0]

        # Получение случайного преподавателя
        cur.execute("SELECT id FROM tutors ORDER BY RANDOM() LIMIT 1")
        tutor_id = cur.fetchone()[0]

        # Генерация случайного времени начала и конца урока
        start_time = fake.date_time_this_year()
        end_time = start_time + timedelta(hours=random.randint(1, 3))

        subject = random.choice(subjects)
        homework = fake.text()

        # Вставка данных уроков
        cur.execute("INSERT INTO lessons (fk_student, fk_tutor, start_time, end_time, subject, homework) VALUES (%s, %s, %s, %s, %s, %s)",
                    (student_id, tutor_id, start_time, end_time, subject, homework))
        conn.commit()

        # Вставка данных транзакций (предполагая, что урок оплачен сразу после проведения)
        cur.execute("INSERT INTO transactions (fk_lesson, paid_status) VALUES ((SELECT MAX(id) FROM lessons), TRUE)")
        conn.commit()

# Генерация данных для пополнения баланса
def generate_refill_balances(num_records):
    for _ in range(num_records):
        # Получение случайного студента
        cur.execute("SELECT id FROM students ORDER BY RANDOM() LIMIT 1")
        student_id = cur.fetchone()[0]

        # Генерация случайного значения баланса
        balance = random.randint(10, 1000)

        # Генерация случайного времени пополнения баланса
        refill_time = fake.date_time_this_year()

        # Вставка данных пополнения баланса
        cur.execute("INSERT INTO refill_balances (student_id, balance, time_change) VALUES (%s, %s, %s)", (student_id, balance, refill_time))
        conn.commit()

# Вызов функций для генерации данных
generate_students_and_parents(20)
generate_lessons_and_transactions(50)
generate_refill_balances(30)

# Закрытие соединения с базой данных
cur.close()
conn.close()
