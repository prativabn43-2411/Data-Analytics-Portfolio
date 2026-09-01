# 🛰️ OrbitLink — Satellite Internet Network SQL Analytics

> **End-to-end SQL Database Management & Analytics Project**
> MySQL • Relational Database Design • Advanced SQL • Data Quality • Performance Optimization • Business Intelligence

---

## 📌 Project Overview

**OrbitLink** is an end-to-end SQL database and analytics project designed around a fictional satellite internet service provider.

The project demonstrates how a real-world operational database can be designed, populated, queried, validated, optimized, and converted into meaningful business and network insights.

The database models key areas of a satellite internet business, including:

* 👥 Customers
* 💳 Subscriptions
* 🛰️ Satellites
* 🏢 Ground Stations
* 🔧 Maintenance Activities
* 📡 Internet Usage Sessions

The project combines **relational database design, SQL analytics, data quality validation, performance optimization, reporting views, and security controls** into one portfolio-ready solution.

---

## 🎯 Project Objectives

The main objectives of this project are to:

1. Design a normalized relational database for a satellite internet business.
2. Create relationships between customers, subscriptions, satellites, stations, maintenance, and usage.
3. Populate the database with a realistic operational dataset.
4. Develop SQL queries to answer business and technical questions.
5. Analyze customer subscriptions and usage behavior.
6. Monitor satellite and network performance.
7. Analyze maintenance activity and downtime.
8. Calculate revenue and business KPIs.
9. Perform data-quality and integrity checks.
10. Optimize frequently used queries with indexes and views.
11. Demonstrate advanced SQL techniques.
12. Apply database security and role-based access principles.

---

## 🗂️ Database Architecture

The project uses a relational MySQL database containing **6 core tables** and approximately **20,000 records**.

### Core Entities

| Table            | Purpose                                       |
| ---------------- | --------------------------------------------- |
| `Customers`      | Stores customer and account information       |
| `Subscriptions`  | Stores customer subscription plans and status |
| `Satellites`     | Stores satellite operational information      |
| `GroundStations` | Stores ground station information             |
| `Maintenance`    | Records satellite maintenance activities      |
| `UsageLogs`      | Stores individual internet usage sessions     |

### Relationship Overview

```text
Customers
    │
    │ 1:N
    ▼
Subscriptions


Satellites
    │
    ├──────────────► Maintenance
    │
    └──────────────► UsageLogs
                         ▲
                         │
GroundStations ──────────┘
```

The **EER model** defines the primary keys, foreign keys, cardinality, and relationships between the operational entities.

---

## 📊 Dataset

The project uses a substantial synthetic operational dataset suitable for SQL analysis.

### Dataset Highlights

* **20,000+ total records**
* **700 customers**
* **18,200 usage sessions**
* Multiple subscription plans
* Multiple satellites
* Ground station records
* Maintenance history
* Customer activity and usage data

The dataset is designed to provide enough variation for aggregation, ranking, trend analysis, anomaly detection, and performance-related queries.

---

## 💻 SQL Skills Demonstrated

This project goes beyond basic `SELECT` statements and demonstrates a broad range of SQL capabilities.

### Basic & Intermediate SQL

* `SELECT`
* `WHERE`
* `ORDER BY`
* `GROUP BY`
* `HAVING`
* `DISTINCT`
* `CASE`
* `COALESCE`
* `NULL` handling
* Aggregate functions
* Multi-table joins

### Joins

```sql
INNER JOIN
LEFT JOIN
RIGHT JOIN
SELF JOIN
```

### Advanced SQL

The project includes examples of:

* Common Table Expressions — `WITH`
* Subqueries
* Correlated subqueries
* Derived tables
* Window functions
* Ranking
* Running totals
* Moving averages
* Time-series analysis
* Customer segmentation
* Comparative analysis

### Window Functions

Examples include:

```sql
ROW_NUMBER()
RANK()
DENSE_RANK()
NTILE()
LAG()
LEAD()
```

These are used for ranking customers, comparing consecutive records, calculating trends, and identifying changes in operational metrics.

---

## 📈 Business Questions Answered

The project contains **75 analytical and business scenarios** covering multiple areas of the organization.

### 👥 Customer Analytics

Examples:

* Who are the most active customers?
* Which customers generate the highest usage?
* Which customers have inactive subscriptions?
* What are customer usage patterns?
* How does customer activity vary across plans?

### 💳 Subscription & Revenue Analytics

Examples:

* How many active subscriptions exist?
* Which plans generate the most revenue?
* What is the average subscription value?
* Which customers have multiple subscriptions?
* How does revenue vary by subscription type?

### 🛰️ Satellite Operations

Examples:

* Which satellites have the highest operational activity?
* Which satellites experience maintenance events?
* How frequently are satellites maintained?
* Which satellites have higher downtime?

### 📡 Network Performance

Examples:

* What is the average latency?
* Which satellites have the best/worst performance?
* Which sessions experience high latency?
* How does network performance change over time?

### 🔧 Maintenance Analytics

Examples:

* Which satellites require the most maintenance?
* What is the total maintenance downtime?
* Which maintenance activities have the highest impact?
* What are the most maintenance-intensive assets?

### 📊 Usage Analytics

Examples:

* What are the busiest usage periods?
* Which customers consume the most data?
* What is the average session duration?
* How does usage vary across satellites and stations?

---

## 🧠 Advanced Analytics

One of the main goals of the project is demonstrating analytical SQL that would be useful in a real data environment.

### Customer Ranking

```sql
SELECT
    CustomerID,
    SUM(DataUsedGB) AS TotalDataUsed,
    RANK() OVER (
        ORDER BY SUM(DataUsedGB) DESC
    ) AS UsageRank
FROM UsageLogs
GROUP BY CustomerID;
```

### Previous Session Comparison

```sql
SELECT
    CustomerID,
    SessionStart,
    DataUsedGB,
    LAG(DataUsedGB) OVER (
        PARTITION BY CustomerID
        ORDER BY SessionStart
    ) AS PreviousDataUsed
FROM UsageLogs;
```

### Customer Segmentation

```sql
SELECT
    CustomerID,
    TotalDataUsed,
    NTILE(4) OVER (
        ORDER BY TotalDataUsed DESC
    ) AS UsageQuartile
FROM CustomerUsage;
```

These techniques demonstrate the ability to move from simple reporting to more advanced analytical workflows.

---

## 🔍 Data Quality & Validation

Data quality is treated as an important part of the project rather than an afterthought.

Validation scenarios include:

* Duplicate detection
* Missing-value detection
* Invalid foreign keys
* Orphan records
* Invalid dates
* Invalid subscription states
* Negative or unrealistic values
* Referential-integrity checks
* Record-count validation

Example:

```sql
SELECT CustomerID, COUNT(*) AS DuplicateCount
FROM Customers
GROUP BY CustomerID
HAVING COUNT(*) > 1;
```

---

## ⚡ Performance Optimization

The project also demonstrates database performance considerations.

### Indexing

Indexes are applied to frequently searched and joined columns to improve query performance.

Examples include indexes associated with:

* Customer identifiers
* Subscription identifiers
* Satellite identifiers
* Usage timestamps
* Maintenance records

### Query Optimization

The project considers:

* Efficient joins
* Filtering before aggregation
* Index usage
* Avoiding unnecessary columns
* Reusable reporting views
* Query execution plans

`EXPLAIN` can be used to investigate query execution behavior and identify potential bottlenecks.

---

## 👁️ Reporting Views

Reusable SQL views are included to simplify recurring analysis and reporting.

Examples of potential reporting layers include:

```text
Customer Usage Summary
Satellite Performance Summary
Subscription Revenue Summary
Maintenance Summary
Network Performance Summary
```

Views help separate the analytical/reporting layer from the underlying transactional tables.

---

## 🔐 Database Security

The project also demonstrates fundamental database security concepts.

Security considerations include:

* User roles
* Read-only access
* Controlled write permissions
* Least-privilege access
* Separation of operational and reporting responsibilities

Example role structure:

```text
Database Administrator
        │
        ├── Full database access
        │
Analyst
        │
        └── Read/reporting access
```

---

## 📁 Project Structure

A recommended repository structure is:

```text
OrbitLink-SQL-Analytics/
│
├── README.md
│
├── sql/
│   ├── 01_database_setup.sql
│   ├── 02_create_tables.sql
│   ├── 03_insert_data.sql
│   ├── 04_basic_queries.sql
│   ├── 05_advanced_queries.sql
│   ├── 06_data_quality.sql
│   ├── 07_views.sql
│   ├── 08_indexes.sql
│   └── 09_security.sql
│
├── data/
│   └── sample_data/
│
├── diagrams/
│   └── orbitlink_eer_diagram.png
│
├── reports/
│   └── OrbitLink_SQL_Project_Report.pdf
│
└── screenshots/
    └── query_results/
```

---

## 🛠️ Technology Stack

| Technology           | Purpose                                |
| -------------------- | -------------------------------------- |
| **MySQL**            | Relational database                    |
| **SQL**              | Data manipulation & analytics          |
| **MySQL Workbench**  | Database development & EER modeling    |
| **Excel / BI tools** | Supporting analysis & visualization    |
| **Git & GitHub**     | Version control & project presentation |

---

## 🚀 How to Run the Project

### 1. Clone the repository

```bash
git clone https://github.com/YOUR-USERNAME/OrbitLink-SQL-Analytics.git
```

### 2. Open MySQL Workbench

Connect to your MySQL server.

### 3. Create the database

Run:

```sql
CREATE DATABASE OrbitLink;
USE OrbitLink;
```

### 4. Create the tables

Run the table creation script:

```text
sql/02_create_tables.sql
```

### 5. Load the dataset

Run:

```text
sql/03_insert_data.sql
```

### 6. Execute analytical queries

Explore:

```text
sql/04_basic_queries.sql
sql/05_advanced_queries.sql
```

### 7. Explore optimization and security

Run:

```text
sql/06_data_quality.sql
sql/07_views.sql
sql/08_indexes.sql
sql/09_security.sql
```

---

## 📌 Key Deliverables

The project produces several portfolio-ready deliverables:

* ✅ Relational database schema
* ✅ EER diagram
* ✅ Data dictionary
* ✅ Synthetic operational dataset
* ✅ 75 SQL business scenarios
* ✅ Advanced analytical queries
* ✅ Data-quality checks
* ✅ Performance optimization examples
* ✅ Reporting views
* ✅ Database security examples
* ✅ KPI analysis
* ✅ Professional project report

---

## 📊 Example KPI Categories

The project analyzes KPIs across four major areas:

### Customer KPIs

* Total customers
* Active customers
* Customer activity
* Average usage
* Customer segmentation

### Revenue KPIs

* Subscription revenue
* Revenue by plan
* Revenue by customer
* Active subscription count

### Network KPIs

* Average latency
* Session volume
* Data consumption
* Satellite utilization
* Ground station activity

### Maintenance KPIs

* Maintenance events
* Total downtime
* Maintenance frequency
* Satellite reliability

---

## 💡 Business Impact

The project demonstrates how SQL can support decisions across an organization.

### For Network Engineers

Identify satellite performance issues, latency patterns, and network activity.

### For Maintenance Teams

Track maintenance frequency, downtime, and asset reliability.

### For Finance Teams

Analyze subscription revenue and customer value.

### For Customer Support

Understand customer activity and usage history.

### For Data Analysts

Create repeatable analytical queries, KPIs, and reporting datasets.

---

## 🎓 What I Learned

Through this project, I strengthened my ability to:

* Design relational databases
* Translate business requirements into SQL
* Work with large relational datasets
* Write complex joins
* Use advanced window functions
* Build analytical CTEs
* Perform data-quality checks
* Optimize SQL queries
* Create reusable reporting views
* Apply database security principles
* Present technical findings professionally

---

## 🔮 Future Improvements

Possible future enhancements include:

* Interactive Power BI dashboard
* Automated ETL pipeline
* Stored procedures for recurring reports
* Automated data-quality monitoring
* Query-performance benchmarking
* Satellite anomaly detection
* Customer churn prediction
* Predictive maintenance analysis
* Real-time network monitoring
* Cloud database deployment

---

## 👤 Author

**Prativa Baliarsingh**

This project was developed as a portfolio demonstration of **SQL, relational database design, data analytics, and business intelligence skills**.

---

## ⭐ Why This Project Matters

OrbitLink demonstrates the complete lifecycle of a database analytics project:

```text
Business Problem
       ↓
Data Modeling
       ↓
Database Design
       ↓
Data Loading
       ↓
SQL Analysis
       ↓
Data Quality
       ↓
Performance Optimization
       ↓
Security
       ↓
KPI & Reporting
       ↓
Business Insights
```

It showcases the ability to move from **raw operational data to structured analysis and actionable insights using SQL**.

---

## 📄 Project Report

A detailed professional project report is included in the repository covering:

* Database architecture
* Data dictionary
* EER model
* SQL scenarios
* Analytical findings
* KPIs
* Performance optimization
* Security
* Data-quality validation
* Project conclusions

---

### ⭐ If you find this project useful, consider giving the repository a star!

