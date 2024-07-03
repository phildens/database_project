CREATE OR REPLACE FUNCTION update_transaction_status()
RETURNS TRIGGER AS
$$
BEGIN
    INSERT INTO transactions (fk_lesson, paid_status)
    VALUES (NEW.id, TRUE);

    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER update_transaction_status_trigger
AFTER INSERT ON lessons
FOR EACH ROW
EXECUTE FUNCTION update_transaction_status();
