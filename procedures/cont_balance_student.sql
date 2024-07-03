CREATE OR REPLACE FUNCTION calculate_total_balance(student_id BIGINT)
RETURNS INTEGER AS
$$
DECLARE
    total_balance INTEGER;
BEGIN
    SELECT SUM(balance) INTO total_balance
    FROM refill_balances
    WHERE student_id = $1;

    RETURN total_balance;
END;
$$
LANGUAGE plpgsql;
