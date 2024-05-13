import pytest
import psycopg2
from psycopg2 import sql
from datetime import datetime


def connect_db():
    conn = psycopg2.connect(
        dbname="online_school",
        user="admin",
        password="admin",
        host="local_host",
        port="5432"
    )
    return conn

#  для проверки добавления урока
def test_add_lesson():
    conn = connect_db()
    cur = conn.cursor()


    student_id = 1
    tutor_id = 1
    start_time = '2024-05-13 10:00:00'
    end_time = '2024-05-13 12:00:00'
    subject = 'Math'
    homework = 'Complete exercises 1-5'


    cur.callproc('add_lesson', (student_id, tutor_id, start_time, end_time, subject, homework))


    cur.execute("SELECT * FROM lessons WHERE fk_student = %s", (student_id,))
    result = cur.fetchone()
    assert result is not None

    conn.commit()
    conn.close()

# для проверки общего баланса студента
def test_calculate_total_balance():
    conn = connect_db()
    cur = conn.cursor()


    student_id = 1
    refill_amount = 50


    cur.callproc('update_balance', (student_id, refill_amount))


    cur.execute("SELECT calculate_total_balance(%s)", (student_id,))
    total_balance = cur.fetchone()[0]


    assert total_balance == refill_amount

    conn.commit()
    conn.close()


def test_validate_lesson_time():
    conn = connect_db()
    cur = conn.cursor()

    student_id = 1
    tutor_id = 1
    start_time = '2024-05-13 10:00:00'
    end_time = '2024-05-13 09:00:00'  

   
    with pytest.raises(psycopg2.DataError):
        cur.execute("INSERT INTO lessons (fk_student, fk_tutor, start_time, end_time) VALUES (%s, %s, %s, %s)",
                    (student_id, tutor_id, start_time, end_time))

    conn.commit()
    conn.close()

# для проверки автоматического обновления баланса при пополнении
def test_update_student_balance_trigger():
    conn = connect_db()
    cur = conn.cursor()

    
    student_id = 1
    refill_amount = 100

 
    cur.callproc('update_balance', (student_id, refill_amount))

   
    cur.execute("SELECT balance FROM refill_balances WHERE student_id = %s", (student_id,))
    updated_balance = cur.fetchone()[0]


    assert updated_balance == refill_amount

    conn.commit()
    conn.close()
