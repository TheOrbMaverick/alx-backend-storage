-- This script creates an index idx_name_first on the names table using only the first letter of the name column.

-- Drop the existing index if it exists to avoid conflicts
DROP INDEX IF EXISTS idx_name_first ON names;

-- Create a new index idx_name_first on the first letter of the name column
CREATE INDEX idx_name_first ON names (SUBSTRING(name, 1, 1));

-- Verify the index creation
SHOW INDEX FROM names;
