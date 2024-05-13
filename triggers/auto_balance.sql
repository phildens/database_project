CREATE OR REPLACE FUNCTION update_student_balance()
RETURNS TRIGGER AS
$$
BEGIN
    UPDATE refill_balances
    SET balance = balance + NEW.amount
    WHERE student_id = NEW.student_id;

    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER update_student_balance_trigger
AFTER INSERT ON refill_balances
FOR EACH ROW
EXECUTE FUNCTION update_student_balance();
