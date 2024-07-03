import psycopg2
import os

# Функция для подключения к базе данных
def connect_db():
    conn = psycopg2.connect(
        dbname="online_school",
        user="admin",
        password="admin",
        host="0.0.0.0",
        port="5432"
    )
    return conn

# Функция для выполнения SQL-запросов из файла
def execute_sql_from_file(filename):
    conn = connect_db()
    cur = conn.cursor()


    with open(filename, 'r') as file:
        sql_query = file.read()


    cur.execute(sql_query)
    conn.commit()

    conn.close()


sql_files_dir = 'fills'
file_path = os.path.join('ddl.sql')
execute_sql_from_file(file_path)

sql_files = ['parents_fill.sql', 'students_fill.sql',
              'refill_balances.sql', 'subjects_fill.sql',
              'tutors_fill.sql', 'cost_fill.sql',
              'lessons_fill.sql', 'transactions_fill.sql']


for file in sql_files:
    file_path = os.path.join(sql_files_dir, file)
    execute_sql_from_file(file_path)
