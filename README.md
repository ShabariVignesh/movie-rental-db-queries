# Movie Rental Database – SQL Queries

wrote some queries to explore the movie rental database using window functions and CTEs, outputs for each are below

---

avg rating per movie, per genre and overall avg

```
title                   | avg_movie_rating | avg_genre_rating | avg_overall_rating
Avatar                  | 7.5              | 3.67             | 5.72
Titanic                 | 9.25             | 8.625            | 5.72
Godfather               | 8.0              | 8.625            | 5.72
Showgirls               | 3.0              | 3.0              | 5.72
Plan 9 From Outer Space | 1.75             | 3.67             | 5.72
```

---

customer avg payment vs their country's avg, one row per rental so same customer shows up multiple times

```
first_name | last_name  | avg_customer_payment | avg_country_payment
Eric       | Rivera     | 42.0                 | 26.29
Eric       | Rivera     | 42.0                 | 26.29
Eric       | Rivera     | 42.0                 | 26.29
Brandon    | Thomas     | 10.0                 | 26.29
Brandon    | Thomas     | 10.0                 | 26.29
Brandon    | Thomas     | 10.0                 | 26.29
Ryan       | Young      | 28.0                 | 26.29
Janet      | Simmons    | 14.33                | 14.0
Janet      | Simmons    | 14.33                | 14.0
Janet      | Simmons    | 14.33                | 14.0
Jeffrey    | Washington | 13.83                | 14.0
Jeffrey    | Washington | 13.83                | 14.0
Jeffrey    | Washington | 13.83                | 14.0
Jeffrey    | Washington | 13.83                | 14.0
Jeffrey    | Washington | 13.83                | 14.0
Jeffrey    | Washington | 13.83                | 14.0
Kathryn    | Reed       | 7.0                  | 12.5
Kathryn    | Reed       | 7.0                  | 12.5
Catherine  | Coleman    | 18.0                 | 12.5
Catherine  | Coleman    | 18.0                 | 12.5
```

---

who bought the second most recent giftcard and when

```
first_name | last_name | payment_date
Eric       | Rivera    | 2016-04-07
```

---

rentals ranked by price within genre, rank 1 is shared for fantasy (both 49.0) and rank jumps from 1 to 3 after the tie

```
rental_date | title                   | genre       | payment_amount | rank
2016-03-21  | Showgirls               | documentary | 21.0           | 1
2016-02-10  | Showgirls               | documentary | 15.0           | 2
2016-03-20  | Showgirls               | documentary | 12.0           | 3
2016-04-09  | Showgirls               | documentary | 6.0            | 4
2016-02-20  | Titanic                 | drama       | 28.0           | 1
2016-03-08  | Titanic                 | drama       | 24.0           | 2
2016-01-12  | Godfather               | drama       | 21.0           | 3
2016-03-25  | Titanic                 | drama       | 9.0            | 4
2016-04-05  | Godfather               | drama       | 8.0            | 5
2016-03-15  | Godfather               | drama       | 6.0            | 6
2016-04-09  | Godfather               | drama       | 6.0            | 6
2016-03-26  | Plan 9 From Outer Space | fantasy     | 49.0           | 1
2016-01-06  | Plan 9 From Outer Space | fantasy     | 49.0           | 1
2016-04-21  | Plan 9 From Outer Space | fantasy     | 28.0           | 3
2016-04-10  | Avatar                  | fantasy     | 28.0           | 3
2016-04-13  | Avatar                  | fantasy     | 18.0           | 5
2016-04-11  | Plan 9 From Outer Space | fantasy     | 9.0            | 6
2016-01-07  | Plan 9 From Outer Space | fantasy     | 9.0            | 6
2016-02-09  | Avatar                  | fantasy     | 8.0            | 8
2016-04-27  | Avatar                  | fantasy     | 6.0            | 9
```

---

running total of all rental payments, ends at 360 which is the total

```
id | rental_date | payment_amount | running_total
19 | 2016-01-06  | 49.0           | 49.0
7  | 2016-01-07  | 9.0            | 58.0
20 | 2016-01-12  | 21.0           | 79.0
4  | 2016-02-09  | 8.0            | 87.0
11 | 2016-02-10  | 15.0           | 102.0
15 | 2016-02-20  | 28.0           | 130.0
14 | 2016-03-08  | 24.0           | 154.0
5  | 2016-03-15  | 6.0            | 160.0
12 | 2016-03-20  | 12.0           | 172.0
10 | 2016-03-21  | 21.0           | 193.0
3  | 2016-03-25  | 9.0            | 202.0
17 | 2016-03-26  | 49.0           | 251.0
2  | 2016-04-05  | 8.0            | 259.0
1  | 2016-04-09  | 6.0            | 265.0
8  | 2016-04-09  | 6.0            | 271.0
18 | 2016-04-10  | 28.0           | 299.0
6  | 2016-04-11  | 9.0            | 308.0
13 | 2016-04-13  | 18.0           | 326.0
16 | 2016-04-21  | 28.0           | 354.0
9  | 2016-04-27  | 6.0            | 360.0
```

---

future cashflows per subscription, first one is 5143 since its the earliest and includes everything after

```
id | length | platform | payment_date | payment_amount | future_cashflows
8  | 180    | mobile   | 2016-05-08   | 1440.0         | 5143.0
7  | 30     | mobile   | 2016-05-25   | 240.0          | 3703.0
2  | 7      | desktop  | 2016-06-10   | 49.0           | 3463.0
6  | 30     | desktop  | 2016-06-23   | 180.0          | 3414.0
1  | 7      | desktop  | 2016-07-16   | 49.0           | 3234.0
3  | 7      | desktop  | 2016-07-20   | 35.0           | 3185.0
4  | 30     | tablet   | 2016-07-20   | 210.0          | 3185.0
10 | 180    | tablet   | 2016-07-29   | 1260.0         | 2940.0
9  | 180    | desktop  | 2016-08-21   | 1440.0         | 1680.0
5  | 30     | mobile   | 2016-08-31   | 240.0          | 240.0
```

---

running max payment per genre, once fantasy hits 49 on jan 6 it stays 49 for the rest

```
rental_date | title                   | genre       | payment_amount | max_genre_payment
2016-02-10  | Showgirls               | documentary | 15.0           | 15.0
2016-03-20  | Showgirls               | documentary | 12.0           | 15.0
2016-03-21  | Showgirls               | documentary | 21.0           | 21.0
2016-04-09  | Showgirls               | documentary | 6.0            | 21.0
2016-01-12  | Godfather               | drama       | 21.0           | 21.0
2016-02-20  | Titanic                 | drama       | 28.0           | 28.0
2016-03-08  | Titanic                 | drama       | 24.0           | 28.0
2016-03-15  | Godfather               | drama       | 6.0            | 28.0
2016-03-25  | Titanic                 | drama       | 9.0            | 28.0
2016-04-05  | Godfather               | drama       | 8.0            | 28.0
2016-04-09  | Godfather               | drama       | 6.0            | 28.0
2016-01-06  | Plan 9 From Outer Space | fantasy     | 49.0           | 49.0
2016-01-07  | Plan 9 From Outer Space | fantasy     | 9.0            | 49.0
2016-02-09  | Avatar                  | fantasy     | 8.0            | 49.0
2016-03-26  | Plan 9 From Outer Space | fantasy     | 49.0           | 49.0
2016-04-10  | Avatar                  | fantasy     | 28.0           | 49.0
2016-04-11  | Plan 9 From Outer Space | fantasy     | 9.0            | 49.0
2016-04-13  | Avatar                  | fantasy     | 18.0           | 49.0
2016-04-21  | Plan 9 From Outer Space | fantasy     | 28.0           | 49.0
2016-04-27  | Avatar                  | fantasy     | 6.0            | 49.0
```

---

first and last giftcard payment amounts as reference, same value repeated across all rows

```
amount_worth | payment_amount | first_giftcard_payment | last_giftcard_payment
100.0        | 99.0           | 99.0                   | 78.0
100.0        | 83.0           | 99.0                   | 78.0
50.0         | 36.0           | 99.0                   | 78.0
100.0        | 73.0           | 99.0                   | 78.0
30.0         | 15.0           | 99.0                   | 78.0
50.0         | 33.0           | 99.0                   | 78.0
30.0         | 15.0           | 99.0                   | 78.0
30.0         | 17.0           | 99.0                   | 78.0
100.0        | 78.0           | 99.0                   | 78.0
```

---

daily rental payments with previous day and difference, first row is NULL since theres no day before it

```
rental_date | payment_amounts | prev_day_payments | difference
2016-01-06  | 49.0            | NULL              | NULL
2016-01-07  | 9.0             | 49.0              | -40.0
2016-01-12  | 21.0            | 9.0               | 12.0
2016-02-09  | 8.0             | 21.0              | -13.0
2016-02-10  | 15.0            | 8.0               | 7.0
2016-02-20  | 28.0            | 15.0              | 13.0
2016-03-08  | 24.0            | 28.0              | -4.0
2016-03-15  | 6.0             | 24.0              | -18.0
2016-03-20  | 12.0            | 6.0               | 6.0
2016-03-21  | 21.0            | 12.0              | 9.0
2016-03-25  | 9.0             | 21.0              | -12.0
2016-03-26  | 49.0            | 9.0               | 40.0
2016-04-05  | 8.0             | 49.0              | -41.0
2016-04-09  | 12.0            | 8.0               | 4.0
2016-04-10  | 28.0            | 12.0              | 16.0
2016-04-11  | 9.0             | 28.0              | -19.0
2016-04-13  | 18.0            | 9.0               | 9.0
2016-04-21  | 28.0            | 18.0              | 10.0
2016-04-27  | 6.0             | 28.0              | -22.0
```

---

each customer's total payments vs the median, median is 36 which is Catherine's total, Eric is highest at 126

```
first_name | last_name  | sum_of_payments | median_payment
Eric       | Rivera     | 126.0           | 36.0
Brandon    | Thomas     | 30.0            | 36.0
Ryan       | Young      | 28.0            | 36.0
Janet      | Simmons    | 43.0            | 36.0
Jeffrey    | Washington | 83.0            | 36.0
Kathryn    | Reed       | 14.0            | 36.0
Catherine  | Coleman    | 36.0            | 36.0
```
