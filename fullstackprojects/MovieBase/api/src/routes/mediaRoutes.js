const express = require('express');
const db = require('../DBConnect.js');
const router = express.Router();
const {checkSession, stopSession, startSession} = require('../token.js');


module.exports = router;

// Get Specific Media Info
router.get('/:mediaId', async (req, res) => {
    const mediaId = req.params.mediaId;

    const query = "SELECT Media.MediaId, Title, CAST(Media.Description AS CHAR) AS Description, ReleaseDate, RunTime, AverageRating, CAST(Poster AS CHAR) AS Poster, MediaType.Name AS MediaType, Publisher.Name AS Publisher, Language.Name AS Language, AgeRatingType.Type AS AgeRatingType, CAST(AgeRating.Description AS CHAR) AS AgeRatingDescription, GROUP_CONCAT(DISTINCT Genre.Name) AS Genre, GROUP_CONCAT(DISTINCT StreamingService.Name) AS StreamingService, GROUP_CONCAT(DISTINCT CONCAT(CastCrewType.Type, ': ', CastCrew.FirstName, ' ', CastCrew.LastName)) AS CastCrew FROM Media JOIN MediaType ON Media.MediaTypeId = MediaType.MediaTypeId JOIN Publisher ON Media.PublisherId = Publisher.PublisherId JOIN Language ON Media.LanguageId = Language.LanguageId JOIN AgeRating ON Media.AgeRatingId = AgeRating.AgeRatingId JOIN AgeRatingType ON AgeRating.AgeRatingTypeId = AgeRatingType.AgeRatingTypeId JOIN MediaGenre ON Media.MediaId = MediaGenre.MediaId JOIN Genre ON MediaGenre.GenreId = Genre.GenreId JOIN MediaStreamingService ON Media.MediaId = MediaStreamingService.MediaId JOIN StreamingService ON MediaStreamingService.StreamingServiceId = StreamingService.StreamingServiceId JOIN MediaCastCrew ON Media.MediaId = MediaCastCrew.MediaId JOIN CastCrew ON MediaCastCrew.CastCrewId = CastCrew.CastCrewId JOIN CastCrewType ON CastCrew.CastCrewTypeId = CastCrewType.CastCrewTypeId WHERE Media.MediaId = ?";
    
    db.query(query,[mediaId]).then(results => {
        return res.status(200).json({data: results});
    });
});