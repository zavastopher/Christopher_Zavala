import APIClient from "./APIClient.js";
import api from "./APIClient.js"
import HTMLElementBuilder from "./HTMLElementBuilder.js";

const user = await APIClient.currentUser();

// Set the text of the user's email in the header
document.getElementById("email-header").textContent  = user.email;


// Get all the media in the database
let mediaRequest = await api.fetchAllMedia();
let movies = mediaRequest.data.results;
console.log(movies);

// Get all of the media types in the database
let mediaTypesRequest = await api.fetchMediaTypes();
let mediaTypes = mediaTypesRequest.data.results;
console.log(mediaTypes);

// Get all of the ageratings
let ageRatingsRequest = await api.fetchAgeRatings();
let ageRatings = ageRatingsRequest.data.results;
console.log(ageRatings);

// Get all of the languages
let languagesRequest = await api.fetchLanguages();
let languages = languagesRequest.data.results;
console.log(languages);
console.log(languages[0].Name)

// Get all of the streaming services
let genreRequest = await api.fetchGenres();
let genres = genreRequest.data.results;
console.log(genres);

async function submitReview(event, userId, mediaId, review_exists) {
    // Prevent the form from submitting the traditional way
    event.preventDefault();

    // Access the form element using the event
    const form = event.target;

    // Access the input values using the form's elements property
    const description = form.elements['review-description'].value;
    const rating = form.elements['review-rating'].value;


    console.log(description, rating, userId, mediaId, review_exists)
    try {
        if (review_exists > 0) {
            // Update review
            await api.updateReview(userId, mediaId, description, rating);
        } else {
            // Post review
            await api.postReview(userId, mediaId, description, rating);
        }

        // Only reload after the asynchronous operation is complete
        location.reload();
    } catch (error) {
        console.log(error);
        // Handle errors here if needed
    }

    return false;
}
function toggleWatchList(media) {
    const watchLaterBtn = document.getElementById(`watch-later-${media.MediaId}`);
    // Get the <i> element within the button
    const iconElement = watchLaterBtn.querySelector('i');
    const hasClockIcon = iconElement.classList.contains('fa-regular');
    watchLaterBtn.removeChild(watchLaterBtn.children[0]);

    if(hasClockIcon) {
        APIClient.addWatchList(user.id, media.MediaId).then(response => {
            const xIcon = new HTMLElementBuilder('i').setAttribute('class', 'fa-solid fa-x').build();
            watchLaterBtn.appendChild(xIcon);
        })
        .catch(error => {
            console.log(error);
        })
    }
    else {
        APIClient.removeWatchList(user.id, media.MediaId).then(response => {
            const clockIcon = new HTMLElementBuilder('i').setAttribute('class', 'fa-regular fa-clock').build();
            watchLaterBtn.appendChild(clockIcon);
        })
        .catch(error => {
            console.log(error);
        })
    }
}

export function buildMediaCard(movie) {
    return `<div class="card m-5" data-bs-toggle="modal" data-bs-target="#modal${movie.MediaId}" style="width: 18rem;">
                <img src=${movie.Poster} class="card-img-top" alt="...">
                <div class="card-body">
                    <h5 class="card-title">${movie.Title}</h5>
                </div>
            </div>`;
}

let body = document.getElementById("card-container");

body.addEventListener('submit', function (event) {
    // Check if the submitted form has the class 'create-review-form'
    if (event.target.classList.contains('create-review-form')) {
        // Prevent the form from submitting the traditional way
        event.preventDefault();

        // Retrieve the mediaId from the data attribute
        const mediaId = event.target.getAttribute('data-media-id');

        // Get if a review exists from the data attribute
        const review_exists = event.target.getAttribute('data-review-exists');

        // Call the submitReview function with the correct mediaId
        submitReview(event, user.id, mediaId, review_exists);
    }
    return false;
});

export async function buildModal(movie, reviews) {
    let ageRating = `${movie.AgeRatingType}\n${movie.AgeRatingDescription}`;
    let averageRating = movie.AverageRating;
    let castCrew = movie.CastCrew.replaceAll(',', '<br>');
    let description = movie.Description;
    let genre = movie.Genre;
    let language = movie.Language;
    let mediaId = movie.MediaId;
    let mediaType = movie.MediaType;
    let poster = movie.Poster;
    let publisherId = movie.Publisher;
    let releaseDate = movie.ReleaseDate.slice(0, -14);
    let runTime = movie.RunTime / 60000;
    let streamingServices = movie.StreamingService.replaceAll(',', '<br>');
    let title =  movie.Title;
    let reviewsText = '';

    let initialReviewDescription = ""
    let initialReviewRating;
    let review_exists = 0;
    // Get the review of the media
    try {
        const response = await api.fetchReview(user.id, mediaId);
        if (response.data.results[0]) {
            console.log("review:",response.data.results[0].Description);
            const descriptionArray = response.data.results[0].Description.data;
            let uint8Array = new Uint8Array(descriptionArray);
            initialReviewDescription = new TextDecoder("utf-8").decode(uint8Array);
            initialReviewRating = response.data.results[0].Rating;
            review_exists = 1;
        }
    } catch (error) {
        console.error(error);
    }
    
    for(const [key, value] of Object.entries(reviews)) {
        let userRequest = await api.fetchUserById(value.UserId);
        console.log(userRequest);
        let user = userRequest.data.results[0];
        let uint8Array = new Uint8Array(value.Description.data);
        let initialDescription = new TextDecoder("utf-8").decode(uint8Array);
        console.log(initialDescription);
        reviewsText += `<li class="list-group-item review-item">
                            <div class="d-flex align-items-center justify-content-between me-5">
                            <h5>${user.FirstName} ${user.LastName}</h5>
                            <h5><i class="fa-solid fa-star"></i> ${value.Rating}</h5>
                            </div>
                            <p>${initialDescription}</p>
                        </li>`
    }
    // let genres = await api.fetchMediaGenres(mediaId);
    // console.log(genres.data.results)
    return `<div class="modal" id="modal${movie.MediaId}" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered modal-xl">
                <div class="modal-content">
                <div class="modal-body">
                    <div class="d-flex gap-3">
                    <div>
                        <img src=${poster} id="movie-poster" class="card-img-top" alt="...">
                        <table class="table">
                        <tbody>
                            <tr>
                            <th scope="row">Release Date</th>
                            <td>${releaseDate}</td>
                            </tr>
                            <tr>
                            <th scope="row">Runtime</th>
                            <td>${runTime}</td>
                            </tr>
                            <tr>
                            <th scope="row">Media Type</th>
                            <td>${mediaType}</td>
                            </tr>
                            <tr>
                            <th scope="row">Publisher</th>
                            <td>${publisherId}</td>
                            </tr>
                            <tr>
                            <th scope="row">Language</th>
                            <td>${language}</td>
                            </tr>
                            <tr>
                            <th scope="row">Age Rating</th>
                            <td>${ageRating}</td>
                            </tr>
                            <tr>
                            <th scope="row">Streaming Services</th>
                            <td>${streamingServices}</td>
                            </tr>
                            <tr>
                            <th scope="row">Cast & Crew</th>
                            <td>${castCrew}</td>
                            </tr>
                            <tr>
                            <th scope="row">Genres</th>
                            <td>${genre}</td>
                            </tr>
                        </tbody>
                        </table>
                        <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">My Review</h5>
                            <form class="create-review-form" data-media-id="${mediaId}" data-review-exists="${review_exists}"> 
                                <div class="mb-3">
                                    <label for="review-description" class="form-label">Description</label>
                                    <textarea class="form-control" id="review-description" rows="4" placeholder="Enter a description for your review" required>${initialReviewDescription}</textarea>                                
                                </div>
                                <div class="mb-3">
                                    <label for="review-rating" class="form-label">Rating</label>
                                    <input type="number" class="form-control" id="review-rating" placeholder="Enter a rating for your review" value="${initialReviewRating}" min="1" max="10" required>
                                </div>
                            <button type="submit" class="btn btn-primary" id="submit" >Submit Review</button>
                            </form>
                        </div>
                    </div>
                    </div>
                    <div class="d-flex flex-column w-100">
                        <div class="d-flex align-items-center justify-content-between me-5">
                        <h1>${title}</h1>
                        <h3><i class="fa-solid fa-star"></i> ${averageRating}</h3>
                        </div>
                        <p>${description}</p>
                        <h3>Reviews</h3>
                        <ul class="list-group reviews h-100">
                        ${reviewsText}
                        </ul>
                    </div>
                    </div>
                </div>
                <div class="modal-footer" id="modal-footer-${movie.MediaId}">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
                </div>
            </div>
            </div>`
}

function clearMedia() { 
    const body = document.getElementById("card-container");

    while(body.hasChildNodes()) {
        body.removeChild(body.childNodes[0]);
    }
}

export async function loadMedia(movies, fromWatchList) {
    
    clearMedia();

    // Create a card and modal for each media entry
    let col = 0;
    let mediaCount = 0;
    let body = document.getElementById("card-container");
    const userList = await APIClient.fetchUserList(user.id);

    for(const [key, value] of Object.entries(movies)) {
        console.log(value)
        let mediaResponse = await api.fetchMedia(value.MediaId);
        let media = mediaResponse.data.results[0];
        let reviewsResponse = await api.fetchReviews(value.MediaId);
        let reviews = reviewsResponse.data.results;
        let inWatchList = userList.data.results.some(userMedia => userMedia.MediaId === media.MediaId);
        

        body.insertAdjacentHTML('beforeend', buildMediaCard(media));
        body.insertAdjacentHTML('beforeend', await buildModal(media, reviews));

        const modalFooter = document.getElementById(`modal-footer-${media.MediaId}`);

        if(inWatchList) {
            modalFooter.innerHTML += `<button id="watch-later-${media.MediaId}" class="btn btn-primary"><i class="fa-solid fa-x"></i></button>`
        }
        else {
            modalFooter.innerHTML += `<button id="watch-later-${media.MediaId}" class="btn btn-primary"><i class="fa-regular fa-clock"></i></button>`
        }

        document.getElementById(`watch-later-${media.MediaId}`).addEventListener("click", _ => {
            toggleWatchList(media);
        })

        const modal = new bootstrap.Modal(document.getElementById(`modal${media.MediaId}`));

        // Add an event listener for the hidden.bs.modal event
        modal._element.addEventListener('hidden.bs.modal', async function () {
            if(fromWatchList) {
                const response = await APIClient.fetchUserList(user.id);
                loadMedia(response.data.results, true)
            }
        });

        mediaCount++;
        col++;
    }
}