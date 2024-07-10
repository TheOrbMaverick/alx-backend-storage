-- This script creates a stored procedure ComputeAverageScoreForUser that computes and stores the average score for a student.
-- The procedure takes one input: user_id, which is the id of the user for whom the average score is to be computed.

DELIMITER //

CREATE PROCEDURE ComputeAverageScoreForUser(IN user_id INT)
BEGIN
    -- Compute the average score for the specified user
    UPDATE users
    SET average_score = (
        SELECT AVG(score)
        FROM corrections
        WHERE user_id = user_id
    )
    WHERE id = user_id;
END;

//

DELIMITER ;
