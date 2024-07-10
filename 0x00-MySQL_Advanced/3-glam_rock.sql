-- This script lists all bands with Glam rock as their main style, ranked by their longevity.
-- It calculates the lifespan of each band in years from their formation until 2022.
-- The results are ordered by lifespan in descending order.

SELECT 
    band_name,
    CASE
        WHEN split IS NULL THEN 2022 - formed
        ELSE split - formed
    END AS lifespan
FROM 
    metal_bands
WHERE 
    main_style = 'Glam rock'
ORDER BY 
    lifespan DESC;
