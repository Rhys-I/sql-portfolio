-- Cleaning and summarizing Rockbuster data
-- Checks for duplicates, missing data, non-uniform values, and calculates descriptive stats.

-- Check for duplicate data in film table
SELECT title, release_year, language_id, rental_duration, COUNT(*)
FROM film
GROUP BY title, release_year, language_id, rental_duration
HAVING COUNT(*) > 1;

-- Check for non-uniform data in film.rating
SELECT rating, COUNT(*)
FROM film
GROUP BY rating;

-- Check for missing data in film.rental_rate
SELECT COUNT(*) AS total_rows, COUNT(rental_rate) AS non_null_rental_rates
FROM film;

-- Check for missing data in customer table
SELECT COUNT(*) AS total_rows, COUNT(email) AS non_null_emails, COUNT(first_name) AS non_null_first_names
FROM customer;

-- Descriptive stats from film.rental_rate
SELECT MIN(rental_rate) AS min_rent, MAX(rental_rate) AS max_rent, AVG(rental_rate) AS avg_rent, COUNT(rental_rate) AS count_rent_values, COUNT(*) AS count_rows
FROM film;

-- Mode of film.rating
SELECT MODE() WITHIN GROUP (ORDER BY rating) AS modal_value
FROM film;

-- Descriptive stats from customer.active
SELECT MIN(active) AS min_active, MAX(active) AS max_active, AVG(active::float) AS avg_active
FROM customer;
