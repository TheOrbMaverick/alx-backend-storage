-- This script creates a table 'users' with the specified attributes.
-- The table includes an auto-increment primary key 'id', a unique 'email', and a 'name'.
-- If the table already exists, the script will not fail.

CREATE TABLE IF NOT EXISTS users (
    id INT NOT NULL AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL UNIQUE,
    name VARCHAR(255),
    PRIMARY KEY (id)
);
