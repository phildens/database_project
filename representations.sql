
#Представление для таблицы "students" и "parents"
CREATE VIEW student_parent_view AS
SELECT s.id, s.name AS student_name, s.surname AS student_surname,
       s.email_adress AS student_email, p.name AS parent_name, 
       p.surname AS parent_surname, p.email_adress AS parent_email
FROM students s
JOIN parents p ON s.id_parent = p.id_parent;
