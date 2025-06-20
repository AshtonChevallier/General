/*
Using this dataset, show the SQL query to find the rolling 3 day average transaction amount for each day in January 2021.
I interpreted the daily avg as the current day and the last 3 days rolling. I rounded to 1 dollar, cuz, why not.
*/

with daily_amts as (
  SELECT
    DATE_TRUNC('day',transaction_time) as day_of_jan,
    SUM(transaction_amount) as daily_amt
  FROM transactions
  WHERE date_trunc('month',transaction_time) = '01/01/2021'
  GROUP by 1
),

rolling_avg as (
  SELECT
    day_of_jan,
    AVG(daily_amt)
        OVER (ORDER BY day_of_jan ROWS BETWEEN 2 PRECEDING AND 0 FOLLOWING) as window_calc
  FROM daily_amts
)
                
SELECT
    day_of_jan, 
    ROUND(window_calc) 
FROM rolling_avg
​

