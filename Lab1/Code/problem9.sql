SELECT country, category, actor_id
FROM
 (SELECT country, category, actor_id, RANK() OVER (PARTITION BY country_id, category_id ORDER BY income DESC) ranking
 FROM 
  (SELECT country.country_id AS country_id, country, category.category_id AS category_id, name AS category, actor.actor_id AS actor_id, SUM(amount) AS income
  FROM country
  JOIN city ON country.country_id = city.country_id
  JOIN address ON city.city_id = address.city_id
  JOIN store ON address.address_id = store.address_id
  JOIN inventory ON store.store_id = inventory.store_id
  JOIN rental ON inventory.inventory_id = rental.inventory_id
  JOIN payment ON rental.rental_id = payment.rental_id
  JOIN film ON inventory.film_id = film.film_id
  JOIN film_category ON film.film_id = film_category.film_id
  JOIN category ON film_category.category_id = category.category_id
  JOIN film_actor ON film.film_id = film_actor.film_id
  JOIN actor ON film_actor.actor_id = actor.actor_id
  WHERE unix_timestamp(rental_date) >= unix_timestamp('2005.01.01') AND unix_timestamp(rental_date) < unix_timestamp('2006.01.01')
  GROUP BY country.country_id, category.category_id, actor.actor_id) country_category_actor) country_category_top_actor
WHERE ranking = 1

INTO OUTFILE '/var/lib/mysql-files/problem9.csv'
FIELDS TERMINATED BY '|'
LINES TERMINATED BY '\n';
