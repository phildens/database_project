--1)запрос, который получает список всех учеников и их родителей, а так же их последний баланс на счету
SELECT
    s.name AS student_name,
    p.name AS parent_name,
    rb.balance AS last_balance
FROM students s
JOIN parents p ON s.id_parent = p.id_parent
LEFT JOIN (
    SELECT
        student_id,
        balance,
        ROW_NUMBER() OVER (PARTITION BY student_id ORDER BY time_change DESC) AS rn
    FROM refill_balances
) rb ON s.id = rb.student_id AND rb.rn = 1;

--2) запрос выдающий список занятий провведенных с 2024-02-10 09:00:00 по 2024-04-04 09:00:00

SELECT
    id,
    fk_student AS student_id,
    fk_tutor AS tutor_id,
    start_time,
    end_time,
    subject,
    homework
FROM lessons
WHERE start_time >= '2024-02-10 09:00:00' AND end_time <= '2024-04-04 09:00:00';

--3 статус оплаты занятия за этот период
SELECT
    l.id AS lesson_id,
    l.subject,
    CASE
        WHEN t.paid_status = TRUE THEN 'Paid'
        WHEN t.paid_status = FALSE THEN 'Due'
        ELSE 'Not Paid'
    END AS payment_status
FROM lessons l
LEFT JOIN transactions t ON l.id = t.fk_lesson
WHERE l.start_time >= '2024-02-10 09:00:00'
    AND l.end_time <= '2024-04-04 09:00:00';
--4 балансы каждого ученикаSELECT
    s.name AS student_name,
    rb.balance AS last_balance
FROM students s
LEFT JOIN (
    SELECT
        student_id,
        balance,
        ROW_NUMBER() OVER (PARTITION BY student_id ORDER BY time_change DESC) AS rn
    FROM refill_balances
) rb ON s.id = rb.student_id AND rb.rn = 1;
--5 стоимость последниего урока 
SELECT
    s.name AS student_name,
    l.subject,
    c.cost AS lesson_cost
FROM students s
INNER JOIN lessons l ON s.id = l.fk_student
INNER JOIN cost c ON l.subject = c.subject AND l.fk_tutor = c.id_tutor
WHERE l.end_time = (
    SELECT MAX(end_time)
    FROM lessons
    WHERE fk_student = s.id
);

--6 проверка сможет ли учник оплатить свой урок, или ему нужно пополнить баланс
SELECT
    s.name AS student_name,
    l.subject,
    c.cost AS lesson_cost,
    CASE
        WHEN rb.balance >= c.cost THEN TRUE
        ELSE FALSE
    END AS can_pay
FROM students s
INNER JOIN lessons l ON s.id = l.fk_student
INNER JOIN cost c ON l.subject = c.subject AND l.fk_tutor = c.id_tutor
LEFT JOIN (
    SELECT
        student_id,
        balance,
        ROW_NUMBER() OVER (PARTITION BY student_id ORDER BY time_change DESC) AS rn
    FROM refill_balances
) rb ON s.id = rb.student_id AND rb.rn = 1
WHERE l.end_time = (
    SELECT MAX(end_time)
    FROM lessons
    WHERE fk_student = s.id
);

--7) список уроков у преподавателя с id 2 
SELECT
    l.id AS lesson_id,
    l.subject,
    l.start_time,
    l.end_time,
    l.homework
FROM lessons l
WHERE l.fk_tutor = 2;

--8) список уроков химии
SELECT
    id,
    start_time,
    end_time,
    homework
FROM lessons
WHERE subject = 'Chemistry';
--9) вывод суммы денег заработанной каждым преподавателем
SELECT
    tutor_id,
    SUM(lesson_cost) AS total_earnings
FROM (
    SELECT
        l.fk_tutor AS tutor_id,
        l.subject,
        c.cost AS lesson_cost
    FROM lessons l
    INNER JOIN cost c ON l.subject = c.subject AND l.fk_tutor = c.id_tutor
) subquery
GROUP BY tutor_id;
 --10) каждое зантяние и его стоимость
 SELECT
	l.id,
    l.fk_tutor AS tutor_id,
    l.subject,
    c.cost AS lesson_cost
FROM lessons l
INNER JOIN cost c ON l.subject = c.subject AND l.fk_tutor = c.id_tutor order by l.id;
