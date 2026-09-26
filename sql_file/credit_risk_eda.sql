CREATE DATABASE IF NOT EXISTS central_credit_db;
USE central_credit_db;

DROP TABLE IF EXISTS credit_risk;
CREATE TABLE credit_risk (
    person_age INT,
    person_income INT,
    person_home_ownership VARCHAR(50),
    person_emp_length DECIMAL(5,2),
    loan_intent VARCHAR(50),
    loan_grade VARCHAR(5),
    loan_amnt INT,
    loan_int_rate DECIMAL(5,2),
    loan_status INT,
    loan_percent_income DECIMAL(5,2),
    cb_person_default_on_file VARCHAR(5),
    cb_person_cred_hist_length INT
);

-- Basic Aggregation:

-- 1. What is the total number of loans by loan intent?
SELECT loan_intent,
COUNT(*) AS total_loan
FROM credit_risk
GROUP BY loan_intent
ORDER BY 2 DESC;

-- 2. What is the overall default rate as a percentage?
SELECT ROUND(AVG(loan_status)*100,2) AS default_percentage
FROM credit_risk;

-- 3. What is the average interest rate by loan grade?
SELECT loan_grade, 
ROUND(AVG(loan_int_rate),2) AS avg_interest
FROM credit_risk
GROUP BY loan_grade
ORDER BY loan_grade;

-- 4. Which home ownership type has the highest average loan amount?
SELECT person_home_ownership,
ROUND(AVG(loan_amnt),2) AS avg_loan
FROM credit_risk 
GROUP BY person_home_ownership
ORDER BY 2 DESC
LIMIT 1;

-- 5. What is the average income by loan status?
SELECT loan_status, 
ROUND(AVG(person_income),2) AS average_income
FROM credit_risk 
GROUP BY loan_status;


-- GROUP BY + HAVING:

-- 6. Which loan grade has a default rate greater than 50%?
SELECT loan_grade,
ROUND(AVG(loan_status)*100,2) AS loan_rate
FROM credit_risk
GROUP BY loan_grade
HAVING loan_rate > 50;

-- 7. Which loan intent has more than 1000 defaulted loans?
SELECT loan_intent,
COUNT(*) AS defaulted_loans
FROM credit_risk 
WHERE loan_status = 1
GROUP BY loan_intent
HAVING defaulted_loans > 1000;


-- Subquery:

-- 8. What is the default rate of applicants whose income is above the overall average income?
SELECT ROUND(AVG(loan_status)*100,2) AS default_rate
FROM credit_risk
WHERE person_income > (SELECT AVG(person_income)
				FROM credit_risk);

-- 9. Which loan grade has a higher default rate than the overall average default rate?
WITH overall_stats AS (SELECT AVG(loan_status)*100 AS global_avg FROM credit_risk)
SELECT loan_grade, AVG(loan_status)*100 AS avg_default
FROM credit_risk, overall_stats
GROUP BY loan_grade, global_avg
HAVING avg_default > global_avg;

-- 10. What is the average loan amount for applicants who have previously defaulted?
SELECT AVG(loan_amnt) AS loan_avg
FROM credit_risk
WHERE cb_person_default_on_file = 'Y';


-- Window Function:

-- 11. Rank loan grades by default rate from highest to lowest.
SELECT loan_grade,
AVG(loan_status)*100 AS default_rate, 
RANK() OVER(ORDER BY AVG(loan_status) DESC) AS risk_rank
FROM credit_risk
GROUP BY loan_grade;

-- 12. For each home ownership type, show each applicant's loan amount and the average loan amount of their group side by side.
SELECT person_home_ownership,
loan_amnt,
ROUND(AVG(loan_amnt) OVER(PARTITION BY person_home_ownership),2) AS group_avg_amount
FROM credit_risk;

-- 13. Compare each loan intent's default rate against the overall default rate.
SELECT loan_intent,
ROUND(AVG(loan_status)*100,2) AS intent_default_rate,
ROUND(AVG(AVG(loan_status)*100) OVER(),2) AS overall_default_rate
FROM credit_risk
GROUP BY loan_intent;

-- 14. Calculate the cumulative default rate by loan grade ordered from A to G.
SELECT loan_grade, default_rate,
SUM(default_rate) OVER(ORDER BY loan_grade) AS cumulative
FROM (
    SELECT loan_grade, AVG(loan_status)*100 AS default_rate
    FROM credit_risk
    GROUP BY loan_grade
) AS sub;


-- Combined:

-- 15. For each loan grade, show default rate and its difference from the overall average default rate.
SELECT loan_grade, default_rate,
overall_default - default_rate AS default_difference
FROM (
    SELECT loan_grade,
    AVG(loan_status)*100 AS default_rate,
    (SELECT AVG(loan_status)*100 FROM credit_risk) AS overall_default
    FROM credit_risk
    GROUP BY loan_grade
) AS sub;
