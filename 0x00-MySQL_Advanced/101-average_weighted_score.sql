-- This script creates the ComputeAverageWeightedScoreForUsers stored procedure to compute and update the average weighted score for all students.

-- Drop the existing procedure if it exists to avoid conflicts
DROP PROCEDURE IF EXISTS ComputeAverageWeightedScoreForUsers;

-- Create the ComputeAverageWeightedScoreForUsers procedure
DELIMITER //

CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    -- Declare variables for the weighted sum of scores and the total weight
    DECLARE v_user_id INT;
    DECLARE v_weighted_sum FLOAT;
    DECLARE v_total_weight INT;

    -- Declare a cursor to iterate over each user
    DECLARE user_cursor CURSOR FOR 
        SELECT id FROM users;

    -- Declare a handler for cursor when there are no more rows
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_user_id = NULL;

    -- Open the cursor
    OPEN user_cursor;

    -- Loop through all users
    user_loop: LOOP
        -- Fetch the user_id from the cursor
        FETCH user_cursor INTO v_user_id;

        -- Exit the loop if no more rows are found
        IF v_user_id IS NULL THEN
            LEAVE user_loop;
        END IF;

        -- Calculate the weighted sum of scores and the total weight for the current user
        SELECT 
            SUM(c.score * p.weight) INTO v_weighted_sum
        FROM
            corrections c
        JOIN
            projects p ON c.project_id = p.id
        WHERE
            c.user_id = v_user_id;

        SELECT 
            SUM(p.weight) INTO v_total_weight
        FROM
            corrections c
        JOIN
            projects p ON c.project_id = p.id
        WHERE
            c.user_id = v_user_id;

        -- Compute the average weighted score and update the average_score field
        IF v_total_weight > 0 THEN
            UPDATE users
            SET average_score = v_weighted_sum / v_total_weight
            WHERE id = v_user_id;
        ELSE
            UPDATE users
            SET average_score = 0
            WHERE id = v_user_id;
        END IF;

    END LOOP;

    -- Close the cursor
    CLOSE user_cursor;

END //

-- Restore the default delimiter
DELIMITER ;