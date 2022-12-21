SELECT film.film_id AS film_id, title, COUNT(rental_id) AS num_rental
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE unix_timestamp(rental_date) >= unix_timestamp('2005.06.01') AND unix_timestamp(rental_date) <= unix_timestamp('2005.08.31')
GROUP BY film.film_id
HAVING COUNT(rental_id) > 26
ORDER BY num_rental DESC

INTO OUTFILE '/var/lib/mysql-files/problem3.csv'
FIELDS TERMINATED BY '|'
LINES TERMINATED BY '\n';
