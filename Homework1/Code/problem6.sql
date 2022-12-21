WITH film_invennum AS (
SELECT film.film_id AS film_id, COUNT(inventory_id) AS invennum
FROM film
LEFT OUTER JOIN inventory ON film.film_id = inventory.film_id
GROUP BY film.film_id)

SELECT film.film_id AS film_id, COUNT(rental.rental_id) AS num_rental
FROM film
LEFT OUTER JOIN inventory ON film.film_id = inventory.film_id
LEFT OUTER JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.film_id 
HAVING film.film_id IN 
 (SELECT film_id
 FROM film_invennum
 WHERE invennum > 
  (SELECT SUM(invennum)/COUNT(invennum) AS avgKeep
  FROM film_invennum))
AND COUNT(rental.rental_id) >= 30
ORDER BY film_id

INTO OUTFILE '/var/lib/mysql-files/problem6.csv'
FIELDS TERMINATED BY '|'
LINES TERMINATED BY '\n';
