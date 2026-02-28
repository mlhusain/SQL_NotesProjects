🛒 E-Commerce Sales Funnel & Revenue Analysis
PostgreSQL + Power BI Project


📌 1️⃣ Project Overview

This project analyzes clickstream user behavior data from an e-commerce platform to identify:

Funnel drop-offs

Conversion rates

Channel performance

Revenue metrics

Time-to-purchase behavior

All analysis is performed using PostgreSQL (CTEs, Conditional Aggregation, Time Interval Analysis) and visualized in Power BI.


```sql

---1)
SELECT * FROM user_events LIMIT 20;

SELECT event_type from user_events GROUP BY event_type;

SELECT traffic_source from user_events GROUP BY traffic_source;

---2) Define Sale Funnel and the Different Stages (Corrected for PostgreSQL):
WITH funnel_stages AS (
    SELECT 
        COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) as views,
        COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN user_id END) as carts,
        COUNT(DISTINCT CASE WHEN event_type = 'checkout_start' THEN user_id END) as checkouts,
        COUNT(DISTINCT CASE WHEN event_type = 'payment_info' THEN user_id END) as payments,
        COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) as purchases
    FROM user_events
    -- PostgreSQL এ INTERVAL ব্যবহারের সঠিক নিয়ম:
    WHERE event_date >= CURRENT_DATE - INTERVAL '30 days'  --- laptop এর ডেট নিয়েছে । ডাটাসেটের সর্বশেষ ৩০ দিনের ফানেল অ্যানালাইসিস
)
SELECT * FROM funnel_stages;

---2) Define Sale Funnel and the Different Stages (Corrected for PostgreSQL):
WITH funnel_stages AS (
    SELECT 
        COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) as views,
        COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN user_id END) as carts,
        COUNT(DISTINCT CASE WHEN event_type = 'checkout_start' THEN user_id END) as checkouts,
        COUNT(DISTINCT CASE WHEN event_type = 'payment_info' THEN user_id END) as payments,
        COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) as purchases
    FROM user_events
    WHERE event_date >= (SELECT MAX(event_date) FROM user_events) - INTERVAL '90 days'
) -- এখানে কোনো সেমিকোলন হবে না। ডাটাসেটের লেটেস্ট ডেট থেকে পিছনের ৩০ দিনের ডাটা নিয়েছে।
SELECT * FROM funnel_stages; -- সেমিকোলন হবে একদম শেষে



---3) Conversion Rate through the Funnel:

WITH funnel_stages AS (
    SELECT 
        COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) as views_,
        COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN user_id END) as carts,
        COUNT(DISTINCT CASE WHEN event_type = 'checkout_start' THEN user_id END) as checkouts,
        COUNT(DISTINCT CASE WHEN event_type = 'payment_info' THEN user_id END) as payments,
        COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) as purchases
    FROM user_events
    WHERE event_date >= (SELECT MAX(event_date) FROM user_events) - INTERVAL '90 days'
) -- এখানে কোনো সেমিকোলন হবে না এবং ইন্টার দেওয়া যাবে না।
SELECT 
	views_,
	carts,
	round(carts*100/views_) AS view_to_cart_rate,    				---Bottoleneck between view to carts: 
	checkouts,
	round(checkouts*100/carts) AS carts_to_checkouts_rate,
	payments,
	round(payments*100/checkouts) AS payments_to_checkouts_rate,
	purchases,
	round(purchases*100/payments) AS payment_to_purchase_rate,
	round(purchases*100/views_) AS overall_conversion_rate
FROM funnel_stages;



---4) Funnel By Source:
WITH funnel_by_source AS (
SELECT traffic_source,
    COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) as views_,
        COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN user_id END) as carts,
        COUNT(DISTINCT CASE WHEN event_type = 'checkout_start' THEN user_id END) as checkouts,
        COUNT(DISTINCT CASE WHEN event_type = 'payment_info' THEN user_id END) as payments,
        COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) as purchases
    FROM user_events
  	WHERE event_date >= (SELECT MAX(event_date) FROM user_events) - INTERVAL '30 days'
    GROUP BY traffic_source 
)
SELECT * FROM funnel_by_source;



---5) Funnel By Source and Conversion Rate:
WITH funnel_by_source AS (
SELECT traffic_source,
    COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) as views_,
        COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN user_id END) as carts,
        COUNT(DISTINCT CASE WHEN event_type = 'checkout_start' THEN user_id END) as checkouts,
        COUNT(DISTINCT CASE WHEN event_type = 'payment_info' THEN user_id END) as payments,
        COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) as purchases
    FROM user_events
	WHERE event_date >= (SELECT MAX(event_date) FROM user_events) - INTERVAL '90 days'
    GROUP BY traffic_source 
)
SELECT
traffic_source,
views_,
carts,
purchases,
round(carts*100/views_) AS cart_Conversion_Rate,
round(purchases*100/carts) AS purchaseCart_Conversion_Rate,
round(purchases*100/views_) AS purchaseView_Conversion_Rate
FROM funnel_by_source ORDER BY purchases DESC;

---6) Conversion Time  Analysis:
'''WITH user_journey AS (
SELECT 
user_id,
min(CASE WHEN event_type = 'page_view' THEN event_date END) AS view_time,
min(CASE WHEN event_type = 'add_to_cart' THEN event_date END) AS cart_time,
min(CASE WHEN event_type = 'purchase' THEN event_date END) AS purchase_time
FROM user_events 
WHERE event_date >= (SELECT MAX(event_date) FROM user_events) - INTERVAL '30 days'
GROUP BY user_id 
HAVING min(CASE WHEN event_type = 'purchase' THEN event_date END ) IS NOT NULL
)
SELECT
count(*) AS converted_users,
round(avg(timestamp_diff(cart_time,view_time, MINUTE  ) ),2) AS avg_view_to_cart_minutes,
round(avg(timestamp_diff(purchase_time,cart_time, MINUTE )),2) AS avg_cart_to_purchase_minutes,
round(avg(timestamp_diff(purchase_time,view_time, MINUTE )),2) AS avg_total_journey_minutes
FROM user_journey;'''

 (corrected for postgresql)

WITH user_journey AS (
    SELECT 
        user_id,
        MIN(CASE WHEN event_type = 'page_view' THEN event_date END) AS view_time,
        MIN(CASE WHEN event_type = 'add_to_cart' THEN event_date END) AS cart_time,
        MIN(CASE WHEN event_type = 'purchase' THEN event_date END) AS purchase_time
    FROM user_events
    WHERE event_date >= (SELECT MAX(event_date) FROM user_events) - INTERVAL '30 days'
    GROUP BY user_id
    HAVING MIN(CASE WHEN event_type = 'purchase' THEN event_date END) IS NOT NULL
)
SELECT
    COUNT(*) AS converted_users,
    ROUND(AVG(EXTRACT(EPOCH FROM (cart_time - view_time))/60), 2) AS avg_view_to_cart_minutes,
    ROUND(AVG(EXTRACT(EPOCH FROM (purchase_time - cart_time))/60), 2) AS avg_cart_to_purchase_minutes,
    ROUND(AVG(EXTRACT(EPOCH FROM (purchase_time - view_time))/60), 2) AS avg_total_journey_minutes
FROM user_journey;

---7) Revenue Funnel Analysis:
WITH funnel_revenue AS (
    SELECT 
        COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) AS total_visitors,
        COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS total_buyers,
        SUM(CASE WHEN event_type = 'purchase' THEN amount END) AS total_revenue,
        COUNT(CASE WHEN event_type = 'purchase' THEN 1 END) AS total_orders
    FROM user_events
    WHERE event_date >= (
        SELECT MAX(event_date) FROM user_events
    ) - INTERVAL '30 days'
)
SELECT
    total_visitors,
    total_buyers,
    total_revenue,
    total_orders,
    ROUND((total_revenue / NULLIF(total_orders,0))::numeric, 2) AS avg_order_value,
    ROUND((total_revenue / NULLIF(total_buyers,0))::numeric, 2) AS revenue_per_buyer,
    ROUND((total_revenue / NULLIF(total_visitors,0))::numeric, 2) AS revenue_per_visitor
FROM funnel_revenue;
```
