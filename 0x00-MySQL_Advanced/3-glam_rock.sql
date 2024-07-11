-- This script lists all bands with Glam rock as their main style, ranked by their longevity.
-- The metal_bands table is imported, and the lifespan is calculated using the formed and split attributes.

-- Comment: Select bands with Glam rock as their main style and calculate their lifespan
SELECT band_name, 
       IFNULL(2022 - formed, 0) AS lifespan
FROM metal_bands
WHERE FIND_IN_SET('Glam rock', style) > 0
ORDER BY lifespan DESC;
