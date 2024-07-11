-- This script creates an index idx_name_first on the table names for the first letter of name.

-- Comment: Drop the index if it exists
DROP INDEX IF EXISTS idx_name_first ON names;

-- Comment: Create the index on the first letter of the name
CREATE INDEX idx_name_first ON names (name(1));
