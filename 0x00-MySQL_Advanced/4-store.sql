-- This script lists all bands with Glam rock as their main style, ranked by their longevity.
-- The metal_bands table is imported, and the lifespan is calculated using the formed and split attributes.

-- Comment: Select bands with Glam rock as their main style and calculate their lifespan
DELIMITER $$

CREATE TRIGGER decrease_quantity_after_order
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    -- Decrease the quantity of the ordered item in the items table
    UPDATE items
    SET quantity = quantity - NEW.number
    WHERE name = NEW.item_name;
END$$

DELIMITER ;
