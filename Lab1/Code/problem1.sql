SELECT category.category_id AS category_id, actor.actor_id AS actor_id, COUNT(film.film_id) AS num_film
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film.film_id = film_category.film_id
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
GROUP BY category.category_id, actor.actor_id
HAVING COUNT(film.film_id) > 5

INTO OUTFILE '/var/lib/mysql-files/problem1.csv'
FIELDS TERMINATED BY '|'
LINES TERMINATED BY '\n';
