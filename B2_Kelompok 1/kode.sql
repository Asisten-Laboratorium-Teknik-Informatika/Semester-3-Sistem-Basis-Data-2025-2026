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

LOAD DATA INFILE 'C:/Users/LOQ/OneDrive/Documents/project/titles.csv'
INTO TABLE titles
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/Users/LOQ/OneDrive/Documents/project/directors.csv'
INTO TABLE directors
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/Users/LOQ/OneDrive/Documents/project/title_director.csv'
INTO TABLE title_director
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/Users/LOQ/OneDrive/Documents/project/actors.csv'
INTO TABLE actors
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/Users/LOQ/OneDrive/Documents/project/title_actor.csv'
INTO TABLE title_actor
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/Users/LOQ/OneDrive/Documents/project/countries.csv'
INTO TABLE countries
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/Users/LOQ/OneDrive/Documents/project/title_country.csv'
INTO TABLE title_country
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/Users/LOQ/OneDrive/Documents/project/genres.csv'
INTO TABLE genres
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/Users/LOQ/OneDrive/Documents/project/title_genre.csv'
INTO TABLE title_genre
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT
title,
release_year
FROM
titles
WHERE
release_year = 2020
LIMIT 5;

SELECT
title,
type,
duration
FROM
titles
ORDER BY
duration DESC
LIMIT 10;

SELECT
release_year,
type,
COUNT(show_id) AS total_count
FROM
titles
GROUP BY
release_year, type
ORDER BY
release_year DESC, type;

SELECT
t.title,
t.rating,
t.release_year,
g.name AS genre_name
FROM
titles t
JOIN
title_genre tg ON t.show_id = tg.show_id
JOIN
genres g ON tg.genre_id = g.genre_id
WHERE
g.name LIKE '%Drama%'
AND t.release_year = 2020
ORDER BY
t.rating DESC
LIMIT 10;

SELECT
title,
release_year,
type
FROM
titles
WHERE
title LIKE '%Love%'
AND release_year BETWEEN 2015 AND 2020
ORDER BY
release_year DESC
LIMIT 10;

SELECT
title,
date_added,
release_year
FROM
titles
WHERE
type = 'TV Show'
AND date_added IS NOT NULL
ORDER BY
date_added ASC
LIMIT 5;

SELECT
title,
release_year,
date_added
FROM
titles
WHERE
rating IS NULL OR rating = ''
LIMIT 10;

SELECT
title,
release_year,
description
FROM
titles
WHERE
description LIKE '%Mystery%'
LIMIT 10;

SELECT
COUNT(show_id) AS total_titles_at_90_min
FROM
titles
WHERE
type = 'Movie'
AND duration = '90 min';

(SELECT title, LENGTH(title) AS title_length FROM titles WHERE type = 'Movie' ORDER BY title_length ASC LIMIT 1)
UNION ALL
-- Judul Terpanjang
(SELECT title, LENGTH(title) AS title_length FROM titles WHERE type = 'Movie' ORDER BY title_length DESC LIMIT 1);

