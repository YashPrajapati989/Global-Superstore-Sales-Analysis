<p align="center">
  <img src="Images/project_banner.png" width="100%">
</p>

# 🌍 Global Superstore Sales Analysis using PostgreSQL

---

## 📌 Project Overview

This project analyzes the **Global Superstore Dataset** using **PostgreSQL** to uncover valuable business insights related to:

- Sales performance  
- Customer behavior  
- Product profitability  
- Geographic trends  
- Shipping operations  

It demonstrates a complete SQL analytics workflow:

- Data Import & Cleaning  
- Data Type Conversion  
- Database Normalization  
- Star Schema Design  
- Fact & Dimension Modeling  
- Business KPI Analysis  
- Product Analysis  
- Customer Analysis  
- Geographic Analysis  
- Shipping Analysis  

---

## 📊 Dataset Information

| Attribute       | Value              |
|----------------|-------------------|
| Dataset        | Global Superstore  |
| Database       | PostgreSQL 17      |
| Total Records  | 51,290             |
| Orders         | 25,035             |
| Customers      | 1,590+             |
| Products       | 3,700+             |
| Countries      | 140+               |
| Markets        | 7                  |

---

## 🏗️ Database Architecture


Global Superstore CSV
│
▼
superstore_raw
│
▼
Data Cleaning & Validation
│
▼
superstore
│
▼
Database Normalization
│
┌────────┼────────┐
▼ ▼ ▼
Customers Products Orders
│
▼
Locations
│
▼
Sales Fact


---

## 🗄️ Database Schema

### ⭐ Fact Table: Sales

| Column         |
|----------------|
| row_id         |
| order_id       |
| customer_id    |
| product_id     |
| location_id    |
| sales          |
| quantity       |
| discount       |
| profit         |
| shipping_cost  |

---

### 📦 Dimension Tables

#### Customers

| Column         |
|----------------|
| customer_id    |
| customer_name  |
| segment        |

#### Products

| Column         |
|----------------|
| product_id     |
| product_name   |
| category       |
| sub_category   |

#### Orders

| Column         |
|----------------|
| order_id       |
| order_date     |
| ship_date      |
| ship_mode      |
| order_priority |

#### Locations

| Column         |
|----------------|
| location_id    |
| city           |
| state          |
| country        |
| region         |
| market         |
| market2        |

---

## 📷 ER Diagram

<p align="center">
  <img src="ER_Diagram/er_diagram.png" width="90%">
</p>

---

## 📁 Project Structure


Global_Superstore_SQL_Project
│
├── Dataset
│ └── Global_Superstore.csv
│
├── SQL Queries
│ ├── 01_database_setup.sql
│ ├── 02_data_loading.sql
│ ├── 03_kpi_analysis.sql
│ ├── 04_product_analysis.sql
│ ├── 05_customer_analysis.sql
│ ├── 06_geographic_analysis.sql
│ └── 07_shipping_analysis.sql
│ └── 07_date_analysis.sql
├── ER_Diagram
│ └── er_diagram.png
│
├── Images
│ ├── project_banner.png
│ ├── schema.png
│
└── README.md


---

## 📈 Key Business Questions Answered

### KPI Analysis
- Total revenue generated  
- Total profit earned  
- Total customers  
- Average order value  
- Profit margin  

### Product Analysis
- Top revenue products  
- Most profitable products  
- Loss-making products  
- Category performance  
- Discount impact  

### Customer Analysis
- Most valuable customers  
- High-value segments  
- Customer lifetime value  
- Order frequency  

### Geographic Analysis
- Top countries by sales  
- Most profitable regions  
- High revenue cities  
- Underperforming markets  

### Shipping Analysis
- Most used shipping mode  
- Revenue by shipping type  
- Delivery performance  
- Shipping cost impact  

---

## 📊 Sample Insights

- Top products contribute majority of total revenue  
- Small % of customers generate large share of profits  
- Some high-sales products are actually loss-making  
- Standard Class is the most used shipping mode  
- Certain regions generate high revenue but low profit  

---

## 🛠️ SQL Concepts Used

### Data Cleaning
- CAST()  
- TO_DATE()  
- Validation techniques  

### Joins
- INNER JOIN  
- Multi-table joins  

### Aggregations
- SUM(), AVG(), COUNT(), ROUND()  

### Filtering
- WHERE, HAVING  

### Sorting
- ORDER BY, LIMIT  

### Database Design
- Primary Key / Foreign Key  
- Star Schema modeling  

---

## 🎯 Conclusion

This project demonstrates a complete SQL analytics pipeline—from raw dataset to structured business insights using PostgreSQL. It highlights how data modeling and SQL analysis can drive meaningful decisions across sales, customers, geography, and operations.

---
