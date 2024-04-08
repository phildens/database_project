# database_project by Filippov Denis

## концептуальная модель проекта:
Проект предсавляет собой базу данных для проведения занятий в онлайн школе
<img src="concept_model.png">
<img src="logic_model.png">


## Таблица 1: Таблица "parents"
| Название поля | Тип данных | Ограничения |
|---------------|------------|-------------|
| id_parent     | BIGSERIAL  | NOT NULL, PRIMARY KEY |
| name          | VARCHAR(50)| NOT NULL    |
| surname       | VARCHAR(50)| NOT NULL    |
| email_adress  | VARCHAR(50)| NOT NULL    |

##Таблица 2: Таблица "students"
| Название поля | Тип данных | Ограничения |
|---------------|------------|-------------|
| id            | BIGSERIAL  | NOT NULL, PRIMARY KEY |
| id_parent     | BIGINT     | REFERENCES parents(id_parent) |
| name          | VARCHAR(50)| NOT NULL    |
| surname       | VARCHAR(50)| NOT NULL    |
| email_adress  | VARCHAR(50)| NOT NULL    |

 ##Таблица 3: Таблица "refill_balances"
 | Название поля | Тип данных | Ограничения |
|---------------|------------|-------------|
| student_id    | BIGINT     | REFERENCES students(id) |
| balance       | integer    | DEFAULT 0   |
| time_change   | timestamp  | NOT NULL    |

## Таблица 4: Таблица "subjects"
| Название поля | Тип данных | Ограничения |
|---------------|------------|-------------|
| subject_name  | VARCHAR(50)| NOT NULL, PRIMARY KEY |
## Таблица 5: Таблица "tutors"
| Название поля | Тип данных | Ограничения |
|---------------|------------|-------------|
| id            | BIGSERIAL  | NOT NULL, PRIMARY KEY |
| name          | VARCHAR(50)| NOT NULL    |
| surname       | VARCHAR(50)| NOT NULL    |
| email_adress  | VARCHAR(50)| NOT NULL    |

## Таблица 6: Таблица "cost"
| Название поля | Тип данных | Ограничения |
|---------------|------------|-------------|
| id            | BIGSERIAL  | NOT NULL, PRIMARY KEY |
| id_tutor      | INTEGER    | REFERENCES tutors(id) |
| subject       | VARCHAR(50)| REFERENCES subjects(subject_name) |
| cost          | integer    | NOT NULL    |


## Таблица 7: Таблица "lessons"

| Название поля | Тип данных | Ограничения |
|---------------|------------|-------------|
| id            | SERIAL     | PRIMARY KEY |
| fk_student    | BIGINT     | REFERENCES students(id) |
| fk_tutor      | BIGINT     | REFERENCES tutors(id) |
| start_time    | timestamp  | NOT NULL, CHECK (end_time > start_time) |
| end_time      | timestamp  | NOT NULL, CHECK (end_time > start_time) |
| subject       | VARCHAR(50)| REFERENCES subjects(subject_name) |
| homework      | TEXT       |             |

##Таблица 8: Таблица "transactions"
| Название поля | Тип данных | Ограничения |
|---------------|------------|-------------|
| fk_lesson     | INTEGER    | REFERENCES lessons(id) |
| paid_status   | BOOLEAN    |             |



## Описание таблиц базы данных

1. **Таблица "parents"**:
   - Содержит информацию о родителях.
   - Колонки:
     - `id_parent`: Уникальный идентификатор родителя (первичный ключ).
     - `name`: Имя родителя.
     - `surname`: Фамилия родителя.
     - `email_adress`: Адрес электронной почты родителя.

2. **Таблица "students"**:
   - Содержит информацию о студентах.
   - Колонки:
     - `id`: Уникальный идентификатор студента (первичный ключ).
     - `id_parent`: Идентификатор родителя, на которого ссылается студент (внешний ключ).
     - `name`: Имя студента.
     - `surname`: Фамилия студента.
     - `email_adress`: Адрес электронной почты студента.

3. **Таблица "refill_balances"**:
   - Содержит информацию о пополнении баланса студентов.
   - Колонки:
     - `student_id`: Идентификатор студента, на которого ссылается пополнение баланса (внешний ключ).
     - `balance`: Текущий баланс.
     - `time_change`: Время изменения баланса.

4. **Таблица "subjects"**:
   - Содержит информацию о предметах.
   - Колонки:
     - `subject_name`: Название предмета (первичный ключ).

5. **Таблица "tutors"**:
   - Содержит информацию о преподавателях.
   - Колонки:
     - `id`: Уникальный идентификатор преподавателя (первичный ключ).
     - `name`: Имя преподавателя.
     - `surname`: Фамилия преподавателя.
     - `email_adress`: Адрес электронной почты преподавателя.

6. **Таблица "cost"**:
   - Содержит информацию о стоимости занятий.
   - Колонки:
     - `id`: Уникальный идентификатор записи о стоимости (первичный ключ).
     - `id_tutor`: Идентификатор преподавателя, на которого ссылается стоимость (внешний ключ).
     - `subject`: Название предмета, на который ссылается стоимость (внешний ключ).
     - `cost`: Стоимость занятия.

7. **Таблица "lessons"**:
   - Содержит информацию о проведенных уроках.
   - Колонки:
     - `id`: Уникальный идентификатор урока (первичный ключ).
     - `fk_student`: Идентификатор студента, на которого ссылается урок (внешний ключ).
     - `fk_tutor`: Идентификатор преподавателя, на которого ссылается урок (внешний ключ).
     - `start_time`: Время начала урока.
     - `end_time`: Время окончания урока.
     - `subject`: Название предмета урока.
     - `homework`: Домашнее задание.

8. **Таблица "transactions"**:
   - Содержит информацию о транзакциях (оплате) за уроки.
   - Колонки:
     - `fk_lesson`: Идентификатор урока, на который ссылается транзакция (внешний ключ).
     - `paid_status`: Статус оплаты (TRUE - оплачено, FALSE - не оплачено).

