-- This script creates an index idx_name_first_score on the names table using the first letter of the name column and the score column.

-- Drop the existing index if it exists to avoid conflicts
DROP INDEX IF EXISTS idx_name_first_score ON names;

-- Create a new index idx_name_first_score on the first letter of the name column and the score column
CREATE INDEX idx_name_first_score ON names (SUBSTRING(name, 1, 1), score);

-- Verify the index creation
SHOW INDEX FROM names;
