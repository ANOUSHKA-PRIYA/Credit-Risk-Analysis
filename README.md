# 💳 End-to-End Credit Risk Engineering & Analytics Pipeline

A complete **Data Engineering & Business Intelligence Pipeline** built to analyze borrower creditworthiness, predict default probabilities, and identify financial risk factors using the Kaggle Credit Risk Dataset. 

This project bridges **Data Preprocessing (Python)**, **Database Architecture (MySQL)**, **Data Analysis (SQL Window Functions & Aggregations)**, and **Executive Reporting (Tableau)**.

---

## 📌 Business Problem & Scope

Financial institutions lose millions annually to loan defaults. Underwriters need actionable risk metrics and continuous monitoring to answer critical strategic questions:
- Which borrower segments (age, income level, homeownership status) present the highest probability of default?
- How do interest rates scale across risk tiers (`Grade A` through `Grade G`)?
- Does historical default history (`cb_person_default_on_file`) reliably predict future loan performance?
- What thresholds for **Loan-to-Income Ratio (DTI)** mark a sharp increase in credit risk?

---

## 🏗 System Architecture & Workflow

```text
┌─────────────────────────┐
│ Raw Data (Kaggle CSV)   │ ──> 32,581 initial loan application records
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│ Data Preprocessing      │ ──> Missing value imputation, age/employment outlier removal
│ (Jupyter / Pandas)      │ ──> Income capping (99th percentile) & feature validation
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│ Database Loading Engine │ ──> Fast MySQL ingestion via `mysql-connector-python`
│ (Python / MySQL)        │ ──> Table creation & automated batch loading
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│ SQL Risk Profiling      │ ──> CTEs, Subqueries, Window Functions (`RANK`, `OVER`, `PARTITION`)
│ (MySQL Workbench)       │ ──> Risk tier segmentation & comparative benchmarking
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│ Interactive BI          │ ──> Executive Dashboards, KPI Tracking & Risk Heatmaps
│ (Tableau Visualizations)│
└─────────────────────────┘
