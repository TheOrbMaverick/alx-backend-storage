-- This script creates an index idx_name_first_score on the table names for the first letter of name and the score.

-- Comment: Create the index on the first letter of the name and the score
CREATE INDEX idx_name_first_score ON names (name(1), score);
