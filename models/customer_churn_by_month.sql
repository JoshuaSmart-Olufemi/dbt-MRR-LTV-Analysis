with mrr as (

    select * from {{ ref('customer_revenue_by_month') }}

),

-- row for month *after* last month of activity
joined as (

    select
        CAST(date_add(date_month, INTERVAL 1 MONTH) AS DATETIME) as date_month,
        customer_id,
        CAST(0 AS float64) as mrr,
        false as is_active,
        first_active_month,
        last_active_month,
        false as is_first_month,
        false as is_last_month

    from mrr

    where is_last_month

)

select * from joined
