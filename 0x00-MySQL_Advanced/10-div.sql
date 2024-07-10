-- This script creates the SafeDiv function to safely divide two integers, returning 0 if the divisor is zero.

-- Drop the existing function if it exists to avoid conflicts
DROP FUNCTION IF EXISTS SafeDiv;

-- Create the SafeDiv function
CREATE FUNCTION SafeDiv(a INT, b INT)
RETURNS DECIMAL(10, 6)
DETERMINISTIC
BEGIN
    -- Check if the divisor (b) is zero
    IF b = 0 THEN
        RETURN 0;
    ELSE
        -- Perform the division and return the result
        RETURN a / b;
    END IF;
END;

-- Verify the function creation
SHOW FUNCTION STATUS WHERE Db = 'holberton' AND Name = 'SafeDiv';

-- Test the SafeDiv function with a SELECT statement
SELECT a, b, SafeDiv(a, b) AS SafeDiv_Result FROM numbers;
