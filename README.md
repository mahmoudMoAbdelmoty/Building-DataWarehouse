# Building a Data Warehouse using SQL

This project demonstrates how to build a Data Warehouse from scratch using SQL, following the **Medallion Architecture** approach.

## 🧱 Architecture

- **Bronze Layer**: Raw data ingestion. Data is ingested from CSV Files into SQL Server Database.
- **Silver Layer**: ETL and data cleaning applied.
- **Gold Layer**: Business-level data aggregation and analysis.

> The ETL process is implemented in the **Silver Layer**, where we clean and transform the raw data before loading it into the analytical model.

## 🔗 Table Relationships

This diagram illustrates the relationships between the CRM and ERP tables in the data Sources:

![Table Relationships](docs/Data%20intergration.png)


## 📊 Data Flow

Below is a high-level overview of the data flow through the Medallion Architecture:

![Data Flow](docs/data%20flow.png)


## 🛠️ Tools Used

- SQL Server
- SSMS (SQL Server Management Studio)
- dbdiagram.io (for schema design)

---

## 📁 Folder Structure
<pre>
''' README.md
├───datasets
│   ├───source_crm
│   │       cust_info.csv
│   │       prd_info.csv
│   │       sales_details.csv
│   │
│   └───source_erp
│           CUST_AZ12.csv
│           LOC_A101.csv
│           PX_CAT_G1V2.csv
│
├───docs
│       data flow.png
│       Data intergration.png
│       data_catalog.md
│       naming_conventions.md
│
│
└───scripts
    │   init_database.sql
    │
    ├───bronze
    │       DDL for Data Sources.sql
    │       proc_load_bronze.sql
    │
    ├───gold
    │       ddl_gold_views.sql
    │
    └───silver
            DDL for Silver Layer.sql
            process to cleaning the data.sql
            proc_load_silver.sql
            test.sql
'''</pre>
