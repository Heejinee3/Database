WITH customer_film AS (
 SELECT DISTINCT customer.customer_id AS customer_id, first_name, last_name, film.film_id AS film_id
 FROM customer
 JOIN rental ON customer.customer_id = rental.customer_id
 JOIN inventory ON rental.inventory_id = inventory.inventory_id
 JOIN film ON inventory.film_id = film.film_id),
selected_film AS (
 SELECT DISTINCT film.film_id AS film_id
 FROM film
 JOIN film_actor ON film.film_id = film_actor.film_id
 WHERE film.film_id >= 10 AND film.film_id < 20 AND rental_rate > 4 AND actor_id IN (
  SELECT actor.actor_id
  FROM actor
  JOIN film_actor ON actor.actor_id = film_actor.actor_id
  JOIN film ON film_actor.film_id = film.film_id
  GROUP BY actor.actor_id
  HAVING COUNT(film.film_id) > 30))

SELECT DISTINCT customer_id, first_name, last_name
FROM customer_film customer_film1
WHERE NOT EXISTS(
 SELECT *
 FROM selected_film
 WHERE NOT EXISTS(
  SELECT *
  FROM customer_film customer_film2
  WHERE customer_film2.customer_id = customer_film1.customer_id AND customer_film2.film_id = selected_film.film_id))

INTO OUTFILE '/var/lib/mysql-files/problem5.csv'
FIELDS TERMINATED BY '|'
LINES TERMINATED BY '\n';
