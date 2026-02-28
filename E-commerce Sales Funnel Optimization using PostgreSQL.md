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

Column	Description
event_id	Unique event ID
user_id	Unique user
event_type	page_view, add_to_cart, checkout_start, payment_info, purchase
event_date	Timestamp
product_id	Product
amount	Revenue (only for purchase)
traffic_source	organic, paid_ads, email, social
