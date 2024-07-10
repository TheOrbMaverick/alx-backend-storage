-- This script creates the ComputeAverageWeightedScoreForUser stored procedure to compute and update the average weighted score for a student.

-- Drop the existing procedure if it exists to avoid conflicts
DROP PROCEDURE IF EXISTS ComputeAverageWeightedScoreForUser;

-- Create the ComputeAverageWeightedScoreForUser procedure
DELIMITER //

CREATE PROCEDURE ComputeAverageWeightedScoreForUser(IN user_id INT)
BEGIN
    -- Declare local variables for the weighted sum of scores and the total weight
    DECLARE weighted_sum FLOAT DEFAULT 0;
    DECLARE total_weight INT DEFAULT 0;

    -- Calculate the weighted sum of scores and the total weight for the specified user
    SELECT 
        SUM(c.score * p.weight) INTO weighted_sum
    FROM
        corrections c
    JOIN
        projects p ON c.project_id = p.id
    WHERE
        c.user_id = user_id;

    SELECT 
        SUM(p.weight) INTO total_weight
    FROM
        corrections c
    JOIN
        projects p ON c.project_id = p.id
    WHERE
        c.user_id = user_id;

    -- Compute the average weighted score
    IF total_weight > 0 THEN
        SET @average_weighted_score = weighted_sum / total_weight;
    ELSE
        SET @average_weighted_score = 0;
    END IF;

    -- Update the user's average_score with the computed average weighted score
    UPDATE users
    SET average_score = @average_weighted_score
    WHERE id = user_id;

END //

-- Restore the default delimiter
DELIMITER ;
