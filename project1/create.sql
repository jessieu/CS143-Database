CREATE TABLE Movie (
       id INT NOT NULL,
       title VARCHAR(100) NOT NULL,
       year INT NOT NULL,
       rating VARCHAR(10),
       company VARCHAR(50),
       PRIMARY KEY(id), -- primary key constraint
       CHECK(year > 999 AND year <= 9999), -- check constraint
       CHECK(id > 0 AND id <= MaxMovieID(id)) -- check constraint
)ENGINE = INNODB;

CREATE TABLE Actor (
       id INT NOT NULL,
       last VARCHAR(20) NOT NULL,
       first VARCHAR(20) NOT NULL,
       sex VARCHAR(6) NOT NULL,
       dob DATE NOT NULL,
       dod DATE,
       PRIMARY KEY(id), -- primary key constraint
       CHECK(id > 0 AND id <= MaxPersonID(id)) -- check constraint
)ENGINE = INNODB;

CREATE TABLE Sales (
       mid INT NOT NULL,
       ticketsSold INT NOT NULL,
       totalIncome INT NOT NULL,
       FOREIGN KEY(mid) REFERENCES Movie(id), -- referential integrity constraints
       CHECK(ticketsSold >= 0), -- check constraint
       CHECK(totalIncome >= 0) -- check constraint
)ENGINE = INNODB;

CREATE TABLE Director (
       id INT NOT NULL,
       last VARCHAR(20) NOT NULL,
       first VARCHAR(20) NOT NULL,
       dob DATE NOT NULL,
       dod DATE,
       PRIMARY KEY(id), -- primary key constraint
       CHECK(id > 0 AND id <= MaxPersonID(id)) -- check constraint
)ENGINE = INNODB;

CREATE TABLE MovieGenre (
       mid INT NOT NULL,
       genre VARCHAR(20) NOT NULL,
       FOREIGN KEY(mid) REFERENCES Movie(id) -- referential integrity constraints
)ENGINE = INNODB;

CREATE TABLE MovieDirector (
       mid INT NOT NULL,
       did INT NOT NULL,
       FOREIGN KEY(mid) REFERENCES Movie(id), -- referential integrity constraints
       FOREIGN KEY(did) REFERENCES Director(id) -- referential integrity constraints
)ENGINE = INNODB;

CREATE TABLE MovieActor (
       mid INT NOT NULL,
       aid INT NOT NULL,
       role VARCHAR(50) NOT NULL,
       FOREIGN KEY(mid) REFERENCES Movie(id), -- referential integrity constraints
       FOREIGN KEY(aid) REFERENCES Actor(id) -- referential integrity constraints
)ENGINE = INNODB;

CREATE TABLE MovieRating (
       mid INT NOT NULL,
       imdb INT NOT NULL,
       rot INT NOT NULL,
       FOREIGN KEY(mid) REFERENCES Movie(id),
       CHECK(imdb >= 0 AND imdb <= 100), -- check constraint
       CHECK(rot >= 0 AND rot <= 100) -- check constraint
)ENGINE = INNODB;

CREATE TABLE Review (
       name VARCHAR(20) NOT NULL,
       time TIMESTAMP,
       mid INT NOT NULL,
       rating INT NOT NULL,
       comment VARCHAR(500),
       FOREIGN KEY(mid) REFERENCES Movie(id), -- referential integrity constraints
       CHECK(rating >= 0 AND rating <= 5) -- check constraint
)ENGINE = INNODB;

CREATE TABLE MaxPersonID (
       id INT
)ENGINE = INNODB;

CREATE TABLE MaxMovieID (
       id INT
)ENGINE = INNODB;
