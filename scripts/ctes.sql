-- Using Common Table Expressions (CTEs) to rewrite subquery logic for better readability.

-- Average amount paid by the top 5 customers (CTE version)
WITH top_5_customers_cte AS (
    SELECT A.customer_id, A.first_name, A.last_name, D.country, C.city, SUM(E.amount) AS total_paid
    FROM customer A
    INNER JOIN address B ON A.address_id = B.address_id
    INNER JOIN city C ON B.city_id = C.city_id
    INNER JOIN country D ON C.country_id = D.country_id
    INNER JOIN payment E ON A.customer_id = E.customer_id
    WHERE C.city IN ('Aurora', 'Atlixco', 'Xintai', 'Adoni', 'Dhule (Dhulia)', 'Kurashiki', 'Pingxiang', 'Sivas', 'Celaya', 'So Leopoldo')
    GROUP BY A.customer_id, A.first_name, A.last_name, D.country, C.city
    ORDER BY total_paid DESC
    LIMIT 5
)
SELECT AVG(total_paid) AS average
FROM top_5_customers_cte;

-- Number of top 5 customers in each country (CTE version)
WITH country_stats_cte AS (
    SELECT A.customer_id, D.country
    FROM customer A
    INNER JOIN address B ON A.address_id = B.address_id
    INNER JOIN city C ON B.city_id = C.city_id
    INNER JOIN country D ON C.country_id = D.country_id
),
top_5_customers_cte AS (
    SELECT A.customer_id, D.country
    FROM customer A
    INNER JOIN address B ON A.address_id = B.address_id
    INNER JOIN city C ON B.city_id = C.city_id
    INNER JOIN country D ON C.country_id = D.country_id
    INNER JOIN payment E ON A.customer_id = E.customer_id
    WHERE C.city IN ('Aurora', 'Atlixco', 'Xintai', 'Adoni', 'Dhule (Dhulia)', 'Kurashiki', 'Pingxiang', 'Sivas', 'Celaya', 'So Leopoldo')
    GROUP BY A.customer_id, A.first_name, A.last_name, D.country, C.city
    ORDER BY SUM(E.amount) DESC
    LIMIT 5
)
SELECT country_stats_cte.country, COUNT(DISTINCT country_stats_cte.customer_id) AS all_customer_count, COUNT(DISTINCT top_5_customers_cte.customer_id) AS top_customer_count
FROM country_stats_cte
LEFT JOIN top_5_customers_cte ON country_stats_cte.customer_id = top_5_customers_cte.customer_id
GROUP BY country_stats_cte.country
ORDER BY all_customer_count DESC;
