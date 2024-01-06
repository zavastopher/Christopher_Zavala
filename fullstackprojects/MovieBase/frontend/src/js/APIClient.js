import HTTPClient from "./HTTPClient.js";

const API_BASE = '/api'

export default {
  createAccount: (firstName, lastName, email, password) => {
    return HTTPClient.post(API_BASE + '/users/createAccount', {firstName, lastName, email, password})
  },
  currentUser: () => {
    return HTTPClient.get(API_BASE + '/users/getCurrentUser');
  },
  login: (email, password) => {
    return HTTPClient.post(API_BASE + '/users/login', {email, password});
  },
  logout: () => {
    return HTTPClient.post(API_BASE + '/users/logout');
  },
  fetchAllMedia: async () => {
    return HTTPClient.get(API_BASE + '/search/media')
  },
  fetchMedia: (mediaId) => {
    return HTTPClient.get(API_BASE + `/media/${mediaId}`);
  },
  fetchMediaTypes: () => {
    return HTTPClient.get(API_BASE + `/search/mediatype`);
  },
  fetchAgeRatings: () => {
    return HTTPClient.get(API_BASE + '/search/agerating');
  },
  fetchLanguages: () => {
    return HTTPClient.get(API_BASE + '/search/language');
  },
  fetchStramingServices: () => {
    return HTTPClient.get(API_BASE + '/search/streaming');
  },
  fetchGenres: () => {
    return HTTPClient.get(API_BASE + '/search/genre');
  },
  fetchMediaGenres: (mediaId) => {
    return HTTPClient.get(API_BASE + `/media/${mediaId}/genres}`);
  },
  fetchReviews: (mediaId) => {
    return HTTPClient.get(API_BASE + `/reviews/${mediaId}`);
  },
  fetchUserById: (userId) => {
    return HTTPClient.get(API_BASE + `/users/${userId}`);
  },
  fetchSearch: (filter, search) => {
    return HTTPClient.post(API_BASE + `/search/search`, {filter, search});
  },
  postReview: (userId, mediaId, description, rating) => {
    return HTTPClient.post(API_BASE + `/reviews/${userId}/${mediaId}`, {description, rating});
  },
  updateReview: (userId, mediaId, description, rating) => {
    return HTTPClient.put(API_BASE + `/reviews/${userId}/${mediaId}`, {description, rating});
  },
  fetchReview: (userId, mediaId) => {
    return HTTPClient.get(API_BASE + `/reviews/${userId}/${mediaId}`);
  },
  addWatchList: (userId, mediaId) => {
    return HTTPClient.post(API_BASE + `/lists/${userId}/watchlist`, {mediaId});
  },
  removeWatchList: (userId, mediaId) => {
    return HTTPClient.delete(API_BASE + `/lists/${userId}/watchlist/${mediaId}`);
  },
  fetchUserList: (userId) => {
    return HTTPClient.get(API_BASE + `/lists/${userId}`);
  }
}
