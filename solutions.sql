/* avg rating per movie, per genre and overall */
SELECT DISTINCT m.title,
AVG(r.rating) OVER (PARTITION BY m.id) AS avg_movie_rating,
AVG(r.rating) OVER (PARTITION BY m.genre) AS avg_genre_rating,
AVG(r.rating) OVER () AS avg_overall_rating
FROM review r
JOIN movie m ON r.movie_id = m.id;


/* customer avg payment vs avg payment from their country */
SELECT c.first_name, c.last_name,
AVG(sr.payment_amount) OVER (PARTITION BY sr.customer_id) AS avg_customer_payment,
AVG(sr.payment_amount) OVER (PARTITION BY c.country) AS avg_country_payment
FROM single_rental sr
JOIN customer c ON sr.customer_id = c.id;


/* who bought the second most recent giftcard and when, used row_number since each giftcard gets its own rank */
SELECT c.first_name, c.last_name, g.payment_date
FROM (
    SELECT customer_id, payment_date,
    ROW_NUMBER() OVER (ORDER BY payment_date DESC) AS rn
    FROM giftcard
) g
JOIN customer c ON g.customer_id = c.id
WHERE g.rn = 2;


/* rentals ranked by price within each genre, ties allowed, gaps allowed */
SELECT sr.rental_date, m.title, m.genre, sr.payment_amount,
RANK() OVER (PARTITION BY m.genre ORDER BY sr.payment_amount DESC) AS rank
FROM single_rental sr
JOIN movie m ON sr.movie_id = m.id;


/* running total of rental payments ordered from oldest to newest */
SELECT id, rental_date, payment_amount,
SUM(payment_amount) OVER (ORDER BY rental_date
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM single_rental;


/* future cashflows per subscription from that date onwards, RANGE used so same day payments are included */
SELECT id, length, platform, payment_date, payment_amount,
SUM(payment_amount) OVER (ORDER BY payment_date
RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS future_cashflows
FROM subscription;


/* running max payment per genre up to each rental date */
SELECT sr.rental_date, m.title, m.genre, sr.payment_amount,
MAX(sr.payment_amount) OVER (PARTITION BY m.genre ORDER BY sr.rental_date
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS max_genre_payment
FROM single_rental sr
JOIN movie m ON sr.movie_id = m.id;


/* first and last giftcard payment amounts as reference columns, had to extend the frame or last_value wont work */
SELECT amount_worth, payment_amount,
FIRST_VALUE(payment_amount) OVER (ORDER BY payment_date
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS first_giftcard_payment,
LAST_VALUE(payment_amount) OVER (ORDER BY payment_date
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_giftcard_payment
FROM giftcard;


/* daily rental payments with previous day and the difference */
SELECT rental_date,
SUM(payment_amount) AS payment_amounts,
LAG(SUM(payment_amount)) OVER (ORDER BY rental_date) AS prev_day_payments,
SUM(payment_amount) - LAG(SUM(payment_amount)) OVER (ORDER BY rental_date) AS difference
FROM single_rental
GROUP BY rental_date;


/* each customer's total payments vs the median customer's total, 7 customers so median is the 4th */
WITH customer_payments AS (
    SELECT customer_id, SUM(payment_amount) AS sum_of_payments
    FROM single_rental
    GROUP BY customer_id
),
ranked_customers AS (
    SELECT customer_id, sum_of_payments,
    ROW_NUMBER() OVER (ORDER BY sum_of_payments) AS rn
    FROM customer_payments
)
SELECT c.first_name, c.last_name, cp.sum_of_payments,
(SELECT sum_of_payments FROM ranked_customers WHERE rn = 4) AS median_payment
FROM customer_payments cp
JOIN customer c ON cp.customer_id = c.id;
