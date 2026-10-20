# data_warehouse_1

# 🏗️ Enterprise Data Warehouse & Medallion Pipeline (SQL)

An end-to-end Data Warehouse project implementing the **Medallion Architecture (Bronze $\rightarrow$ Silver $\rightarrow$ Gold)** using SQL. This project ingests raw operational data, cleans and structures it through intermediate transformations, and finally models it into business-ready dimensional schemas for analytics and reporting.

# Objective
Develop a modern data warehouse using SQL Server to consolidate sales data, enabling analytical reporting and informed decision-making.

Specifications
Data Sources: Import data from two source systems (ERP and CRM) provided as CSV files.
Data Quality: Cleanse and resolve data quality issues prior to analysis.
Integration: Combine both sources into a single, user-friendly data model designed for analytical queries.
Scope: Focus on the latest dataset only; historization of data is not required.
Documentation: Provide clear documentation of the data model to support both business stakeholders and analytics teams.

---

## 🏛️ Architecture Overview

The data pipeline follows a multi-layered Medallion architecture to ensure data quality, traceability, and performance:

1. **Bronze Layer (Raw):** Ingestion layer that stores raw data as-is from source systems with minimal modifications, capturing historical state.
2. **Silver Layer (Cleaned & Conformed):** Cleansing layer where data types are fixed, duplicates are removed, nulls are handled, and business rules are applied.
3. **Gold Layer (Aggregated & Dimensional):** Consumption-ready layer structured into analytical models (Star Schema / Fact and Dimension tables) optimized for BI and reporting.

```mermaid
graph LR
    A[Raw Sources: CRM & Ops] -->|Ingest| B(Bronze Layer: Raw)
    B -->|Clean & Deduplicate| C(Silver Layer: Conformed)
    C -->|Dimensional Modeling| D(Gold Layer: Star Schema)

## 📂 Project Directory Structure

```text
data_warehouse_1/
│
├── data/
|   ├── erp
|   ├── crm           # Raw data source files (CSV)
├── scripts/              
│   ├── database/        
│   ├── createtable_bronze/       
│   └── bronze_procedure/
|   └── silver_procedure /
|   └── gold_views
|
├── tests
|   ├── transform_crm_cust_info/
|   ├── transform_crm_prd_details/
|   ├── transform_crm_sales_details/
|   ├── transform_erp_cust_az12
|   ├── transform_erp_px_cat_g1v2
|   ├──transforme_erp_loc_a101
|   ├── quality_check_gold
|
├── docs
|   ├── data_flow.jpg
|   ├── data_mart.jpg
|   ├── integration_diagram.jpg
|
└── README.md
