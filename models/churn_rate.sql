-- CHURN RATE: # of customers who canceled in 3 years ÷ total customers in 3 years
WITH CTE AS (
    
    SELECT 
      customer_id,
      COUNT(mrr) AS Count_of_Churners
    FROM {{ ref('customer_churn_by_month') }}
    GROUP BY customer_id
     
),
CTE1 AS (

    SELECT 
      customer_id,
      COUNT(DISTINCT(customer_id)) AS Count_of_Customer 
    FROM {{ ref('subscription_data') }}  
    GROUP BY customer_id  
    
)
SELECT
  SUM(Count_of_Churners) / SUM(Count_of_Customer) AS Churn_Rate
FROM CTE 
LEFT JOIN CTE1
ON CTE.customer_id = CTE1.customer_id
