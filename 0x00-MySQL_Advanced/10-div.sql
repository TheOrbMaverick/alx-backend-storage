-- This script creates a function SafeDiv that divides the first number by the second number or returns 0 if the second number is 0.

-- Comment: Drop the function if it exists
DROP FUNCTION IF EXISTS SafeDiv;

-- Comment: Create the SafeDiv function
DELIMITER //

CREATE FUNCTION SafeDiv(a INT, b INT)
RETURNS FLOAT
DETERMINISTIC
BEGIN
    -- Comment: Return a divided by b, or 0 if b is 0
    RETURN CASE
        WHEN b = 0 THEN 0
        ELSE a / b
    END;
END //

DELIMITER ;
