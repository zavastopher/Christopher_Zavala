-- ---
-- Creates a new user and encrypts their password with a randomly generated salt.
-- ---
DELIMITER //
CREATE PROCEDURE CreateUser ( IN newFirstName varchar(40), IN newLastName varchar(40), IN newEmail varchar(60), IN newPassword varchar(100) )
BEGIN
	DECLARE hashedPassword varchar(256);
	DECLARE newSalt varchar(256);

	SET newSalt = SHA2(RAND(), 256);
	SET hashedPassword = SHA2(CONCAT(newPassword, newSalt), 256);

	INSERT INTO moviebase.User (FirstName, LastName, Email, Password, Salt) values (newFirstName, newLastName, newEmail, hashedPassword, newSalt);
END;
//
DELIMITER ;

-- ---
-- Verifies a user by comparing the user's stored password with the inputted password.
-- Returns boolean that determines if the email and password are valid.
-- ---
DELIMITER //
CREATE PROCEDURE VerifyUser ( IN inputEmail varchar(60), IN inputPassword varchar(100), OUT isVerifiedUser BOOLEAN )
BEGIN
	DECLARE userCount INT;
	DECLARE storedPassword varchar(256);
	DECLARE storedSalt varchar(256);

	SELECT COUNT(*) INTO userCount
	FROM moviebase.User
	WHERE Email = inputEmail;

	IF userCount > 0 THEN
		SELECT Password, Salt INTO storedPassword, storedSalt
		FROM moviebase.User
		WHERE Email = inputEmail;

		SET isVerifiedUser = (SHA2(CONCAT(inputPassword, storedSalt), 256) = storedPassword);
	ELSE
		SET isVerifiedUser = FALSE;
	END IF;
END;
//
DELIMITER ;

-- ---
-- Searches for media given the search type, search value, and optional aggregation type.
-- Returns resulting media that match the search.
-- ---
DELIMITER //
CREATE PROCEDURE Search (IN searchType VARCHAR(20), IN searchValue VARCHAR(100), IN aggregationType VARCHAR(2))
BEGIN
	-- Search by Title
	IF LOWER(searchType) = LOWER('Title') THEN
		SET searchValue = CONCAT('%', searchValue, '%');
		SELECT Media.MediaId, Media.Title, Media.Description, Media.ReleaseDate, Media.RunTime, Media.AverageRating, Media.Poster, Media.MediaTypeId, Media.PublisherId, Media.LanguageId, Media.AgeRatingId
		FROM moviebase.Media
		WHERE LOWER(Title) LIKE LOWER(searchValue);
	-- Search by ReleaseDate (=)
	ELSEIF LOWER(searchType) = LOWER('ReleaseDate') AND aggregationType IS NULL THEN
		SELECT Media.MediaId, Media.Title, Media.Description, Media.ReleaseDate, Media.RunTime, Media.AverageRating, Media.Poster, Media.MediaTypeId, Media.PublisherId, Media.LanguageId, Media.AgeRatingId
		FROM moviebase.Media
		WHERE ReleaseDate = CONVERT(searchValue, DATE);
	-- Search by ReleaseDate (<=)
	ELSEIF LOWER(searchType) = LOWER('ReleaseDate') AND aggregationType = '<=' THEN
		SELECT Media.MediaId, Media.Title, Media.Description, Media.ReleaseDate, Media.RunTime, Media.AverageRating, Media.Poster, Media.MediaTypeId, Media.PublisherId, Media.LanguageId, Media.AgeRatingId
		FROM moviebase.Media
		WHERE ReleaseDate <= CONVERT(searchValue, DATE);
	-- Search by ReleaseDate (>=)
	ELSEIF LOWER(searchType) = LOWER('ReleaseDate') AND aggregationType = '>=' THEN
		SELECT Media.MediaId, Media.Title, Media.Description, Media.ReleaseDate, Media.RunTime, Media.AverageRating, Media.Poster, Media.MediaTypeId, Media.PublisherId, Media.LanguageId, Media.AgeRatingId
		FROM moviebase.Media
		WHERE ReleaseDate >= CONVERT(searchValue, DATE);
	-- Search by RunTime (=)
	ELSEIF LOWER(searchType) = LOWER('RunTime') AND aggregationType IS NULL THEN
		SELECT Media.MediaId, Media.Title, Media.Description, Media.ReleaseDate, Media.RunTime, Media.AverageRating, Media.Poster, Media.MediaTypeId, Media.PublisherId, Media.LanguageId, Media.AgeRatingId
		FROM moviebase.Media
		WHERE RunTime = CONVERT(searchValue, SIGNED);
	-- Search by RunTime (<=)
	ELSEIF LOWER(searchType) = LOWER('RunTime') AND aggregationType = '<=' THEN
		SELECT Media.MediaId, Media.Title, Media.Description, Media.ReleaseDate, Media.RunTime, Media.AverageRating, Media.Poster, Media.MediaTypeId, Media.PublisherId, Media.LanguageId, Media.AgeRatingId
		FROM moviebase.Media
		WHERE RunTime <= CONVERT(searchValue, SIGNED);
	-- Search by RunTime (>=)
	ELSEIF LOWER(searchType) = LOWER('RunTime') AND aggregationType = '>=' THEN
		SELECT Media.MediaId, Media.Title, Media.Description, Media.ReleaseDate, Media.RunTime, Media.AverageRating, Media.Poster, Media.MediaTypeId, Media.PublisherId, Media.LanguageId, Media.AgeRatingId
		FROM moviebase.Media
		WHERE RunTime >= CONVERT(searchValue, SIGNED);
	-- Search by AverageRating (=)
	ELSEIF LOWER(searchType) = LOWER('AverageRating') AND aggregationType IS NULL THEN
		SELECT Media.MediaId, Media.Title, Media.Description, Media.ReleaseDate, Media.RunTime, Media.AverageRating, Media.Poster, Media.MediaTypeId, Media.PublisherId, Media.LanguageId, Media.AgeRatingId
		FROM moviebase.Media
		WHERE AverageRating = CONVERT(searchValue, DECIMAL(3, 1));
	-- Search by AverageRating (<=)
	ELSEIF LOWER(searchType) = LOWER('AverageRating') AND aggregationType = '<=' THEN
		SELECT Media.MediaId, Media.Title, Media.Description, Media.ReleaseDate, Media.RunTime, Media.AverageRating, Media.Poster, Media.MediaTypeId, Media.PublisherId, Media.LanguageId, Media.AgeRatingId
		FROM moviebase.Media
		WHERE AverageRating <= CONVERT(searchValue, DECIMAL(3, 1));
	-- Search by AverageRating (>=)
	ELSEIF LOWER(searchType) = LOWER('AverageRating') AND aggregationType = '>=' THEN
		SELECT Media.MediaId, Media.Title, Media.Description, Media.ReleaseDate, Media.RunTime, Media.AverageRating, Media.Poster, Media.MediaTypeId, Media.PublisherId, Media.LanguageId, Media.AgeRatingId
		FROM moviebase.Media
		WHERE AverageRating >= CONVERT(searchValue, DECIMAL(3, 1));
	-- Search by MediaType
	ELSEIF LOWER(searchType) = LOWER('MediaType') THEN
		SET searchValue = CONCAT('%', searchValue, '%');
		SELECT Media.MediaId, Media.Title, Media.Description, Media.ReleaseDate, Media.RunTime, Media.AverageRating, Media.Poster, Media.MediaTypeId, Media.PublisherId, Media.LanguageId, Media.AgeRatingId
		FROM moviebase.Media
		JOIN moviebase.MediaType
		ON Media.MediaTypeId = MediaType.MediaTypeId
		WHERE LOWER(MediaType.Name) LIKE LOWER(searchValue);
	-- Search by Publisher
	ELSEIF LOWER(searchType) = LOWER('Publisher') THEN
		SET searchValue = CONCAT('%', searchValue, '%');
		SELECT Media.MediaId, Media.Title, Media.Description, Media.ReleaseDate, Media.RunTime, Media.AverageRating, Media.Poster, Media.MediaTypeId, Media.PublisherId, Media.LanguageId, Media.AgeRatingId
		FROM moviebase.Media
		JOIN moviebase.Publisher
		ON Media.PublisherId = Publisher.PublisherId
		WHERE LOWER(Publisher.Name) LIKE LOWER(searchValue);
	-- Search by Language
	ELSEIF LOWER(searchType) = LOWER('Language') THEN
		SET searchValue = CONCAT('%', searchValue, '%');
		SELECT Media.MediaId, Media.Title, Media.Description, Media.ReleaseDate, Media.RunTime, Media.AverageRating, Media.Poster, Media.MediaTypeId, Media.PublisherId, Media.LanguageId, Media.AgeRatingId
		FROM moviebase.Media
		JOIN moviebase.Language
		ON Media.LanguageId = Language.LanguageId
		WHERE LOWER(Language.Name) LIKE LOWER(searchValue);
	-- Search by AgeRating
	ELSEIF LOWER(searchType) = LOWER('AgeRating') THEN
		SELECT Media.MediaId, Media.Title, Media.Description, Media.ReleaseDate, Media.RunTime, Media.AverageRating, Media.Poster, Media.MediaTypeId, Media.PublisherId, Media.LanguageId, Media.AgeRatingId
		FROM moviebase.Media
		JOIN moviebase.AgeRating
		ON Media.AgeRatingId = AgeRating.AgeRatingId
		JOIN moviebase.AgeRatingType
		ON AgeRating.AgeRatingTypeId = AgeRatingType.AgeRatingTypeId
		WHERE LOWER(AgeRatingType.Type) = LOWER(searchValue);
	-- Search by CastCrew
	ELSEIF LOWER(searchType) = LOWER('CastCrew') THEN
		SET searchValue = CONCAT('%', searchValue, '%');
		SELECT DISTINCT Media.MediaId, Media.Title, Media.Description, Media.ReleaseDate, Media.RunTime, Media.AverageRating, Media.Poster, Media.MediaTypeId, Media.PublisherId, Media.LanguageId, Media.AgeRatingId
		FROM moviebase.Media
		JOIN moviebase.MediaCastCrew
		ON Media.MediaId = MediaCastCrew.MediaId
		JOIN moviebase.CastCrew
		ON MediaCastCrew.CastCrewId = CastCrew.CastCrewId
		JOIN moviebase.CastCrewType
		ON CastCrew.CastCrewTypeId = CastCrewType.CastCrewTypeId
		WHERE LOWER(CONCAT(CastCrew.FirstName, ' ', CastCrew.LastName)) LIKE LOWER(searchValue) OR LOWER(CastCrew.FirstName) LIKE LOWER(searchValue) OR LOWER(CastCrew.LastName) LIKE LOWER(searchValue);
	-- Search by Genre
	ELSEIF LOWER(searchType) = LOWER('Genre') THEN
		SET searchValue = CONCAT('%', searchValue, '%');
		SELECT Media.MediaId, Media.Title, Media.Description, Media.ReleaseDate, Media.RunTime, Media.AverageRating, Media.Poster, Media.MediaTypeId, Media.PublisherId, Media.LanguageId, Media.AgeRatingId
		FROM moviebase.Media
		JOIN moviebase.MediaGenre
		ON Media.MediaId = MediaGenre.MediaId
		JOIN moviebase.Genre
		ON MediaGenre.GenreId = Genre.GenreId
		WHERE LOWER(Genre.Name) LIKE LOWER(searchValue);
	-- Search by StreamingService
	ELSEIF LOWER(searchType) = LOWER('StreamingService') THEN
		SET searchValue = CONCAT('%', searchValue, '%');
		SELECT Media.MediaId, Media.Title, Media.Description, Media.ReleaseDate, Media.RunTime, Media.AverageRating, Media.Poster, Media.MediaTypeId, Media.PublisherId, Media.LanguageId, Media.AgeRatingId
		FROM moviebase.Media
		JOIN moviebase.MediaStreamingService
		ON Media.MediaId = MediaStreamingService.MediaId
		JOIN moviebase.StreamingService
		ON MediaStreamingService.StreamingServiceId = StreamingService.StreamingServiceId
		WHERE LOWER(StreamingService.Name) LIKE LOWER(searchValue);
	END IF;
END;
//
DELIMITER ;