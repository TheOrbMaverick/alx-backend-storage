-- This script creates an index idx_name_first_score on the table names for the first letter of name and the score.

-- Comment: Drop the index if it exists
DROP INDEX IF EXISTS idx_name_first_score ON names;

-- Comment: Create the index on the first letter of the name and score
CREATE INDEX idx_name_first_score ON names (name(1), score);
