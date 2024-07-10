-- This script ranks country origins of bands ordered by the number of non-unique fans.
-- It outputs the country of origin and the total number of fans, ordered by the number of fans in descending order.

SELECT origin, SUM(nb_fans) AS nb_fans
FROM metal_bands
GROUP BY origin
ORDER BY nb_fans DESC;
