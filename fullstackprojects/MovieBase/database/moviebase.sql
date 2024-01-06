-- ---
-- Globals
-- ---

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=0;

-- ---
-- Schema 'moviebase'
-- 
-- ---

DROP SCHEMA IF EXISTS `moviebase`;

CREATE SCHEMA `moviebase` ;

-- ---
-- Table 'User'
-- 
-- ---

DROP TABLE IF EXISTS moviebase.User;
		
CREATE TABLE moviebase.User (
  `UserId` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(40) NOT NULL,
  `LastName` VARCHAR(40) NOT NULL,
  `Email` VARCHAR(60) NOT NULL,
  `Password` VARCHAR(256) NOT NULL,
  `Salt` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`UserId`)
);

-- ---
-- Table 'Media'
-- 
-- ---

DROP TABLE IF EXISTS moviebase.Media;
		
CREATE TABLE moviebase.Media (
  `MediaId` INT NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(100) NOT NULL,
  `Description` BLOB NOT NULL,
  `ReleaseDate` DATE NOT NULL,
  `RunTime` INT NOT NULL,
  `AverageRating` DECIMAL(3, 1) NOT NULL,
  `Poster` VARCHAR(500) NOT NULL,
  `MediaTypeId` INT NOT NULL,
  `PublisherId` INT NOT NULL,
  `LanguageId` INT NOT NULL,
  `AgeRatingId` INT NOT NULL,
  PRIMARY KEY (`MediaId`)
);

-- ---
-- Table 'MediaType'
-- 
-- ---

DROP TABLE IF EXISTS moviebase.MediaType;
		
CREATE TABLE moviebase.MediaType (
  `MediaTypeId` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`MediaTypeId`)
);

-- ---
-- Table 'Publisher'
-- 
-- ---

DROP TABLE IF EXISTS moviebase.Publisher;
		
CREATE TABLE moviebase.Publisher (
  `PublisherId` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`PublisherId`)
);

-- ---
-- Table 'StreamingService'
-- 
-- ---

DROP TABLE IF EXISTS moviebase.StreamingService;
		
CREATE TABLE moviebase.StreamingService (
  `StreamingServiceId` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`StreamingServiceId`)
);

-- ---
-- Table 'Genre'
-- 
-- ---

DROP TABLE IF EXISTS moviebase.Genre;
		
CREATE TABLE moviebase.Genre (
  `GenreId` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`GenreId`)
);

-- ---
-- Table 'AgeRating'
-- 
-- ---

DROP TABLE IF EXISTS moviebase.AgeRating;
		
CREATE TABLE moviebase.AgeRating (
  `AgeRatingId` INT NOT NULL AUTO_INCREMENT,
  `Description` BLOB NOT NULL,
  `AgeRatingTypeId` INT NOT NULL,
  PRIMARY KEY (`AgeRatingId`)
);

-- ---
-- Table 'Review'
-- 
-- ---

DROP TABLE IF EXISTS moviebase.Review;
		
CREATE TABLE moviebase.Review (
  `ReviewId` INT NOT NULL AUTO_INCREMENT,
  `Description` BLOB NOT NULL,
  `Rating` DECIMAL(3, 1) NOT NULL,
  `MediaId` INT NOT NULL,
  `UserId` INT NOT NULL,
  PRIMARY KEY (`ReviewId`)
);

-- ---
-- Table 'Language'
-- 
-- ---

DROP TABLE IF EXISTS moviebase.Language;
		
CREATE TABLE moviebase.Language (
  `LanguageId` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`LanguageId`)
);

-- ---
-- Table 'List'
-- 
-- ---

DROP TABLE IF EXISTS moviebase.List;
		
CREATE TABLE moviebase.List (
  `ListId` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(40) NOT NULL,
  `Description` BLOB NOT NULL,
  `UserId` INT NOT NULL,
  PRIMARY KEY (`ListId`)
);

-- ---
-- Table 'CastCrew'
-- 
-- ---

DROP TABLE IF EXISTS moviebase.CastCrew;
		
CREATE TABLE moviebase.CastCrew (
  `CastCrewId` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(70) NOT NULL,
  `LastName` VARCHAR(70) NOT NULL,
  `CastCrewTypeId` INT NOT NULL,
  PRIMARY KEY (`CastCrewId`)
);

-- ---
-- Table 'MediaStreamingService'
-- 
-- ---

DROP TABLE IF EXISTS moviebase.MediaStreamingService;
		
CREATE TABLE moviebase.MediaStreamingService (
  `MediaId` INT NOT NULL,
  `StreamingServiceId` INT NOT NULL,
  PRIMARY KEY (`MediaId`, `StreamingServiceId`)
);

-- ---
-- Table 'MediaGenre'
-- 
-- ---

DROP TABLE IF EXISTS moviebase.MediaGenre;
		
CREATE TABLE moviebase.MediaGenre (
  `MediaId` INT NOT NULL AUTO_INCREMENT,
  `GenreId` INT NOT NULL,
  PRIMARY KEY (`MediaId`, `GenreId`)
);

-- ---
-- Table 'CastCrewType'
-- 
-- ---

DROP TABLE IF EXISTS moviebase.CastCrewType;
		
CREATE TABLE moviebase.CastCrewType (
  `CastCrewTypeId` INT NOT NULL AUTO_INCREMENT,
  `Type` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`CastCrewTypeId`)
);

-- ---
-- Table 'MediaCastCrew'
-- 
-- ---

DROP TABLE IF EXISTS moviebase.MediaCastCrew;
		
CREATE TABLE moviebase.MediaCastCrew (
  `MediaId` INT NOT NULL AUTO_INCREMENT,
  `CastCrewId` INT NOT NULL,
  PRIMARY KEY (`MediaId`, `CastCrewId`)
);

-- ---
-- Table 'MediaList'
-- 
-- ---

DROP TABLE IF EXISTS moviebase.MediaList;
		
CREATE TABLE moviebase.MediaList (
  `MediaId` INT NOT NULL,
  `ListId` INT NOT NULL,
  PRIMARY KEY (`MediaId`, `ListId`)
);

-- ---
-- Table 'AgeRatingType'
-- 
-- ---

DROP TABLE IF EXISTS moviebase.AgeRatingType;
		
CREATE TABLE moviebase.AgeRatingType (
  `AgeRatingTypeId` INT NOT NULL AUTO_INCREMENT,
  `Type` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`AgeRatingTypeId`)
);

-- ---
-- Foreign Keys 
-- ---

ALTER TABLE moviebase.Media ADD FOREIGN KEY (MediaTypeId) REFERENCES moviebase.MediaType (`MediaTypeId`);
ALTER TABLE moviebase.Media ADD FOREIGN KEY (PublisherId) REFERENCES moviebase.Publisher (`PublisherId`);
ALTER TABLE moviebase.Media ADD FOREIGN KEY (LanguageId) REFERENCES moviebase.Language (`LanguageId`);
ALTER TABLE moviebase.Media ADD FOREIGN KEY (AgeRatingId) REFERENCES moviebase.AgeRating (`AgeRatingId`);
ALTER TABLE moviebase.AgeRating ADD FOREIGN KEY (AgeRatingTypeId) REFERENCES moviebase.AgeRatingType (`AgeRatingTypeId`);
ALTER TABLE moviebase.Review ADD FOREIGN KEY (MediaId) REFERENCES moviebase.Media (`MediaId`);
ALTER TABLE moviebase.Review ADD FOREIGN KEY (UserId) REFERENCES moviebase.User (`UserId`);
ALTER TABLE moviebase.List ADD FOREIGN KEY (UserId) REFERENCES moviebase.User (`UserId`);
ALTER TABLE moviebase.CastCrew ADD FOREIGN KEY (CastCrewTypeId) REFERENCES moviebase.CastCrewType (`CastCrewTypeId`);
ALTER TABLE moviebase.MediaStreamingService ADD FOREIGN KEY (MediaId) REFERENCES moviebase.Media (`MediaId`);
ALTER TABLE moviebase.MediaStreamingService ADD FOREIGN KEY (StreamingServiceId) REFERENCES moviebase.StreamingService (`StreamingServiceId`);
ALTER TABLE moviebase.MediaGenre ADD FOREIGN KEY (MediaId) REFERENCES moviebase.Media (`MediaId`);
ALTER TABLE moviebase.MediaGenre ADD FOREIGN KEY (GenreId) REFERENCES moviebase.Genre (`GenreId`);
ALTER TABLE moviebase.MediaCastCrew ADD FOREIGN KEY (MediaId) REFERENCES moviebase.Media (`MediaId`);
ALTER TABLE moviebase.MediaCastCrew ADD FOREIGN KEY (CastCrewId) REFERENCES moviebase.CastCrew (`CastCrewId`);
ALTER TABLE moviebase.MediaList ADD FOREIGN KEY (MediaId) REFERENCES moviebase.Media (`MediaId`);
ALTER TABLE moviebase.MediaList ADD FOREIGN KEY (ListId) REFERENCES moviebase.List (`ListId`);

-- ---
-- Table Properties
-- ---

-- ALTER TABLE `User` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Media` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `MediaType` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Publisher` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `StreamingService` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Genre` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `AgeRating` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Review` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Language` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `List` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `CastCrew` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `MediaStreamingService` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `MediaGenre` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `CastCrewType` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `MediaCastCrew` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `MediaList` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `AgeRatingType` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ---
-- Test Data
-- ---

INSERT INTO moviebase.CastCrewType (CastCrewTypeId, Type) VALUES
(1, 'Actor'),
(2, 'Director'),
(3, 'Writer'),
(4, 'Producer'),
(5, 'Cinematographer');

INSERT INTO moviebase.Genre (GenreId, Name) VALUES
(1, 'Action'),
(2, 'Science Fiction'),
(3, 'Romance'),
(4, 'Comedy'),
(5, 'Fantasy');

INSERT INTO moviebase.StreamingService (StreamingServiceId, Name) VALUES
(1, 'StreamFlix'),
(2, 'GalacticStream'),
(3, 'RomanceStream'),
(4, 'ComedyHub'),
(5, 'FantasyVision');

INSERT INTO moviebase.MediaType (MediaTypeId, Name) VALUES
(1, 'Movie'),
(2, 'Series');

INSERT INTO moviebase.Publisher (PublisherId, Name) VALUES
(1, 'DreamWave Studios'),
(2, 'Galactic Media Group'),
(3, 'Eternal Romance Productions'),
(4, 'LaughCraft Entertainment'),
(5, 'FantasyRealms Studios');

INSERT INTO moviebase.Language (LanguageId, Name) VALUES
(1, 'English'),
(2, 'Spanish'),
(3, 'French'),
(4, 'Mandarin'),
(5, 'German');

INSERT INTO moviebase.AgeRatingType (AgeRatingTypeId, Type) VALUES
(1, 'G'),
(2, 'PG'),
(3, 'PG-13'),
(4, 'R');

INSERT INTO moviebase.CastCrew (CastCrewId, FirstName, LastName, CastCrewTypeId) VALUES
(1, 'John', 'Smith', 1),
(2, 'Emma', 'Johnson', 1),
(3, 'Michael', 'Williams', 1),
(4, 'Sophia', 'Jones', 1),
(5, 'Daniel', 'Brown', 1),
(6, 'Olivia', 'Davis', 1),
(7, 'Matthew', 'Miller', 1),
(8, 'Ava', 'Anderson', 1),
(9, 'Christopher', 'Taylor', 1),
(10, 'Emily', 'Moore', 1),
(11, 'Nicholas', 'Harris', 1),
(12, 'Grace', 'Martin', 1),
(13, 'Ethan', 'Thompson', 1),
(14, 'Chloe', 'White', 1),
(15, 'Ryan', 'Walker', 1),
(16, 'Mia', 'Evans', 1),
(17, 'David', 'Turner', 1),
(18, 'Isabella', 'Baker', 1),
(19, 'Andrew', 'Garcia', 1),
(20, 'Amelia', 'Lee', 1),
(21, 'Logan', 'Lopez', 1),
(22, 'Sofia', 'Clark', 1),
(23, 'Joseph', 'King', 1),
(24, 'Lily', 'Green', 1),
(25, 'James', 'Ward', 1),
(26, 'Avery', 'Hill', 1),
(27, 'Benjamin', 'Cooper', 1),
(28, 'Aria', 'Perez', 1),
(29, 'Jackson', 'Taylor', 1),
(30, 'Ella', 'Wilson', 1),
(31, 'Christopher', 'Anderson', 2),
(32, 'Sophie', 'Hill', 2),
(33, 'David', 'Bennett', 2),
(34, 'Emma', 'Carter', 2),
(35, 'Benjamin', 'Fisher', 2),
(36, 'Grace', 'Barnes', 3),
(37, 'Alexander', 'Mitchell', 3),
(38, 'Ava', 'Robinson', 3),
(39, 'Lucas', 'Turner', 3),
(40, 'Chloe', 'Foster', 3),
(41, 'Daniel', 'Adams', 4),
(42, 'Mia', 'Wright', 4),
(43, 'Matthew', 'Harrison', 4),
(44, 'Lily', 'Diaz', 4),
(45, 'Ryan', 'Russell', 4),
(46, 'Ethan', 'Murray', 5),
(47, 'Aria', 'Simmons', 5),
(48, 'Logan', 'Stewart', 5),
(49, 'Isabella', 'Wood', 5),
(50, 'Jackson', 'Griffin', 5);

INSERT INTO moviebase.AgeRating (AgeRatingId, Description, AgeRatingTypeId) VALUES
(1, 'Mild Violence, Some Tense Scenes', 2),
(2, 'Explicit Violence, Strong Language, Drug Use', 4),
(3, 'Some Adult Themes, Brief Nudity', 3),
(4, 'Minor Language, Some Tense Scenes', 2),
(5, 'Mild Violence, Minor Language', 2),
(6, 'Moderate Violence, Infrequent Strong Language', 3),
(7, 'Educational Themes, No Intense Action', 1),
(8, 'Infrequent Strong Language, Mature Humor', 3),
(9, 'No Inappropriate Content, No Intense Action', 1),
(10, 'Moderate Violence, Infrequent Strong Language', 3),
(11, 'Positive Role Models, No Intense Action', 1),
(12, 'Infrequent Strong Language, Mature Humor', 3),
(13, 'Explicit Violence, Intense Adult Themes', 4),
(14, 'Explicit Violence, Strong Language', 4),
(15, 'Infrequent Strong Language, Mature Humor', 3),
(16, 'Moderate Violence, Brief Nudity', 3),
(17, 'Educational Themes, No Intense Action', 1),
(18, 'Mild Violence, Some Tense Scenes', 2),
(19, 'Some Humor Risks, Innocent Romance', 2),
(20, 'Strong Language, Intense Adult Themes', 4);

INSERT INTO moviebase.User (UserId, FirstName, LastName, Email, Password, Salt) VALUES 
(1, 'Brett', 'Reier', 'bpreier@ncsu.edu', 'd2ffff9db3c6a2b8b5f9527d0430618440ede421d39687f710d46047079868c1', 'd463f0488621c6d76dbdc0f3bf9d1014ce9e77a498c65a1ba1a0157b42a22aba'),
(2, 'Chris', 'Zavala', 'czavala2@ncsu.edu', 'da9ebb6aa5f07cb2dd7b0658e765df5e711cc9e7a291bed4ac75a2738ffd7da6', '606006c46fa59fd29ff88917f05e52b2a4602f40272f469efd8119f944da44ef'),
(3, 'Jaden', 'Jenkins', 'jajenki6@ncsu.edu', '1c9fb255186e825191d400abc6c365aee6a0276e3f02cdc6a3d2941ec3089299', 'b56e03deba5fc5200545cd673db63ea888b433d64e3dccb73f50c7134ce46b8e'),
(4, 'Michael', 'Abrams', 'msabrams@ncsu.edu', '23e59ea0cfd884a6e636f09ce4c05bd75d6504400778f61a37392461ef0d2cb5', '54c608dec2e748157fc666815d3716b7c6f4e363c51552ad9c91cfe27b7c0b90'),
(5, 'Noah', 'Thomas', 'nbthomas@ncsu.edu', 'cdcd88e2edeeae0290e21bd339f0dcf4a7f210a61d325a00c11b81df23d22be6', '66901622c50a5ff32dd993fb43ab6833b0a5838085f8b2a8c7ccc09aa1fbf9e3');

INSERT INTO moviebase.List (ListId, Name, Description, UserId) VALUES 
(1, 'Watchlist', 'This is a list of media you have watched.', 1),
(2, 'Watchlist', 'This is a list of media you have watched.', 2),
(3, 'Watchlist', 'This is a list of media you have watched.', 3),
(4, 'Watchlist', 'This is a list of media you have watched.', 4),
(5, 'Watchlist', 'This is a list of media you have watched.', 5);

INSERT INTO moviebase.Media (MediaId, Title, Description, ReleaseDate, RunTime, AverageRating, Poster, MediaTypeId, PublisherId, LanguageId, AgeRatingId) VALUES
(1, 'The Lost City', 'A thrilling adventure in a mysterious city', '2023-02-10', 3600000, 8.0, 'https://i.imgur.com/kLhG8In.jpg', 1, 5, 1, 1),
(2, 'Galactic Odyssey', 'Space epic with intergalactic battles', '2023-05-15', 5400000, 9.0, 'https://i.imgur.com/ptndfHJ.jpg', 1, 2, 1, 2),
(3, 'Timeless Love', 'A romantic tale transcending time and space', '2022-08-22', 7200000, 6.0, 'https://i.imgur.com/2o1z3NS.jpg', 1, 3, 1, 3),
(4, 'Quantum Conundrum', 'Mind-bending sci-fi exploration', '2023-04-05', 9000000, 7.0, 'https://i.imgur.com/jzMETUO.jpg', 1, 2, 2, 4),
(5, 'Hidden Realms', 'Discover the secrets of hidden realms', '2022-11-30', 10800000, 8.0, 'https://i.imgur.com/T7HR2Di.jpg', 1, 5, 3, 5),
(6, 'Eternal Enigma', 'Mystery and suspense in a timeless setting', '2023-07-18', 900000, 5.0, 'https://i.imgur.com/p1K9wC6.jpg', 2, 5, 5, 6),
(7, 'Beyond the Horizon', 'Exploration and adventure beyond known boundaries', '2022-03-08', 12600000, 9.0, 'https://i.imgur.com/1PopNpO.jpg', 1, 2, 1, 7),
(8, 'Code Breakers', 'Thrilling espionage and code-breaking', '2023-01-12', 8100000, 6.0, 'https://i.imgur.com/pcPHXC7.jpg', 1, 1, 2, 8),
(9, 'Dreamscape Chronicles', 'Journey through fantastical dreamscapes', '2022-06-25', 1800000, 8.0, 'https://i.imgur.com/7t32mNk.jpg', 2, 1, 3, 9),
(10, 'Chronicles of Destiny', 'Epic saga of heroes and villains', '2023-09-20', 9900000, 7.0, 'https://i.imgur.com/jIRsQaX.jpg', 1, 5, 1, 10),
(11, 'Lost in Translation', 'Hilarious comedy of linguistic misunderstandings', '2022-04-14', 7560000, 4.0, 'https://i.imgur.com/5SbCvbY.jpg', 1, 4, 1, 11),
(12, 'Infinite Loop', 'Sci-fi adventure with time loops and paradoxes', '2023-11-08', 3600000, 9.0, 'https://i.imgur.com/qXp7oRC.jpg', 2, 2, 2, 12),
(13, 'Whispers in the Dark', 'Suspenseful thriller set in a haunted mansion', '2022-09-17', 10080000, 7.0, 'https://i.imgur.com/XAX2Zzb.jpg', 1, 1, 4, 13),
(14, 'Crimson Skies', 'Action-packed aerial battles in a dystopian future', '2023-03-27', 6300000, 8.0, 'https://i.imgur.com/1liMxwG.jpg', 1, 1, 2, 14),
(15, 'Renaissance Riddles', 'Puzzle-solving adventure in the Renaissance era', '2022-12-03', 1800000, 6.0, 'https://i.imgur.com/YNZKwdL.jpg', 2, 5, 3, 15),
(16, 'Neon Nights', 'Cyberpunk noir with neon-soaked cityscapes', '2023-06-10', 8280000, 9.0, 'https://i.imgur.com/rcIxz10.jpg', 1, 1, 1, 16),
(17, 'The Enchanted Forest', 'Fantasy adventure through a magical forest', '2022-10-28', 9360000, 7.0, 'https://i.imgur.com/PeJbf5J.jpg', 1, 5, 5, 17),
(18, 'Digital Mirage', 'Virtual reality thriller in a digital world', '2023-02-28', 3600000, 8.0, 'https://i.imgur.com/lpOxsg2.jpg', 2, 1, 2, 18),
(19, 'Lost and Found', 'Heartwarming drama of self-discovery and friendship', '2022-07-11', 7920000, 5.0, 'https://i.imgur.com/rY4Qhck.jpg', 1, 3, 3, 19),
(20, 'Spectral Shadows', 'Comical mystery with ghostly apparitions', '2023-10-15', 900000, 3.0, 'https://i.imgur.com/YknH26F.jpg', 2, 4, 4, 20);

INSERT INTO moviebase.Review (ReviewId, Description, Rating, MediaId, UserId) VALUES 
(1, 'This thrilling adventure successfully combines mystery and excitement as characters delve into a mysterious city. The plot unfolds with unexpected twists and turns, keeping audiences engaged.', 8.0, 1, 1),
(2, 'A visually stunning space epic that delivers on its promise of intergalactic battles. The special effects are top-notch, and the narrative offers a gripping journey across the cosmos.', 9.0, 2, 1),
(3, 'While the romantic tale attempts to transcend time and space, it falls into some clichés. The chemistry between the leads saves it from mediocrity, but the plot lacks innovation.', 6.0, 3, 1),
(4, 'This mind-bending sci-fi exploration offers a unique take on the genre. The intricacies of quantum mechanics are fascinating, but the plot occasionally gets too convoluted.', 7.0, 4, 1),
(5, 'As promised, Hidden Realms successfully delivers the secrets of unseen worlds. The visuals are stunning, and the narrative is both captivating and educational.', 8.0, 5, 2),
(6, 'Despite an intriguing premise of mystery and suspense in a timeless setting, the execution falls short. The pacing is uneven, leaving some loose ends unresolved.', 5.0, 6, 2),
(7, 'A thrilling exploration that goes beyond known boundaries. The adventurous spirit is palpable, and the cinematography captures the awe of undiscovered territories.', 9.0, 7, 2),
(8, 'While the espionage and code-breaking elements add intrigue, the plot lacks depth. The characters feel one-dimensional, and the twists are predictable.', 6.0, 8, 2),
(9, 'Journeying through fantastical dreamscapes proves to be a visually stunning and emotionally resonant experience. The creativity on display is commendable.', 8.0, 9, 3),
(10, 'This epic saga of heroes and villains has its moments, but some characters lack development, and the plot occasionally loses focus.', 7.0, 10, 3),
(11, 'Despite attempts at humor through linguistic misunderstandings, the comedy falls flat. The gags become repetitive, and the film struggles to maintain momentum.', 4.0, 11, 3),
(12, 'A mind-bending sci-fi adventure that successfully explores time loops and paradoxes. The plot is intricate yet accessible, and the resolution is satisfying.', 9.0, 12, 3),
(13, 'This suspenseful thriller set in a haunted mansion delivers some chilling moments, but the reliance on horror tropes feels overdone.', 7.0, 13, 4),
(14, 'Action-packed aerial battles in a dystopian future make for a visually stunning experience. The world-building is impressive, even if the plot is somewhat formulaic.', 8.0, 14, 4),
(15, 'While the puzzle-solving adventure in the Renaissance era has its charm, the plot lacks the necessary depth to fully engage the audience.', 6.0, 15, 4),
(16, 'This cyberpunk noir with neon-soaked cityscapes is a visual feast. The gripping storyline and well-developed characters contribute to its overall success.', 9.0, 16, 4),
(17, 'A fantasy adventure through a magical forest is visually enchanting, but the plot occasionally feels predictable and lacks originality.', 7.0, 17, 5),
(18, 'The virtual reality thriller in a digital world offers a captivating exploration of the consequences of technology. The suspense is well-maintained, and the concept is thought-provoking.', 8.0, 18, 5),
(19, 'While attempting to be a heartwarming drama of self-discovery and friendship, the film succumbs to clichés, and the emotional beats feel forced.', 5.0, 19, 5),
(20, 'Despite attempts at comical mystery with ghostly apparitions, the humor misses the mark, and the plot lacks coherence. It struggles to find the right balance between comedy and mystery.', 3.0, 20, 5);

INSERT INTO moviebase.MediaList (MediaId, ListId) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 2),
(6, 2),
(7, 2),
(8, 2), 
(9, 3), 
(10, 3),
(11, 3), 
(12, 3), 
(13, 4),
(14, 4),
(15, 4), 
(16, 4), 
(17, 5), 
(18, 5),
(19, 5), 
(20, 5);

INSERT INTO moviebase.MediaGenre (MediaId, GenreId) VALUES
(1, 1), (1, 5),
(2, 1), (2, 2),
(3, 2), (3, 3),
(4, 2), (4, 5),
(5, 2), (5, 5),
(6, 1), (6, 5),
(7, 1), (7, 5),
(8, 1), 
(9, 5), 
(10, 1), (10, 5),
(11, 4), 
(12, 2), 
(13, 1), (13, 5),
(14, 1), (14, 2),
(15, 5), 
(16, 2), 
(17, 5), 
(18, 1), (18, 2),
(19, 3), 
(20, 2), (20, 4);

INSERT INTO moviebase.MediaStreamingService (MediaId, StreamingServiceId) VALUES
(1, 1), (1, 5),
(2, 1), (2, 2),
(3, 2), (3, 3),
(4, 2), (4, 5),
(5, 2), (5, 5),
(6, 1), (6, 5),
(7, 1), (7, 5),
(8, 1), 
(9, 5), 
(10, 1), (10, 5),
(11, 4), 
(12, 2), 
(13, 1), (13, 5),
(14, 1), (14, 2),
(15, 5), 
(16, 2), 
(17, 5), 
(18, 1), (18, 2),
(19, 3), 
(20, 2), (20, 4);

INSERT INTO moviebase.MediaCastCrew (MediaId, CastCrewId) VALUES
(1, 1), (1, 2), (1, 3), (1, 31), (1, 36), (1, 41), (1, 46),
(2, 1), (2, 11), (2, 21), (2, 32), (2, 37), (2, 42), (2, 47),
(3, 4), (3, 5), (3, 6), (3, 33), (3, 38), (3, 43), (3, 48),
(4, 2), (4, 12), (4, 22), (4, 34), (4, 39), (4, 44), (4, 49),
(5, 7), (5, 8), (5, 9), (5, 35), (5, 40), (5, 45), (5, 50),
(6, 3), (6, 13), (6, 23), (6, 31), (6, 40), (6, 45), (6, 50),
(7, 10), (7, 11), (7, 12), (7, 32), (7, 39), (7, 44), (7, 49),
(8, 4), (8, 14), (8, 24), (8, 33), (8, 38), (8, 43), (8, 48),
(9, 13), (9, 14), (9, 15), (9, 34), (9, 37), (9, 42), (9, 47),
(10, 5), (10, 15), (10, 25), (10, 35), (10, 36), (10, 41), (10, 46),
(11, 16), (11, 17), (11, 18), (11, 31), (11, 38), (11, 43), (11, 48),
(12, 6), (12, 16), (12, 26), (12, 32), (12, 37), (12, 42), (12, 47),
(13, 19), (13, 20), (13, 21), (13, 33), (13, 39), (13, 44), (13, 49),
(14, 7), (14, 17), (14, 27), (14, 34), (14, 36), (14, 41), (14, 46),
(15, 22), (15, 23), (15, 24), (15, 35), (15, 40), (15, 45), (15, 50),
(16, 8), (16, 18), (16, 28), (16, 31), (16, 37), (16, 42), (16, 47),
(17, 25), (17, 26), (17, 27), (17, 32), (17, 39), (17, 44), (17, 49),
(18, 9), (18, 19), (18, 29), (18, 33), (18, 40), (18, 45), (18, 50),
(19, 28), (19, 29), (19, 30), (19, 34), (19, 36), (19, 41), (19, 46),
(20, 10), (20, 20), (20, 30), (20, 35), (20, 38), (20, 43), (20, 48);