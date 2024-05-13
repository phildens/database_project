CREATE OR REPLACE FUNCTION validate_lesson_time()
RETURNS TRIGGER AS
$$
BEGIN
    IF NEW.end_time <= NEW.start_time THEN
        RAISE EXCEPTION 'End time must be greater than start time';
    END IF;

    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER validate_lesson_time_trigger
BEFORE INSERT ON lessons
FOR EACH ROW
EXECUTE FUNCTION validate_lesson_time();
