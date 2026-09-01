# 🐾 WildTrack Conservation Alliance — Wildlife Conservation SQL Project

## 📌 Project Overview

**WildTrack Conservation Alliance** is a wildlife conservation database project designed to demonstrate how SQL can be used to manage, analyze, and monitor wildlife tracking operations.

The project models a real-world conservation environment where GPS collars are fitted to animals and continuously generate location, movement, temperature, and battery-health data.

The database provides a centralized relational system for **reserves, species, animals, and GPS tracking logs**, helping conservation teams identify monitoring gaps, battery issues, unusual movement, data-quality problems, and reserve-level trends.

---

## 🎯 Project Objectives

* Manage wildlife data using a normalized relational database.
* Monitor individual animals and their GPS tracking history.
* Identify inactive or under-reporting animals.
* Monitor collar battery health and ageing equipment.
* Analyze species populations and reserve coverage.
* Detect and correct data-quality issues.
* Improve query performance using indexing.
* Implement role-based database security.
* Convert operational conservation problems into actionable SQL insights.

---

## 🗄️ Database Architecture

The project contains **4 interconnected tables**:

```text
                 ┌──────────────┐
                 │   Reserves   │
                 └──────┬───────┘
                        │
                        │ 1 : Many
                        ▼
                 ┌──────────────┐
                 │   Animals    │
                 └──────┬───────┘
                        │
                        │ 1 : Many
                        ▼
                 ┌──────────────┐
                 │   GPSLogs    │
                 └──────────────┘

                 ┌──────────────┐
                 │   Species    │
                 └──────┬───────┘
                        │
                        │ 1 : Many
                        ▼
                     Animals
```

### Tables

| Table      | Purpose                                                      |
| ---------- | ------------------------------------------------------------ |
| `Reserves` | Stores wildlife reserve information                          |
| `Species`  | Stores species and conservation status                       |
| `Animals`  | Stores individual tracked animals                            |
| `GPSLogs`  | Stores GPS location, speed, temperature and battery readings |

The dataset contains **15 reserves, 25 species, 200 animals, and 9,760 GPS log records — 10,000 rows in total**.

---

## 🧠 SQL Concepts Demonstrated

This project covers a wide range of practical SQL concepts:

### Basic SQL

* `SELECT`
* `WHERE`
* `DISTINCT`
* `ORDER BY`
* `GROUP BY`
* `HAVING`

### Aggregation

* `COUNT()`
* `COUNT(DISTINCT)`
* `SUM()`
* `AVG()`
* `MIN()`
* `MAX()`

### Joins

* `INNER JOIN`
* `LEFT JOIN`
* `RIGHT JOIN`
* `UNION`
* Full Outer Join simulation

### Advanced SQL

* Subqueries
* Correlated subqueries
* CTEs (`WITH`)
* `CASE` expressions
* Window Functions
* `PARTITION BY`

### Window Functions

The project demonstrates:

```sql
AVG() OVER()
COUNT() OVER()
MAX() OVER()
DENSE_RANK() OVER()
LAG() OVER()
LEAD() OVER()
```

These were used for moving averages, rankings, running totals, previous/next readings, and animal-level analysis.

---

## 🛠️ Database Management

The project also demonstrates practical database administration concepts.

### DDL

```sql
CREATE DATABASE
CREATE TABLE
ALTER TABLE
CREATE VIEW
CREATE INDEX
```

### DML

```sql
INSERT
UPDATE
DELETE
SELECT
```

### Constraints

* Primary Keys
* Foreign Keys
* `NOT NULL`
* `UNIQUE`
* `CHECK`

For example, battery readings are restricted to valid values between **0 and 100**, while negative animal ages are prevented through database constraints.

---

## 📊 Key Business Analysis

The project translates **75 real-world conservation business cases** into SQL solutions.

Some major analyses include:

### 🐘 Animal Monitoring

* Animals with fewer than 5 GPS pings
* Animals that have stopped reporting for more than 10 days
* Animals with no GPS reports
* Latest coordinates for every tracked animal
* Animal activity analysis

### 🔋 Collar & Battery Monitoring

* Lowest battery reading
* Battery status classification
* Average battery level
* Reserves with average battery below 20%
* Ageing collars requiring maintenance
* Battery replacement planning

### 🌳 Reserve Analysis

* Reserves with zero collared animals
* Animals per reserve
* Reserve monitoring density
* Three largest reserves
* Reserves tracking more than 15 animals
* Reserve-level animal and battery-health reporting

### 🐅 Species Analysis

* Species population counts
* Species with fewer than 10 tracked individuals
* Critically Endangered species analysis
* Species distribution across reserves
* Most-tracked species

### 📍 GPS & Movement Analysis

* Highest recorded speed
* Average animal speed
* Unusual movement detection
* Nocturnal movement analysis
* Recent GPS activity
* Animal movement duration

These analyses transform raw GPS and animal data into operational insights for rangers, biologists, and conservation teams.

---

## 👁️ SQL Views

Three reusable views were created:

```sql
Reserve_Animal_Battery_level
animal_latest_snapshot
Critically_endengered_animals
```

These views provide reusable datasets for dashboards, mobile applications, and recurring conservation reporting.

For example, the reserve-level view combines:

* Reserve
* Animal count
* Average battery health

This avoids repeatedly rebuilding the same joins and aggregation logic.

---

## ⚡ Query Optimization

Because `GPSLogs` is the largest and fastest-growing table, indexes were implemented to improve query performance.

### Indexes

```sql
CREATE INDEX Idx_gpslogs_animal_id
ON GPSLogs(animal_id);

CREATE INDEX Idx_Animals_reserve_animal
ON Animals(reserve_id, animal_id);

CREATE INDEX idx_gpslogs_animal_date
ON GPSLogs(animal_id, log_datetime);
```

The composite indexes are designed around actual query patterns, particularly searches involving animals/reserves and date ranges.

---

## 🔐 Database Security

The project demonstrates role-based access control using:

```sql
CREATE USER
GRANT
REVOKE
DROP USER
```

Different permissions were designed for:

* **Field Researchers** → Read-only access to animal and GPS information
* **Lead Veterinarian** → Read and update access to animal records
* **Researchers** → Controlled access based on their responsibilities

This demonstrates the principle of **least-privilege access** for sensitive wildlife-location data.

---

## 🧹 Data Quality & Governance

SQL was used to identify and prevent common data-quality problems:

| Data Issue                   | SQL Solution            |
| ---------------------------- | ----------------------- |
| Invalid battery percentage   | `CHECK` constraint      |
| Negative animal age          | `CHECK` constraint      |
| Duplicate tag registration   | `UNIQUE` constraint     |
| Missing species              | `NOT NULL`              |
| Invalid animal IDs           | Foreign Key             |
| Orphan GPS records           | `LEFT JOIN` + `IS NULL` |
| Extra spaces                 | `TRIM()`                |
| Inconsistent capitalization  | `UPPER()`               |
| Incorrect reserve assignment | `UPDATE`                |

These techniques help maintain reliable and consistent conservation data.

---

## 💡 Key Insights

The analysis highlights several important operational signals:

* Animals with insufficient GPS data may indicate collar problems.
* Reserves with no collared animals represent monitoring gaps.
* Species with fewer than 10 tracked individuals can require conservation attention.
* Reserves with low average collar battery may require maintenance.
* Unusual movement speeds can highlight potentially important events.
* Orphaned GPS records can reveal data-integrity problems.
* Composite indexes improve performance for combined filtering patterns.
* Role-based permissions help protect sensitive animal-location data.

---

## 📈 Business Impact

The database supports several real-world conservation activities:

**Field Patrol Planning**
Identify movement patterns and highly active reserves to support patrol planning.

**Equipment Maintenance**
Detect low-battery and ageing collars before monitoring is lost.

**Animal Monitoring**
Identify animals that have stopped reporting or have insufficient GPS data.

**Species Conservation**
Identify species with low monitored populations and understand their reserve distribution.

**Data Governance**
Prevent invalid, duplicate, or inconsistent records.

**Performance**
Use indexes to maintain efficient access as GPS data grows.

**Security**
Provide different database permissions according to user responsibilities.

---

## 🧰 Tools & Technologies

* **MySQL**
* **MySQL Workbench**
* SQL
* Relational Database Design
* Data Analysis
* Database Optimization
* Database Security

---

## 📂 Project Structure

Recommended GitHub repository structure:

```text
WildTrack-Conservation-SQL/
│
├── SQL/
│   └── WildTrack_Conservation_Project.sql
│
├── Report/
│   └── WildTrack_Conservation_Project_Report.pdf
│
└── README.md
```

---

## 🚀 How to Run the Project

### 1. Install MySQL

Install **MySQL Server** and **MySQL Workbench**.

### 2. Open the SQL file

Open:

```text
WildTrack_Conservation_Project.sql
```

in MySQL Workbench.

### 3. Execute the script

Run the SQL script to:

* Create the database
* Create tables
* Insert data
* Apply constraints
* Execute analytical queries
* Create views
* Create indexes
* Configure database users and permissions

### 4. Explore the analysis

Run the individual SQL cases to explore wildlife monitoring, GPS activity, battery health, reserve analysis, data quality, performance, and security.

---

## 🎓 Learning Outcomes

This project strengthened practical skills in:

* Relational database design
* SQL querying
* Data cleaning and validation
* Complex joins
* CTEs
* Subqueries
* Correlated subqueries
* Window functions
* Views
* Indexing
* Database constraints
* User permissions
* Business-oriented data analysis

The project particularly focused on translating plain-language operational problems into practical SQL solutions.

---

## 👤 Author

**Prativa Baliarsingh**

Aspiring Data Analyst | SQL | Excel | Power BI | Tableau

---

## ⭐ Project Highlights

```text
15        Reserves
25        Species
200       Animals
9,760     GPS Logs
10,000    Total Records
75        Business Cases
```

### 🔎 Project Focus

**Wildlife Conservation + SQL + Data Analysis + Database Management**

---

## 📌 Conclusion

The WildTrack Conservation Alliance project demonstrates how SQL can move beyond basic querying and become a practical tool for operational decision-making.

From tracking animals and monitoring GPS activity to maintaining data quality, optimizing database performance, and controlling user access, the project showcases a complete relational database workflow for a realistic wildlife conservation scenario.
