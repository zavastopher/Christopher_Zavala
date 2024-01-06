-- ---
-- Creates a User List when a user gets created.
-- ---
DELIMITER //
CREATE TRIGGER CreateUserList
AFTER INSERT ON moviebase.User
FOR EACH ROW
BEGIN
	INSERT INTO moviebase.List (Name, Description, UserId) values ('Watchlist', 'This is a list of media you have watched.', NEW.UserId);
END;
//
DELIMITER ;

-- ---
-- Updates the media's average rating when a review is created for that media.
-- ---
DELIMITER //
CREATE TRIGGER UpdateMovieRating
AFTER INSERT ON moviebase.Review
FOR EACH ROW
BEGIN
	DECLARE NewAverageRating DECIMAL(3,1);

	SELECT AVG(Rating) INTO NewAverageRating
	FROM moviebase.Review
	WHERE MediaId = NEW.MediaId;

	UPDATE moviebase.Media
	SET AverageRating = NewAverageRating
	WHERE MediaId = NEW.MediaId;
END;
//
DELIMITER ;