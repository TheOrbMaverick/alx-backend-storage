-- Script to rank country origins of bands by the number of non-unique fans

-- Change to your database
USE holberton;

-- Create a view to rank origins by the number of fans
CREATE VIEW origin_fan_ranking AS
SELECT 
    origin,
    SUM(fans) AS nb_fans
FROM 
    metal_bands
GROUP BY 
    origin
ORDER BY 
    nb_fans DESC;

-- Select from the view
SELECT 
    origin,
    nb_fans
FROM 
    origin_fan_ranking;
