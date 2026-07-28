# Data Engineering & Analytics Portfolio

Welcome to my portfolio! My name is Joonas, and I hold a Bachelor's degree in ICT Engineering from Turku University of Applied Sciences. This repository showcases my work across **Data Engineering** (cloud pipelines, database design, ETL/ELT orchestration) and **Data Analytics / BI** (interactive dashboard design, UI/UX navigation, advanced DAX metrics).

---

## Table of Contents
- [End-to-End Predictive Maintenance (ETL)](#end-to-end-predictive-maintenance-etl)
- [End-to-End Financial Data Lakehouse (ELT)](#end-to-end-financial-data-lakehouse-elt)
- [E-Commerce & Customer Analytics](#e-commerce--customer-analytics)

---

### [End-to-End Predictive Maintenance (ETL)](./End-to-End%20Predictive%20Maintenance)

Engineered a cloud ETL pipeline in Microsoft Azure to process and warehouse 10,000 equipment sensor telemetry records. Raw manufacturing logs covering process temperatures, rotational speed, torque, tool wear, and failure categories are preprocessed using Python, staged in Azure Blob Storage, transformed via Azure Data Factory Mapping Data Flows, and loaded into Azure SQL Database for operational analytics.

**Tech Stack:**<br>
![Azure Data Factory](https://img.shields.io/badge/Azure_Data_Factory-0078D4?style=flat-square&logo=microsoftazure&logoColor=white)
![Azure Blob Storage](https://img.shields.io/badge/Azure_Blob_Storage-0078D4?style=flat-square&logo=microsoftazure&logoColor=white)
![Azure SQL](https://img.shields.io/badge/Azure_SQL-0078D4?style=flat-square&logo=microsoftsqlserver&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=flat-square&logo=python&logoColor=white)
![T-SQL](https://img.shields.io/badge/T--SQL-CC292B?style=flat-square&logo=microsoftsqlserver&logoColor=white)
![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=flat-square&logo=powerbi&logoColor=black)

* **Dataset:** [predictive_maintenance.csv](./End-to-End%20Predictive%20Maintenance/raw-data/predictive_maintenance.csv)

#### Dashboard Showcase
<img src="./End-to-End%20Predictive%20Maintenance(ETL)/images/Dashboard.png" alt="Predictive Maintenance Dashboard" width="600">

---

### [End-to-End Financial Data Lakehouse (ELT)](./End-to-End%20Financial%20Data%20Lakehouse)

Built an automated data lakehouse architecture processing daily stock market transactions from Finnhub API using Azure Databricks and PySpark. Implemented Medallion Architecture (Bronze, Silver, Gold layers) with Delta Lake for ACID transactions and structured the analytical data model into a Star Schema connected directly to Power BI for real-time executive market intelligence reporting.

**Tech Stack:**<br>
![Azure Databricks](https://img.shields.io/badge/Azure_Databricks-FF3621?style=flat-square&logo=databricks&logoColor=white)
![PySpark](https://img.shields.io/badge/PySpark-E25A1C?style=flat-square&logo=apachespark&logoColor=white)
![Delta Lake](https://img.shields.io/badge/Delta_Lake-000000?style=flat-square&logo=delta&logoColor=white)
![Azure Key Vault](https://img.shields.io/badge/Azure_Key_Vault-0078D4?style=flat-square&logo=microsoftazure&logoColor=white)
![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=flat-square&logo=powerbi&logoColor=black)



#### Dashboard Showcase
<img src="./End-to-End%20Financial%20Data%20Lakehouse/docs/dashboard_preview.png" alt="Financial Analytics Dashboard" width="600">

---

### [E-Commerce & Customer Analytics](./E-Commerce%20%26%20Customer%20Analytics)

Built an interactive Business Intelligence solution using Excel, Power BI, Power Query, M Language, and DAX to analyze over 540,000 multi-region transactions across 38 countries. Cleansed and transformed raw transactional records using Power Query with custom M scripts, built a star-schema data model, and engineered advanced DAX measures to analyze customer purchasing behavior, regional sales performance, retention cohorts, and Customer Lifetime Value (CLV).

**Tech Stack:**<br>
![Microsoft Excel](https://img.shields.io/badge/Microsoft_Excel-217346?style=flat-square&logo=microsoft-excel&logoColor=white)
![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=flat-square&logo=powerbi&logoColor=black)
![Power Query](https://img.shields.io/badge/Power_Query-0078D4?style=flat-square&logo=microsoft&logoColor=white)
![M Language](https://img.shields.io/badge/M_Language-0078D4?style=flat-square&logo=microsoft&logoColor=white)
![DAX](https://img.shields.io/badge/DAX-F2C811?style=flat-square&logo=powerbi&logoColor=black)

* **Dataset:** [Online_Retail.xlsx](./E-Commerce%20%26%20Customer%20Analytics/data/Online_Retail.xlsx)

#### Dashboard Showcase
<p float="left">
  <img src="./E-Commerce%20%26%20Customer%20Analytics/images/PowerBIoverview2011.png" alt="Power BI Overview" width="48%" />
  <img src="./E-Commerce%20%26%20Customer%20Analytics/images/CustomerInsight2011.png" alt="Customer Insight Dashboard" width="48%" />
</p>
