-- the names of all the actors in the movie 'Die Another Day'
SELECT CONCAT(first," ", last)
FROM Actor
WHERE id IN (SELECT aid FROM MovieActor WHERE mid =
                    (SELECT id FROM Movie WHERE title='Die Another Day'));

-- the count of all the actors who acted in multiple movies
SELECT COUNT(*)
FROM
(SELECT DISTINCT aid
 FROM MovieActor
 Group By aid
 HAVING COUNT(mid) > 1) AS MA;

--  the title of movies that sell more than 1,000,000 tickets
 SELECT title
 FROM Movie
 WHERE id IN (SELECT mid from Sales
             WHERE Sales.ticketsSold > 1000000);

-- the director(s)' names that direct(s) the largest number of movies.
SELECT CONCAT(first, " ", last)
FROM Director
WHERE id IN
(SELECT did
 FROM MovieDirector
 GROUP BY did
 HAVING count(mid) =
        (SELECT MAX(totalMovies) as highestTotal
         FROM (
           SELECT did, COUNT(mid) as totalMovies
           FROM MovieDirector
           GROUP BY did) as MD
         ));

-- the count of all the actors who acted in only one movie
SELECT COUNT(*)
FROM (SELECT aid
      FROM MovieActor
      GROUP BY aid
      HAVING COUNT(mid) = 1) AS MA;
