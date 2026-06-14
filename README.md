# 🌍 Global Superstore Sales Analysis using PostgreSQL

![Project Banner](Images/project_banner.png)

---

## 🏷️ Badges

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-336791?style=for-the-badge&logo=postgresql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-000000?style=for-the-badge&logo=database&logoColor=white)
![Data Analysis](https://img.shields.io/badge/Data%20Analysis-2E8B57?style=for-the-badge&logo=googleanalytics&logoColor=white)

---

## 📌 Project Overview

This project analyzes the **Global Superstore Dataset** using PostgreSQL to extract meaningful business insights across sales, customers, products, geography, and shipping performance.

It demonstrates a complete end-to-end SQL analytics workflow:

- Data Import & Cleaning  
- Data Type Conversion  
- Database Normalization  
- Star Schema Design  
- Fact & Dimension Modeling  
- KPI Development  
- Product, Customer, Geographic & Shipping Analysis  

---

## 📊 Dataset Information

| Attribute | Value |
|------------|--------|
| Dataset | Global Superstore |
| Database | PostgreSQL 17 |
| Total Records | 51,290 |
| Orders | 25,035 |
| Customers | 1,590+ |
| Products | 3,700+ |
| Countries | 140+ |
| Markets | 7 |

---

## 🏗️ Database Architecture

Global Superstore CSV  
→ superstore_raw  
→ Data Cleaning & Validation  
→ superstore  
→ Normalization  
→ Customers / Products / Orders  
→ Locations  
→ Sales Fact  

---

## 📁 Project Structure

- Dataset/Global_Superstore.csv  
- SQL_Queries/01_database_setup.sql  
- SQL_Queries/02_data_loading.sql  
- SQL_Queries/03_kpi_analysis.sql  
- SQL_Queries/04_product_analysis.sql  
- SQL_Queries/05_customer_analysis.sql  
- SQL_Queries/06_geographic_analysis.sql  
- SQL_Queries/07_shipping_analysis.sql  
- SQL_Queries/08_date_analysis.sql  
- ER_Diagram/er_diagram.png  
- Images/project_banner.png  
- README.md  

---

## 📈 Key Insights

- Top products generate majority revenue  
- Small % of customers drive most profit  
- Some high-sales products are loss-making  
- Standard Class is most used shipping mode  
- Regional profit imbalance exists  

---

## 🛠️ SQL Concepts Used

- Joins (INNER JOIN)  
- Aggregations (SUM, AVG, COUNT)  
- Filtering (WHERE, HAVING)  
- Sorting (ORDER BY, LIMIT)  
- Date Functions (DATE_TRUNC, EXTRACT)  
- Schema Design (Star Schema)  

---

## 🎯 Conclusion

This project demonstrates a complete SQL analytics pipeline from raw data to business insights using PostgreSQL.

