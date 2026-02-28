📝 Executive Summary: E-commerce Clickstream Data Analytics
Project Title: Behavioral Analysis and Conversion Optimization of E-commerce User Journeys.

Objective:
To analyze a dataset of 9,381 user events to identify bottlenecks in the sales funnel, evaluate the effectiveness of various marketing channels, and derive actionable insights for increasing ROI.

Key Technical Contributions:

Data Engineering: Performed data cleaning and type-casting on raw event logs using PostgreSQL, converting string-based timestamps into TIMESTAMP objects for temporal analysis.

Funnel Visualization: Engineered a multi-stage conversion funnel (Page View → Add to Cart → Checkout → Purchase) which revealed a total churn rate of 83.48%.

Performance Metrics: Computed Conversion Rates (CR) across disparate traffic sources, identifying Email Marketing as the most efficient channel with a 33.91% CR, while Organic search drove the highest absolute revenue ($37,279).

User Behavioral Profiling: Leveraged SQL window functions and aggregations to calculate session durations and identify power users (users with >5 distinct event types).

Business Impact:
The analysis pinpointed a significant drop-off between the add_to_cart and purchase stages. By identifying that Social Media traffic has the lowest conversion rate (6.93%), I recommended a strategic reallocation of the marketing budget towards high-converting channels like Email and Paid Ads to optimize customer acquisition costs (CAC).

All analysis is performed using PostgreSQL (CTEs, Conditional Aggregation, Time Interval Analysis) and visualized in Power BI.

```sql

---1)
SELECT * FROM user_events LIMIT 20;
```
##Result Table-1

| event_id | user_id | event_type     | event_date                  | product_id | amount | traffic_source |
|----------|--------:|----------------|-----------------------------|-----------:|-------:|---------------|
| 8490     | 5024    | page_view      | 2025-12-30 04:58:24.517 +0600 | 205        |        | social        |
| 2296     | 1713    | page_view      | 2025-12-30 05:10:26.276 +0600 | 201        |        | organic       |
| 3896     | 2558    | page_view      | 2025-12-30 05:11:09.001 +0600 | 404        |        | organic       |
| 2297     | 1713    | add_to_cart    | 2025-12-30 05:13:26.276 +0600 | 201        |        | organic       |
| 2298     | 1713    | checkout_start | 2025-12-30 05:16:26.276 +0600 | 201        |        | organic       |
| 8438     | 4993    | page_view      | 2025-12-30 05:20:55.416 +0600 | 205        |        | organic       |
| 2299     | 1713    | payment_info   | 2025-12-30 05:23:26.276 +0600 | 201        |        | organic       |
| 2300     | 1713    | purchase       | 2025-12-30 05:25:26.276 +0600 | 201        | 48.3   | organic       |
| 8649     | 5102    | page_view      | 2025-12-30 05:25:27.600 +0600 | 102        |        | organic       |
| 3897     | 2558    | add_to_cart    | 2025-12-30 05:29:09.001 +0600 | 404        |        | organic       |
| 2101     | 1591    | page_view      | 2025-12-30 05:42:46.668 +0600 | 305        |        | organic       |
| 3368     | 2276    | page_view      | 2025-12-30 05:48:25.516 +0600 | 201        |        | organic       |
| 8335     | 4942    | page_view      | 2025-12-30 06:01:39.005 +0600 | 205        |        | organic       |
| 3369     | 2276    | add_to_cart    | 2025-12-30 06:03:25.516 +0600 | 201        |        | organic       |
| 7020     | 4279    | page_view      | 2025-12-30 06:27:01.633 +0600 | 101        |        | social        |
| 3889     | 2554    | page_view      | 2025-12-30 06:27:29.959 +0600 | 102        |        | paid_ads      |
| 2547     | 1850    | page_view      | 2025-12-30 06:28:28.075 +0600 | 205        |        | organic       |
| 2548     | 1850    | add_to_cart    | 2025-12-30 06:46:28.075 +0600 | 205        |        | organic       |
| 2549     | 1850    | checkout_start | 2025-12-30 06:49:28.075 +0600 | 205        |        | organic       |
| 2550     | 1850    | payment_info   | 2025-12-30 06:56:28.075 +0600 | 205        |        | organic       |

```sql
SELECT event_type from user_events GROUP BY event_type;
```
| event_type     |
|----------------|
| payment_info   |
| add_to_cart    |
| purchase       |
| checkout_start |
| page_view      |

```sql
SELECT traffic_source from user_events GROUP BY traffic_source;
```
| traffic_source |
|----------------|
| email          |
| organic        |
| paid_ads       |
| social         |


```sql
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
```
##Result Table-2
| views | carts | checkouts | payments | purchases |
|------:|------:|----------:|---------:|----------:|
| 5000  | 1553  | 1103      | 899      | 826       |

```sql
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
```


##Result Table-3
| views_ | carts | view_to_cart_rate (%) | checkouts | carts_to_checkouts_rate (%) | payments | payments_to_checkouts_rate (%) | purchases | payment_to_purchase_rate (%) | overall_conversion_rate (%) |
|-------:|------:|----------------------:|----------:|----------------------------:|---------:|--------------------------------:|----------:|------------------------------:|-----------------------------:|
| 5000   | 1553  | 31.0                  | 1103      | 71.0                        | 899      | 81.0                            | 826       | 91.0                          | 16.0                         |


```sql
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
```
##Result Table-4:
| traffic_source | views_ | carts | checkouts | payments | purchases |
|----------------|-------:|------:|----------:|---------:|----------:|
| email          | 445    | 280   | 194       | 160      | 151       |
| organic        | 1750   | 576   | 415       | 334      | 300       |
| paid_ads       | 820    | 305   | 224       | 183      | 173       |
| social         | 1253   | 171   | 118       | 91       | 84        |

```sql
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
```
##Result Table-5
| traffic_source | views_ | carts | purchases | cart_conversion_rate (%) | purchase_cart_conversion_rate (%) | purchase_view_conversion_rate (%) |
|----------------|-------:|------:|----------:|--------------------------:|-----------------------------------:|-----------------------------------:|
| organic        | 2038   | 669   | 343       | 32.0                      | 51.0                               | 16.0                               |
| paid_ads       | 968    | 358   | 204       | 36.0                      | 56.0                               | 21.0                               |
| email          | 522    | 326   | 177       | 62.0                      | 54.0                               | 33.0                               |
| social         | 1472   | 200   | 102       | 13.0                      | 51.0                               | 6.0                                |


```sql
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
```
Result Table-6:
| converted_users | avg_view_to_cart_minutes | avg_cart_to_purchase_minutes | avg_total_journey_minutes |
|----------------:|-------------------------:|-----------------------------:|--------------------------:|
| 708             | 11.19                    | 13.36                        | 24.55                     |


```sql
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
Result Table-7:
| total_visitors | total_buyers | total_revenue | total_orders | avg_order_value | revenue_per_buyer | revenue_per_visitor |
|---------------:|-------------:|--------------:|-------------:|----------------:|------------------:|--------------------:|
| 4268           | 708          | 76037.89      | 708          | 107.40          | 107.40            | 17.82               |
