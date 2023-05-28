SELECT customer.customer_id, SUM(tmp) AS num_overdue
FROM customer
LEFT OUTER JOIN 
 (SELECT rental_id, customer_id, rental_date, return_date, 1 AS tmp
 FROM rental) rentaltmp ON rentaltmp.customer_id = customer.customer_id
WHERE store_id = 1 AND rental_date + interval 30 day < CURRENT_DATE() AND return_date IS NULL AND customer.customer_id < 100
GROUP BY customer.customer_id

INTO OUTFILE '/var/lib/mysql-files/problem4.csv'
FIELDS TERMINATED BY '|'
LINES TERMINATED BY '\n';
