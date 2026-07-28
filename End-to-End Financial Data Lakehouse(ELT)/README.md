
# Azure Financial Data Lakehouse (ELT)

This project demonstrates an **end-to-end cloud data platform on Microsoft Azure** using a Medallion Architecture (Bronze, Silver, Gold). It automates financial data ingestion, applies scalable PySpark transformations in Azure Databricks, and serves analytics-ready data for Power BI reporting.

---

## Repository Structure

📁 End-to-End Financial Data Lakehouse(ELT)/  
├── 📁 schemas/  
├── 📁 pbix/  
├── 📁 images/  
└── 📄 README.md

---

## Project Overview

The goal is to simulate a production-grade ELT platform for financial and transactional analytics:

- Ingest raw market and transaction feeds into cloud storage
- Clean and validate data using distributed Spark transformations
- Model curated data into a Star Schema for analytics
- Deliver business-ready KPIs through Power BI dashboards

**Business use case:** enable finance and leadership teams to monitor market behavior, track key performance indicators, and support faster data-driven decisions.

---

## Data Flow & Architecture

### 1. Ingestion (Bronze Layer)
- **Action:** Raw CSV/JSON data lands in **Azure Data Lake Storage Gen2 (ADLS Gen2)**.
- **Orchestration:** **Azure Data Factory (ADF)** pipelines schedule and automate ingestion.
- **Purpose:** Preserve source-level data in its original format for traceability and replay.

### 2. Cleansing & Validation (Silver Layer)
- **Action:** **Azure Databricks + PySpark** enforce schema rules, handle missing values, and remove duplicates.
- **Output:** Cleaned, standardized datasets stored as optimized **Parquet/Delta** tables.
- **Purpose:** Produce trusted, query-efficient datasets for downstream modeling.

### 3. Data Modeling (Gold Layer)
- **Action:** Silver-layer data is transformed into business-level **fact and dimension** tables.
- **Model:** **Dimensional Star Schema** designed for analytical workloads.
- **Purpose:** Improve performance for aggregations, slicing, and time-based trend analysis.

### 4. Visualization & Consumption
- **Action:** Gold-layer data is served through **Azure SQL Database**.
- **Consumption:** **Power BI** connects to modeled tables for interactive dashboards.
- **Purpose:** Deliver executive reporting, KPI tracking, and self-service analytics.

---

## Key Technical Highlights

- **Medallion Pattern:** Clear separation of raw, clean, and business-ready data layers.
- **Pipeline Orchestration:** Automated ELT workflows managed with Azure Data Factory.
- **Distributed Processing:** Scalable PySpark transformations in Azure Databricks.
- **Dimensional Modeling:** Star schema optimized for Power BI and DAX performance.

---

## Tech Stack

- **Cloud Storage:** Azure Data Lake Storage (ADLS Gen2), Azure Blob Storage
- **Orchestration:** Azure Data Factory
- **Processing Engine:** Azure Databricks, PySpark, Python
- **Data Serving:** Azure SQL Database
- **Analytics & BI:** Power BI
