## About the Project 

This project is meant to be a PWA platform for users to practice their BlackJack without the use of real money. Scores are kept with users starting out with 1000 points each. There is a leader board which updates when a users "Rank" changes as they lose or gain points while playing.

The main goal of the project was to learn how to create and deploy a Progressive Web Application. This included creating the web application with a mobile first design, installability, and graceful offline functionality. This was accomplished by developing the app using NodeJS and Express along with service workers and other javascript libraries.

## API MiddleWare & Database

The API used for the application was written using NodeJS and with REST API design in mind. It works with the middleware to provide authentication and a mariadb database for storing user information.     

## Proxy and Dockerization

The project was build using Docker containers for the different parts of the project mentioned above. There was also a reverse proxy used to manage requests between the client and API.

## Wireframes

This folder contains wireframes that my team designed for the application that as a deliverable for the teaching staff to judge and make suggestions for our proposal.

# My Personal Contributions

I personally worked on every aspect of the project from beginning to end. I focused on implementing the frontend pages and integrating mobile first design using bulma components for designing the project. I also initiated the API routes and debugged them when it came time to connect the frontend to the API routes. I also updated the service worker and manifest for the installability and offline functionality of the application. The game was largely developed by another team member but I was incharge of creating all the endpoints that the game would use to retrieve and update the user point values.