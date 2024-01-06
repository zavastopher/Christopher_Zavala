# Wolf Watch

Wolf Watch is a web application that provides a centralized location for faculty to monitor their assignments for presence on cheating sites.

# How this project works

This project has five main docker containers that work together to execute the goal of scanning for instruction materials on websites.

## API

This folder contains all of the code used for operating the "backend" logic for Wolfwatch. This includes an ORM through the use of MySQLAlchemy, API written in python, and several helper scripts used to assist in the communication between the API end points and database. 

## Client

This folder  contains all of the code used for the "client" for Wolfwatch. The frontend is written in the NextJS framework with MaterialUI elements used for the page rendering. It communicates with the backend using API routes defined by the python backend

## Database

This folder contains all of the SQL scripts used for initializing the Database. This script is written with a MySQL database in mind.

## Nginx

This folder contains all of the code used for configurating the reverse proxy to properly route the API and client calls.

## Scraping

This folder contains all of the code used for scraping, currently only scraping chegg. This includes a super class that is to be used for crating additional scraper classes. 

## Overall Setup

This application works by having the client handle all user interaction and sending requests to the backend through the api calls. The backend then communicates with a scraper  manager and the database to manage assignments and user preferences that are stored in the database. There is a Celery scheduler that manages scans for scanning workers that scan specific sites.

# My Contributions (Chris Zavala)

For this project I worked on every facet of the application. I contributed the landing page to the frontend, Created the ORM files used for interacting with the database, Created te scripts for initializing the database, worked on updating the scraper, and worked on configuring the proxy and dockerization to work with the database. I also contributed significantly to documentation such as User Guides, Dev Guidesm, and overall documentation which was delivered to the sponsor and teaching staff. I also worked on presentations meant to communicate our progress and design.