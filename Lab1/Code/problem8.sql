SELECT store.store_id AS store_id, name AS category, COUNT(rental.rental_id) AS num_rental
FROM store
JOIN inventory ON store.store_id = inventory.store_id
JOIN film ON inventory.film_id = film.film_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY store.store_id, category.category_id
HAVING COUNT(rental.rental_id) > 500
ORDER BY store_id, num_rental DESC

INTO OUTFILE '/var/lib/mysql-files/problem8.csv'
FIELDS TERMINATED BY '|'
LINES TERMINATED BY '\n';
