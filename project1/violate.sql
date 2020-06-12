--Primary key constraint

-- ERROR 1062 (23000): Duplicate entry '100' for key 'PRIMARY'
-- movie id=100 already exists
INSERT INTO Movie VALUES (100, 'Downton Abbey', 2019, 'PG', 'Focus Features and Universal Pictures International');

--ERROR 1062 (23000): Duplicate entry '10' for key 'PRIMARY'
-- actor id=10 already exists
INSERT INTO Actor VALUES (10, 'Shakespeare', 'William', 'Male', 1564-04-26, 1616-04-23);

--ERROR 1062 (23000): Duplicate entry '16' for key 'PRIMARY'
-- director id=16 already exists
INSERT INTO Director VALUES (16, 'Tarantino', 'Quentin', 1963-03-27, 'None');

---------------------------------------------------------------------------------------------------------------------

--Referential integrity constraints

-- ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`CS143`.`Sales`, CONSTRAINT `Sales_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `Movie` (`id`))
-- mid references id of Movie table, cannot be updated by a child
UPDATE Sales SET mid = mid + 1;

-- ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`CS143`.`MovieGenre`, CONSTRAINT `MovieGenre_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `Movie` (`id`))
-- mid references id of Movie table, cannot be updated by a child
UPDATE MovieGenre SET mid = mid + 1;

-- ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`CS143`.`MovieDirector`, CONSTRAINT `MovieDirector_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `Movie` (`id`))
-- mid references Movie(id) and did references Director(id)
-- mid=10 not exists in Movie table
INSERT INTO MovieDirector VALUES (10, 50);

-- ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`CS143`.`MovieActor`, CONSTRAINT `MovieActor_ibfk_2` FOREIGN KEY (`aid`) REFERENCES `Actor` (`id`))
-- mid references Movie(id) and aid references Actor(id)
-- aid=80 not exists in Actor table
INSERT INTO MovieActor VALUES (2, 80, 'Alex Moros');

-- ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`CS143`.`MovieRating`, CONSTRAINT `MovieRating_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `Movie` (`id`))
-- mid references Movie(id)
-- mid=10 not exists in Movie Table
INSERT INTO MovieRating VALUES (10, 45, 23);

-- ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`CS143`.`Review`, CONSTRAINT `Review_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `Movie` (`id`))
-- mid references Movie(id)
-- mid=6900 not exists in Movie table
INSERT INTO Review VALUES('Supersupper', '2020-01-30 22:10:26', 6900, 3.5, 'Just so so.');

--------------------------------------------------------------------------------------------------------------

--Check constraint

-- valid ticketsSold and totalIncome must be greater or equal to 0, negative number not accepted
INSERT INTO Sales VALUES (5, -20, -100);

-- valid imdb and rot rating is between 0 and 100, 101 and 200 are out of range
INSERT INTO MovieRating VALUES (5, 101, 200);

-- valid rating is between 0 and 5,100 is out of range
INSERT INTO Review VALUES ('TaylorIsADog', '2020-01-30-22:19:38', 10, 100, 'Worth any pennies');
