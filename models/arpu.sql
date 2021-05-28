
WITH CTE AS (
  SELECT DISTINCT(A) AS Distinct_Customers
  FROM
  (
  SELECT 
    date_month,
    customer_id,
    ---- I am dividing mrr by 3 because I am summing mrr from 2018 - 2020 to find  sum of mrr for 36 months, to then get average ARR for each year
    (SUM(mrr) OVER(PARTITION BY customer_id)/3) / COUNT(customer_id) OVER (PARTITION BY customer_id) AS A
  FROM   {{ ref('customer_revenue_by_month') }}
  ) AS TempQuery
)
-- Average Revenue Per User (ARPU) over three years
SELECT SUM(Distinct_Customers) AS ARPU FROM CTE