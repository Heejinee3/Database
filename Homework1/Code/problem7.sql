SELECT country, COUNT(store_id) AS num_store, SUM(income) AS sum_income
FROM country
JOIN city ON country.country_id = city.country_id
JOIN address ON city.city_id = address.city_id
JOIN 
 (SELECT store.store_id AS store_id, address_id, SUM(payment.amount) AS income
 FROM store
 LEFT OUTER JOIN inventory ON inventory.store_id = store.store_id
 LEFT OUTER JOIN rental ON inventory.inventory_id = rental.inventory_id
 LEFT OUTER JOIN payment ON rental.rental_id = payment.rental_id
 GROUP BY store.store_id) store_income ON address.address_id = store_income.address_id
GROUP BY country.country_id

INTO OUTFILE '/var/lib/mysql-files/problem7.csv'
FIELDS TERMINATED BY '|'
LINES TERMINATED BY '\n';
