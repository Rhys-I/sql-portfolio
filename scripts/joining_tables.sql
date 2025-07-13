-- Joining Rockbuster tables to analyze top countries, cities, and high-value customers.

-- Top 10 countries by customer count
SELECT D.country, COUNT(A.customer_id) AS customer_count
FROM customer A
INNER JOIN address B ON A.address_id = B.address_id
INNER JOIN city C ON B.city_id = C.city_id
INNER JOIN country D ON C.country_id = D.country_id
GROUP BY D.country
ORDER BY customer_count DESC
LIMIT 10;

-- Top 10 cities in those countries
SELECT C.city, D.country, COUNT(A.customer_id) AS customer_count
FROM customer A
INNER JOIN address B ON A.address_id = B.address_id
INNER JOIN city C ON B.city_id = C.city_id
INNER JOIN country D ON C.country_id = D.country_id
WHERE D.country IN ('India', 'China', 'United States', 'Japan', 'Mexico', 'Brazil', 'Russian Federation', 'Philippines', 'Turkey', 'Indonesia')
GROUP BY C.city, D.country
ORDER BY customer_count DESC
LIMIT 10;

-- Top 5 customers by total amount paid (from top cities)
SELECT A.customer_id, A.first_name, A.last_name, D.country, C.city, SUM(E.amount) AS total_paid
FROM customer A
INNER JOIN address B ON A.address_id = B.address_id
INNER JOIN city C ON B.city_id = C.city_id
INNER JOIN country D ON C.country_id = D.country_id
INNER JOIN payment E ON A.customer_id = E.customer_id
WHERE C.city IN ('Aurora', 'Atlixco', 'Xintai', 'Adoni', 'Dhule (Dhulia)', 'Kurashiki', 'Pingxiang', 'Sivas', 'Celaya', 'So Leopoldo')
GROUP BY A.customer_id, A.first_name, A.last_name, D.country, C.city
ORDER BY total_paid DESC
LIMIT 5;
