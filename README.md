# Credit-Risk-Analysis
End-to-End Credit Risk Pipeline &amp; Analytics

This project presents an end-to-end data pipeline and risk analysis workflow built on a Kaggle Credit Risk Dataset. It focuses on cleaning raw loan applicant data, loading it into a local MySQL database, executing SQL analytics for risk profiling, and visualizing key insights through Tableau dashboards.

---

## 📌 Project Overview & Workflow

1. **Data Cleaning & Preprocessing**
   - Sourced raw loan application data (`credit_risk_dataset.csv`) from **Kaggle**.
   - Processed and cleaned the data in `credit_risk_cleaning.ipynb` by handling missing values, standardizing formats, and preparing clean records (`credit_risk_cleaned.csv`).

2. **Exploratory Data Analysis (EDA)**
   - Conducted detailed exploratory data analysis in `credit_risk_eda.ipynb` to understand borrower distributions, income levels, loan amounts, and historical default rates.

3. **MySQL Database Integration**
   - Configured `fast_database_loader.py` to establish a direct connection to a local MySQL instance (`central_credit_db`).
   - Automatically loaded the cleaned dataset into MySQL tables for structured storage and SQL querying.

4. **SQL Risk Analysis**
   - Executed targeted SQL queries in `credit_risk_eda.sql` inside MySQL Workbench to extract metrics like default rates by age group, loan intent, grade risk, and debt-to-income ratios.

5. **Tableau Visual Dashboards**
   - Built interactive **Tableau Dashboards** to track key credit risk metrics (KPIs), applicant risk categorization, and default probability trends.
   - Preview captures are stored in the project's `images/` directory.

---

## 🛠️ How to Run

1. **Run Notebooks:** Open `notebook/` in Jupyter and run `credit_risk_cleaning.ipynb` followed by `credit_risk_eda.ipynb`.
2. **Load Database:** Update your MySQL credentials in `fast_database_loader.py` and run:
   ```bash
   python fast_database_loader.py
