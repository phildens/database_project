CREATE OR REPLACE PROCEDURE update_balance(
    in_student_id BIGINT,
    in_amount INTEGER)
AS
$$
BEGIN
    UPDATE refill_balances
    SET balance = balance + in_amount
    WHERE student_id = in_student_id;
END;
$$
LANGUAGE plpgsql;
