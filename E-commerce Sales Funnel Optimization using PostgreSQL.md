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

📂 Dataset Structure

Table Name: user_events

event_id|user_id|event_type    |event_date                   |product_id|amount|traffic_source|
--------+-------+--------------+-----------------------------+----------+------+--------------+
    8490|   5024|page_view     |2025-12-30 04:58:24.517 +0600|       205|      |social        |
    2296|   1713|page_view     |2025-12-30 05:10:26.276 +0600|       201|      |organic       |
    3896|   2558|page_view     |2025-12-30 05:11:09.001 +0600|       404|      |organic       |
    2297|   1713|add_to_cart   |2025-12-30 05:13:26.276 +0600|       201|      |organic       |
    2298|   1713|checkout_start|2025-12-30 05:16:26.276 +0600|       201|      |organic       |
    8438|   4993|page_view     |2025-12-30 05:20:55.416 +0600|       205|      |organic       |
    2299|   1713|payment_info  |2025-12-30 05:23:26.276 +0600|       201|      |organic       |
    2300|   1713|purchase      |2025-12-30 05:25:26.276 +0600|       201|  48.3|organic       |
    8649|   5102|page_view     |2025-12-30 05:25:27.600 +0600|       102|      |organic       |
    3897|   2558|add_to_cart   |2025-12-30 05:29:09.001 +0600|       404|      |organic       |
    2101|   1591|page_view     |2025-12-30 05:42:46.668 +0600|       305|      |organic       |
    3368|   2276|page_view     |2025-12-30 05:48:25.516 +0600|       201|      |organic       |
    8335|   4942|page_view     |2025-12-30 06:01:39.005 +0600|       205|      |organic       |
    3369|   2276|add_to_cart   |2025-12-30 06:03:25.516 +0600|       201|      |organic       |
    7020|   4279|page_view     |2025-12-30 06:27:01.633 +0600|       101|      |social        |
    3889|   2554|page_view     |2025-12-30 06:27:29.959 +0600|       102|      |paid_ads      |
    2547|   1850|page_view     |2025-12-30 06:28:28.075 +0600|       205|      |organic       |
    2548|   1850|add_to_cart   |2025-12-30 06:46:28.075 +0600|       205|      |organic       |
    2549|   1850|checkout_start|2025-12-30 06:49:28.075 +0600|       205|      |organic       |
    2550|   1850|payment_info  |2025-12-30 06:56:28.075 +0600|       205|      |organic       |
