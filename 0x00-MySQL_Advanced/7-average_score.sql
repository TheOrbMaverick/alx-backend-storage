-- This script creates a stored procedure ComputeAverageScoreForUser that computes and stores the average score for a student.

-- Comment: Drop the procedure if it exists
DROP PROCEDURE IF EXISTS ComputeAverageScoreForUser;

-- Comment: Create the procedure
DELIMITER //

CREATE PROCEDURE ComputeAverageScoreForUser(IN user_id INT)
BEGIN
    DECLARE avg_score FLOAT;

    -- Comment: Calculate the average score for the given user_id
    SELECT AVG(score) INTO avg_score
    FROM corrections
    WHERE user_id = user_id;

    -- Comment: Update the user's average_score in the users table
    UPDATE users
    SET average_score = avg_score
    WHERE id = user_id;
END //

DELIMITER ;
