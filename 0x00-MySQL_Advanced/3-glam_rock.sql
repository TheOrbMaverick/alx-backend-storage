-- This script ranks country origins of bands, ordered by the number of (non-unique) fans.
-- It imports the metal_bands table and calculates the total number of fans for each country origin.

-- Comment: Create a temporary table to aggregate the number of fans by country origin
CREATE TEMPORARY TABLE fans_by_origin AS
SELECT origin, SUM(fans) AS nb_fans
FROM metal_bands
GROUP BY origin;

-- Comment: Select and order the results by number of fans in descending order
SELECT origin, nb_fans
FROM fans_by_origin
ORDER BY nb_fans DESC;
