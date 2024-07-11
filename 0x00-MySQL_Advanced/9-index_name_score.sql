-- Verify that the index is created
SHOW INDEX FROM names;

-- Verify the performance improvement
SELECT COUNT(name) FROM names WHERE name LIKE 'a%' AND score < 80;
