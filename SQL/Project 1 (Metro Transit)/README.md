# 🚇 Metro Transit System — SQL Data Analysis & Business Insights

## 📌 Project Overview

The **Metro Transit System SQL Data Analysis Project** analyzes metro booking data to uncover insights into **route performance, revenue, train utilization, station activity, fare behavior, passenger demographics, and customer retention**.

The project demonstrates how SQL can be used to transform relational transit data into meaningful **business insights and operational recommendations**.

---

## 🎯 Project Objectives

* Analyze metro booking and revenue performance
* Identify high-performing route lines and trains
* Evaluate station-level booking activity
* Understand fare distribution and passenger spending
* Analyze passenger demographics and repeat ridership
* Monitor monthly booking trends
* Demonstrate advanced SQL querying techniques
* Generate actionable business recommendations

---

## 📊 Key Business Metrics

| Metric                    |        Value |
| ------------------------- | -----------: |
| 🏢 Stations               |           25 |
| 🚆 Trains                 |           20 |
| 🛤️ Route Lines           |            4 |
| 👥 Registered Passengers  |          465 |
| 🎫 Total Bookings         |        1,490 |
| 💰 Total Fare Revenue     |   Rs 146,092 |
| 💵 Average Fare / Booking |     Rs 98.05 |
| ⏱️ Average Travel Time    | 52.6 minutes |
| 🔁 Repeat Riders          |        87.3% |

---

## 🔍 Key Insights

### 🛤️ Route Performance

**Line 3** is the strongest-performing route with:

* **526 bookings**
* **Rs 52,723 revenue**

**Line 4** has the lowest booking and revenue volume among the four route lines.

| Route Line | Bookings |   Revenue |
| ---------- | -------: | --------: |
| Line 3     |      526 | Rs 52,723 |
| Line 5     |      439 | Rs 42,024 |
| Line 2     |      294 | Rs 28,627 |
| Line 4     |      231 | Rs 22,718 |

---

### 🚆 Train Utilization

The 20-train fleet shows relatively balanced demand.

* Top booking volume: **84 bookings**
* Reported booking range: approximately **59–84 bookings**
* **Teal Line Express** and **Purple Line Local** share the highest booking count at **84 each**.

---

### 🚉 Top Boarding Stations

**Old Fort, Chennai** is the highest-revenue boarding station.

| Station      | Bookings |  Revenue |
| ------------ | -------: | -------: |
| Old Fort     |       70 | Rs 7,235 |
| Harbor Point |       65 | Rs 7,024 |
| Metro Mall   |       65 | Rs 6,716 |
| Tech Park    |       72 | Rs 6,681 |
| Lakeview     |       64 | Rs 6,559 |

---

### 💳 Fare Analysis

Bookings were classified into three fare categories using a SQL `CASE` statement:

* **High Fare:** > Rs 100
* **Medium Fare:** Rs 50–100
* **Low Fare:** < Rs 50

High Fare bookings represent **48.1%** of total bookings, making them the largest fare category.

---

### 👥 Passenger Behavior

The analysis shows strong repeat ridership:

> **87.3% of active riders are repeat passengers.**

The highest-spending passenger is **Ritu Patel**, with:

* **9 trips**
* **Rs 1,081.06 total fare**

The top five passengers contributed **Rs 4,623.21** in combined fare revenue.

---

### 📅 Monthly Booking Trend

Booking activity remained relatively stable from **April through June 2026**, averaging roughly 400 bookings per month.

The lower July figure should not be interpreted as a demand decline because the dataset only covers **July 1–20, 2026**.

---

## 🗺️ Network & Infrastructure Insights

* 25 stations across **5 cities and 5 zones**
* Every station recorded both boarding and destination activity
* **North Zone** has the most stations: 8
* **Central Zone** has the fewest stations: 3
* **Lakeview (Pune)** and **University Gate (Kochi)** are the oldest stations, opened in 1998
* **South Terminus (Chennai)** is the newest station, opened in 2022
* Train capacity ranges from **180 to 320 seats**
* Average train capacity is **245 seats**
* **Kochi** has the highest number of stations: 6

---

## 🗄️ Database Structure

The database follows a relational design centered around the **`TicketBookings`** table.

### Core Entities

```text
Passengers
    │
    │
    ▼
TicketBookings ───────► Trains
    │
    ├──────────────► Boarding Station
    │
    └──────────────► Destination Station
```

`TicketBookings` acts as the central fact table, connecting passenger and train information while referencing the station table for both boarding and destination locations.

---

## 🧠 SQL Concepts Demonstrated

### Database Design & Constraints

* Primary Key
* Foreign Key
* Unique Constraint
* Default Constraint
* Check Constraint

### Aggregations

* `COUNT()`
* `SUM()`
* `AVG()`
* `COUNT(DISTINCT)`
* `GROUP BY`
* `HAVING`

### Joins

* `INNER JOIN`
* `LEFT JOIN`
* Multiple-table Joins

### Advanced SQL

* Subqueries
* CTEs
* Views
* `CASE`
* Window Functions
* `RANK()`
* `DENSE_RANK()`
* `LAG()`
* `LEAD()`

### Text & Date Functions

* `UPPER()`
* `LENGTH()`
* `MONTH()`
* `YEAR()`
* `DAYNAME()`
* `DATEDIFF()`
* `DATE_ADD()`

### Database Management

* Transactions
* `ROLLBACK`
* Indexes
* Composite Indexes

---

## 💡 Business Recommendations

### 1. Route & Capacity Planning

Line 3 has the highest booking and revenue load. Peak-hour capacity and maintenance planning should prioritize this route.

### 2. Premium-Seat Strategy

Premium seating generates meaningful revenue despite having significantly fewer bookings than General seating. Targeted upselling and increased Premium availability could improve revenue per booking.

### 3. Station Resource Allocation

High-performing stations such as Old Fort should receive appropriate staffing and amenities while lower-traffic stations continue to be monitored.

### 4. Passenger Retention

With **87.3% repeat ridership**, a loyalty or frequent-rider program could help convert more first-time passengers into regular users.

### 5. Fare Optimization

High Fare journeys represent **48.1% of bookings**. Bundled or return-fare options could be used to grow Medium and Low Fare segments while protecting the existing high-value customer base.

### 6. Data Quality

**15 passengers (3.2%)** have no email address recorded. Improving email collection could strengthen future retention and marketing campaigns.

---

## 🧪 Sample SQL Analysis

### Find trains booked more than 60 times

```sql
SELECT 
    train_name,
    COUNT(DISTINCT booking_id) AS total_bookings
FROM Trains t
INNER JOIN TicketBookings tb
    ON t.train_id = tb.train_id
GROUP BY train_name
HAVING total_bookings > 60
ORDER BY total_bookings DESC;
```

### Calculate total fare per passenger using a CTE

```sql
WITH TotalFare AS (
    SELECT
        passenger_id,
        SUM(fare) AS total_fare
    FROM TicketBookings
    GROUP BY passenger_id
)
SELECT *
FROM TotalFare
ORDER BY total_fare DESC;
```

### Categorize bookings by fare

```sql
SELECT
    booking_id,
    fare,
    CASE
        WHEN fare > 100 THEN 'High Fare'
        WHEN fare BETWEEN 50 AND 100 THEN 'Medium Fare'
        ELSE 'Low Fare'
    END AS fare_category
FROM TicketBookings;
```

### Rank fares within each train

```sql
SELECT
    booking_id,
    train_id,
    fare,
    DENSE_RANK() OVER (
        PARTITION BY train_id
        ORDER BY fare DESC
    ) AS rank_in_train
FROM TicketBookings;
```

### Create a composite index

```sql
CREATE INDEX idx_boarding_destination
ON TicketBookings (
    boarding_station_id,
    destination_station_id
);
```

---

## 📈 Project Outcomes

This project demonstrates how SQL can support:

* 🚆 Transit demand analysis
* 💰 Revenue analysis
* 🛤️ Route performance evaluation
* 🚉 Station performance monitoring
* 👥 Customer behavior analysis
* 🎫 Fare segmentation
* 🔁 Passenger retention analysis
* 📊 Operational decision-making

---

## 🛠️ Skills Demonstrated

**SQL | Relational Database Design | Data Analysis | Business Intelligence | Data Aggregation | Joins | CTEs | Subqueries | Views | Window Functions | Data Segmentation | Business Insights**

---

## 👩‍💻 Author

**Prativa Baliarsingh**

Data Science & Data Analytics Enthusiast

---

## ⭐ Project Highlights

> **1,490 bookings analyzed | Rs 146K+ revenue | 25 stations | 20 trains | 4 route lines | 87.3% repeat ridership**

This project showcases the use of SQL not only for querying data, but also for turning operational data into **actionable business insights**.

