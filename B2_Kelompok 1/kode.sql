CREATE DATABASE IF NOT EXISTS netflix_normalized;
USE netflix_normalized;

CREATE TABLE titles (
    show_id VARCHAR(10) PRIMARY KEY,
    type VARCHAR(50),
    title VARCHAR(255),
    date_added VARCHAR(100),
    release_year INT,
    rating VARCHAR(20),
    duration VARCHAR(50),
    description TEXT
);

CREATE TABLE directors (
    director_id INT PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE title_director (
    show_id VARCHAR(10),
    director_id INT,
    FOREIGN KEY (show_id) REFERENCES titles(show_id),
    FOREIGN KEY (director_id) REFERENCES directors(director_id)
);

CREATE TABLE actors (
    actor_id INT PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE title_actor (
    show_id VARCHAR(10),
    actor_id INT,
    FOREIGN KEY (show_id) REFERENCES titles(show_id),
    FOREIGN KEY (actor_id) REFERENCES actors(actor_id)
);

CREATE TABLE countries (
    country_id INT PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE title_country (
    show_id VARCHAR(10),
    country_id INT,
    FOREIGN KEY (show_id) REFERENCES titles(show_id),
    FOREIGN KEY (country_id) REFERENCES countries(country_id)
);

CREATE TABLE genres (
    genre_id INT PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE title_genre (
    show_id VARCHAR(10),
    genre_id INT,
    FOREIGN KEY (show_id) REFERENCES titles(show_id),
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
);

LOAD DATA INFILE 'C:/Users/LOQ/OneDrive/Documents/mopro/titles.csv'
INTO TABLE titles
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/Users/LOQ/OneDrive/Documents/mopro/directors.csv'
INTO TABLE directors
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/Users/LOQ/OneDrive/Documents/mopro/title_director.csv'
INTO TABLE title_director
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/Users/LOQ/OneDrive/Documents/mopro/actors.csv'
INTO TABLE actors
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/Users/LOQ/OneDrive/Documents/mopro/title_actor.csv'
INTO TABLE title_actor
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/Users/LOQ/OneDrive/Documents/mopro/normalized_csv/countries.csv'
INTO TABLE countries
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/Users/LOQ/OneDrive/Documents/mopro/title_country.csv'
INTO TABLE title_country
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/Users/LOQ/OneDrive/Documents/mopro/genres.csv'
INTO TABLE genres
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/Users/LOQ/OneDrive/Documents/mopro/title_genre.csv'
INTO TABLE title_genre
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) AS total_titles FROM titles;
SELECT COUNT(*) AS total_directors FROM directors;
SELECT COUNT(*) AS total_actors FROM actors;
SELECT COUNT(*) AS total_genres FROM genres;
SELECT COUNT(*) AS total_countries FROM countries;