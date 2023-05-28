SELECT store_id, COUNT(film_id) AS num_film
FROM
 (SELECT store.store_id AS store_id, film.film_id AS film_id
 FROM store
 LEFT OUTER JOIN inventory ON store.store_id = inventory.store_id
 JOIN film ON inventory.film_id = film.film_id
 LEFT OUTER JOIN rental ON inventory.inventory_id = rental.inventory_id
 GROUP BY store.store_id, film.film_id
 HAVING COUNT(rental_id) < 5) store_film
GROUP BY store_id

INTO OUTFILE '/var/lib/mysql-files/problem2.csv'
FIELDS TERMINATED BY '|'
LINES TERMINATED BY '\n';
