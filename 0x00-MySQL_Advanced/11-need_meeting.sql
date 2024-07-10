-- This script creates the need_meeting view to list all students that need a meeting based on their score and last meeting date.

-- Drop the existing view if it exists to avoid conflicts
DROP VIEW IF EXISTS need_meeting;

-- Create the need_meeting view
CREATE VIEW need_meeting AS
SELECT name
FROM students
WHERE score < 80
AND (last_meeting IS NULL OR last_meeting <= ADDDATE(CURDATE(), INTERVAL -1 MONTH));

-- Verify the view creation
SHOW CREATE VIEW need_meeting;

-- Test the view with a SELECT statement
SELECT * FROM need_meeting;
