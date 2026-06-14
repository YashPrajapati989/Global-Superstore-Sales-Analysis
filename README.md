# 🌍 Global Superstore Sales Analysis using PostgreSQL

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-336791?style=for-the-badge&logo=postgresql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-000000?style=for-the-badge&logo=database&logoColor=white)
![Data Analysis](https://img.shields.io/badge/Data%20Analysis-2E8B57?style=for-the-badge&logo=googleanalytics&logoColor=white)
![Star Schema](https://img.shields.io/badge/Star%20Schema-FF6B35?style=for-the-badge&logo=databricks&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)

> A complete end-to-end SQL analytics project — from raw CSV ingestion to actionable business intelligence — using PostgreSQL 17 on the Global Superstore dataset.

---

## 📌 Table of Contents

- [Project Overview](#-project-overview)
- [Dataset Information](#-dataset-information)
- [Database Architecture](#️-database-architecture)
- [Star Schema Design](#-star-schema-design)
- [Project Structure](#-project-structure)
- [Analysis Modules](#-analysis-modules)
- [Key Business Insights](#-key-business-insights)
- [SQL Concepts Used](#️-sql-concepts-used)
- [Getting Started](#-getting-started)
- [Sample Queries](#-sample-queries)
- [Conclusion](#-conclusion)
- [Author](#-author)

---

## 📋 Project Overview

This project performs a comprehensive analysis of the **Global Superstore Dataset** using PostgreSQL to extract meaningful business insights across sales performance, customer behaviour, product profitability, geographic distribution, and shipping efficiency.

The workflow covers the full data analytics lifecycle:

- **Data Import & Cleaning** — raw CSV ingestion and quality validation
- **Data Type Conversion** — ensuring correct field types for date, numeric, and categorical data
- **Database Normalization** — restructuring flat data into relational tables
- **Star Schema Design** — fact and dimension modelling for OLAP-style queries
- **KPI Development** — tracking revenue, profit, orders, and margins
- **Multi-dimensional Analysis** — product, customer, geography, shipping, and time

---

## 📊 Dataset Information

| Attribute      | Value              |
|----------------|--------------------|
| Dataset        | Global Superstore  |
| Database       | PostgreSQL 17      |
| Total Records  | 51,290             |
| Total Orders   | 25,035             |
| Customers      | 1,590+             |
| Products       | 3,700+             |
| Countries      | 140+               |
| Markets        | 7                  |
| Time Period    | Multi-year         |

The dataset includes fields such as Order ID, Order Date, Ship Date, Ship Mode, Customer Name, Segment, Country, City, Region, Product Name, Category, Sub-Category, Sales, Quantity, Discount, and Profit.

---

## 🏗️ Database Architecture

The pipeline follows a staged transformation process:

```
Global_Superstore.csv
        │
        ▼
  superstore_raw          ← Raw ingestion table (all TEXT types)
        │
        ▼
  Data Cleaning           ← Nulls, duplicates, type casting, date parsing
  & Validation
        │
        ▼
   superstore             ← Cleaned staging table with correct types
        │
        ▼
  Normalization           ← Split into dimension tables
   ┌────┴──────────────────────────────────────┐
   │                                           │
dim_customers   dim_products   dim_locations   dim_dates
   │                                           │
   └────────────────┬──────────────────────────┘
                    ▼
              fact_sales                ← Central fact table
```

---

## 🧹 Data Quality Decisions

During schema cleanup, deliberate decisions were made to improve the integrity and clarity of the analytical model. These are documented here for transparency and reproducibility.

| Field | Table | Action | Reason |
|-------|-------|--------|--------|
| `market2` | `dim_locations` | Removed | Entirely NULL across all records (3,819/3,819) |

> **Why this matters:** The `market2` field in the `locations` dimension was found to be entirely NULL (3,819/3,819 records). Since it contained no usable information and did not contribute to any analytical model, it was removed during schema cleanup to improve data quality and clarity.

Removing empty or redundant columns is a standard practice in dimensional modelling — retaining NULL-only fields adds schema noise, risks confusion during joins, and can mislead downstream consumers of the data. Decisions like this reflect real-world data engineering judgement, not just mechanical SQL execution.

---

## ⭐ Star Schema Design

```
                    ┌─────────────────┐
                    │   dim_dates     │
                    │─────────────────│
                    │ date_id (PK)    │
                    │ order_date      │
                    │ year            │
                    │ quarter         │
                    │ month           │
                    └────────┬────────┘
                             │
┌─────────────────┐          │         ┌─────────────────┐
│  dim_customers  │          │         │  dim_products   │
│─────────────────│          │         │─────────────────│
│ customer_id(PK) │          │         │ product_id (PK) │
│ customer_name   ├──────────┤         │ product_name    │
│ segment         │          │         │ category        │
│ market          │     ┌────▼─────┐   │ sub_category    │
└─────────────────┘     │fact_sales│   └────────┬────────┘
                        │──────────│            │
┌─────────────────┐     │ sale_id  │            │
│  dim_locations  │     │ order_id │   ─────────┘
│─────────────────│     │ cust_fk  │
│ location_id(PK) ├─────│ prod_fk  │
│ country         │     │ loc_fk   │
│ city            │     │ date_fk  │
│ state           │     │ sales    │
│ region          │     │ profit   │
│ market          │     │ quantity │
└─────────────────┘     │ discount │
                        └──────────┘
```

---

## 📁 Project Structure

```
Global-Superstore-Sales-Analysis/
│
├── 📂 Dataset/
│   └── Global_Superstore.csv           # Source data file
│
├── 📂 SQL_Queries/
│   ├── 01_database_setup.sql           # Schema creation, raw table setup
│   ├── 02_data_loading.sql             # CSV ingestion, cleaning, type casting
│   ├── 03_kpi_analysis.sql             # Revenue, profit, order count KPIs
│   ├── 04_product_analysis.sql         # Top/bottom products, category performance
│   ├── 05_customer_analysis.sql        # Segmentation, CLV, top customers
│   ├── 06_geographic_analysis.sql      # Country/region/market-level insights
│   ├── 07_shipping_analysis.sql        # Ship mode performance, delivery times
│   └── 08_date_analysis.sql            # Monthly/quarterly/yearly trends
│
├── 📂 ER_Diagram/
│   └── er_diagram.png                  # Entity-relationship diagram
│
├── 📂 Images/
│   └── project_banner.png              # Project banner
│
└── README.md
```

---

## 🔍 Analysis Modules

### 1. KPI Analysis (`03_kpi_analysis.sql`)
Core business metrics computed across the entire dataset.

| KPI | Description |
|-----|-------------|
| Total Revenue | Sum of all sales values |
| Total Profit | Net profit across all orders |
| Profit Margin % | (Profit / Sales) × 100 |
| Total Orders | Count of distinct Order IDs |
| Avg Order Value | Revenue per order |
| Return Rate | Estimated from negative profits |

### 2. Product Analysis (`04_product_analysis.sql`)
- Top 10 revenue-generating products
- Top 10 most profitable products
- Products with high sales but negative profit (discount traps)
- Category and sub-category performance breakdown

### 3. Customer Analysis (`05_customer_analysis.sql`)
- Top customers by revenue and profit contribution
- Customer segmentation (Consumer / Corporate / Home Office)
- Customer Lifetime Value (CLV) estimation
- Pareto analysis — identifying the 20% of customers driving 80% of revenue

### 4. Geographic Analysis (`06_geographic_analysis.sql`)
- Revenue and profit by country, city, and region
- Market-level performance comparison (7 markets)
- Identifying underperforming geographies with positive sales but negative profit

### 5. Shipping Analysis (`07_shipping_analysis.sql`)
- Performance breakdown by ship mode (Same Day / First Class / Second Class / Standard Class)
- Average delivery time calculation
- Shipping mode popularity vs profitability trade-off

### 6. Date & Trend Analysis (`08_date_analysis.sql`)
- Monthly and quarterly revenue trends
- Year-over-year growth comparison
- Seasonal sales peaks and troughs

---

## 💡 Key Business Insights

| # | Insight |
|---|---------|
| 1 | 📦 A small percentage of products (~top 10%) drive the majority of total revenue |
| 2 | 👥 A small segment of customers (~20%) accounts for the vast majority of profit |
| 3 | ⚠️ Several high-revenue products are loss-making due to excessive discounting |
| 4 | 🚚 Standard Class is the most frequently used shipping mode across all regions |
| 5 | 🌍 Significant regional profit imbalances exist despite similar sales volumes |
| 6 | 📈 Sales exhibit clear seasonal trends with peaks in Q4 across most markets |
| 7 | 🏷️ Certain sub-categories (e.g., Tables) consistently operate at a loss |
| 8 | 🌏 The APAC and EU markets show strong growth potential relative to profitability |

---

## 🛠️ SQL Concepts Used

**Data Preparation**
- `COPY` for bulk CSV import
- `CAST` and `TO_DATE` for type conversion
- `COALESCE`, `NULLIF` for null handling
- `DISTINCT ON` for deduplication

**Querying & Aggregation**
- `INNER JOIN`, `LEFT JOIN` across fact and dimension tables
- `GROUP BY`, `HAVING` for segment filtering
- `SUM`, `AVG`, `COUNT`, `ROUND` for KPIs
- `ORDER BY`, `LIMIT` for rankings

**Advanced SQL**
- `RANK()`, `DENSE_RANK()`, `ROW_NUMBER()` window functions
- `LAG()` / `LEAD()` for period-over-period comparison
- `DATE_TRUNC()`, `EXTRACT()` for time-series analysis
- CTEs (`WITH` clause) for modular query design
- Subqueries and derived tables
- Star schema joins across 5+ tables

---

## 🚀 Getting Started

### Prerequisites

- PostgreSQL 17 or later
- pgAdmin 4 or any SQL client (DBeaver, TablePlus, etc.)
- The `Global_Superstore.csv` dataset

### Setup Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/YashPrajapati989/Global-Superstore-Sales-Analysis.git
   cd Global-Superstore-Sales-Analysis
   ```

2. **Create the database**
   ```sql
   CREATE DATABASE global_superstore;
   ```

3. **Run scripts in order**
   ```sql
   \i SQL_Queries/01_database_setup.sql
   \i SQL_Queries/02_data_loading.sql
   \i SQL_Queries/03_kpi_analysis.sql
   -- ... continue with remaining scripts
   ```

4. **Verify the data load**
   ```sql
   SELECT COUNT(*) FROM superstore;
   -- Expected: 51,290 rows
   ```

---

## 🧪 Sample Queries

### Top 5 Most Profitable Products
```sql
SELECT
    product_name,
    category,
    ROUND(SUM(profit)::numeric, 2) AS total_profit,
    ROUND(SUM(sales)::numeric, 2)  AS total_sales
FROM fact_sales fs
JOIN dim_products dp ON fs.product_id = dp.product_id
GROUP BY product_name, category
ORDER BY total_profit DESC
LIMIT 5;
```

### Profit by Market
```sql
SELECT
    market,
    ROUND(SUM(sales)::numeric, 2)  AS total_sales,
    ROUND(SUM(profit)::numeric, 2) AS total_profit,
    ROUND((SUM(profit) / NULLIF(SUM(sales), 0) * 100)::numeric, 2) AS margin_pct
FROM fact_sales fs
JOIN dim_locations dl ON fs.location_id = dl.location_id
GROUP BY market
ORDER BY total_profit DESC;
```

### Monthly Sales Trend
```sql
SELECT
    DATE_TRUNC('month', order_date) AS month,
    ROUND(SUM(sales)::numeric, 2)   AS monthly_sales,
    ROUND(SUM(profit)::numeric, 2)  AS monthly_profit
FROM fact_sales fs
JOIN dim_dates dd ON fs.date_id = dd.date_id
GROUP BY month
ORDER BY month;
```

---

## 🎯 Conclusion

This project demonstrates a complete SQL analytics pipeline — from raw data ingestion and normalization through to business intelligence reporting. By designing a proper star schema and leveraging advanced SQL features, the analysis surfaces actionable insights around product profitability, customer segmentation, geographic performance, and operational efficiency that would directly support data-driven decision making at a retail or supply chain organization.

---

## 👤 Author

**Yash Prajapati**

[![GitHub](https://img.shields.io/badge/GitHub-YashPrajapati989-181717?style=for-the-badge&logo=github)](https://github.com/YashPrajapati989)

---

> ⭐ If you found this project useful, please consider giving it a star on GitHub!
