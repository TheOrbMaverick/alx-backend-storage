-- This script creates a table 'users' with the specified attributes.
-- The table includes an auto-increment primary key 'id', a unique 'email', a 'name', and a 'country'.
-- The 'country' attribute is an enumeration of 'US', 'CO', and 'TN', and it defaults to 'US'.
-- If the table already exists, the script will not fail.

CREATE TABLE IF NOT EXISTS users (
    id INT NOT NULL AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL UNIQUE,
    name VARCHAR(255),
    country ENUM('US', 'CO', 'TN') NOT NULL DEFAULT 'US',
    PRIMARY KEY (id)
);
