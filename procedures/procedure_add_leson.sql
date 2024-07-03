
CREATE OR REPLACE PROCEDURE add_lesson(
    in_student_id BIGINT,
    in_tutor_id BIGINT,
    in_start_time TIMESTAMP,
    in_end_time TIMESTAMP,
    in_subject VARCHAR(50),
    in_homework TEXT)
AS
$$
BEGIN
    INSERT INTO lessons (fk_student, fk_tutor, start_time, end_time, subject, homework)
    VALUES (in_student_id, in_tutor_id, in_start_time, in_end_time, in_subject, in_homework);
END;
$$
LANGUAGE plpgsql;
