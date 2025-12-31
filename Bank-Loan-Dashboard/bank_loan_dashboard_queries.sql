/* =========================================================
   BANK LOAN DASHBOARD – SQL QUERIES
   Purpose: KPI extraction for loan performance analysis
   Table: bank_loan_data
   ========================================================= */


/* ---------------------------------------------------------
   1. TOTAL LOAN APPLICATIONS
   --------------------------------------------------------- */
SELECT COUNT(id) AS total_loan_applications
FROM bank_loan_data;


/* ---------------------------------------------------------
   2. MONTH-TO-DATE (MTD) LOAN APPLICATIONS
   --------------------------------------------------------- */
SELECT COUNT(id) AS mtd_loan_applications
FROM bank_loan_data
WHERE MONTH(issue_date) = MONTH(CURRENT_DATE)
  AND YEAR(issue_date) = YEAR(CURRENT_DATE);


/* ---------------------------------------------------------
   3. PREVIOUS MONTH-TO-DATE (PMTD) LOAN APPLICATIONS
   --------------------------------------------------------- */
SELECT COUNT(id) AS pmtd_loan_applications
FROM bank_loan_data
WHERE MONTH(issue_date) = MONTH(CURRENT_DATE - INTERVAL 1 MONTH)
  AND YEAR(issue_date) = YEAR(CURRENT_DATE - INTERVAL 1 MONTH);


/* ---------------------------------------------------------
   4. TOTAL FUNDED AMOUNT
   --------------------------------------------------------- */
SELECT SUM(loan_amount) AS total_funded_amount
FROM bank_loan_data;


/* ---------------------------------------------------------
   5. MONTH-TO-DATE (MTD) FUNDED AMOUNT
   --------------------------------------------------------- */
SELECT SUM(loan_amount) AS mtd_funded_amount
FROM bank_loan_data
WHERE MONTH(issue_date) = MONTH(CURRENT_DATE)
  AND YEAR(issue_date) = YEAR(CURRENT_DATE);


/* ---------------------------------------------------------
   6. PREVIOUS MONTH-TO-DATE (PMTD) FUNDED AMOUNT
   --------------------------------------------------------- */
SELECT SUM(loan_amount) AS pmtd_funded_amount
FROM bank_loan_data
WHERE MONTH(issue_date) = MONTH(CURRENT_DATE - INTERVAL 1 MONTH)
  AND YEAR(issue_date) = YEAR(CURRENT_DATE - INTERVAL 1 MONTH);


/* ---------------------------------------------------------
   7. TOTAL AMOUNT RECEIVED
   --------------------------------------------------------- */
SELECT SUM(total_payment) AS total_amount_received
FROM bank_loan_data;


/* ---------------------------------------------------------
   8. AVERAGE INTEREST RATE
   --------------------------------------------------------- */
SELECT ROUND(AVG(int_rate) * 100, 2) AS avg_interest_rate
FROM bank_loan_data;


/* ---------------------------------------------------------
   9. MONTH-TO-DATE (MTD) AVERAGE INTEREST RATE
   --------------------------------------------------------- */
SELECT ROUND(AVG(int_rate) * 100, 2) AS mtd_avg_interest_rate
FROM bank_loan_data
WHERE MONTH(issue_date) = MONTH(CURRENT_DATE)
  AND YEAR(issue_date) = YEAR(CURRENT_DATE);


/* ---------------------------------------------------------
   10. PREVIOUS MONTH-TO-DATE (PMTD) AVERAGE INTEREST RATE
   --------------------------------------------------------- */
SELECT ROUND(AVG(int_rate) * 100, 2) AS pmtd_avg_interest_rate
FROM bank_loan_data
WHERE MONTH(issue_date) = MONTH(CURRENT_DATE - INTERVAL 1 MONTH)
  AND YEAR(issue_date) = YEAR(CURRENT_DATE - INTERVAL 1 MONTH);


/* ---------------------------------------------------------
   11. AVERAGE DEBT-TO-INCOME (DTI) RATIO
   --------------------------------------------------------- */
SELECT ROUND(AVG(dti) * 100, 2) AS avg_dti
FROM bank_loan_data;


/* ---------------------------------------------------------
   12. GOOD LOAN APPLICATION PERCENTAGE
   (Fully Paid + Current loans)
   --------------------------------------------------------- */
SELECT
    (COUNT(CASE WHEN loan_status IN ('Fully Paid','Current') THEN id END) * 100.0)
    / COUNT(id) AS good_loan_percentage
FROM bank_loan_data;


/* ---------------------------------------------------------
   13. TOTAL GOOD LOAN APPLICATIONS
   --------------------------------------------------------- */
SELECT COUNT(id) AS good_loan_applications
FROM bank_loan_data
WHERE loan_status IN ('Fully Paid','Current');


/* ---------------------------------------------------------
   14. TOTAL GOOD LOAN FUNDED AMOUNT
   --------------------------------------------------------- */
SELECT SUM(loan_amount) AS good_loan_funded_amount
FROM bank_loan_data
WHERE loan_status IN ('Fully Paid','Current');


/* ---------------------------------------------------------
   15. TOTAL GOOD LOAN AMOUNT RECEIVED
   --------------------------------------------------------- */
SELECT SUM(total_payment) AS good_loan_amount_received
FROM bank_loan_data
WHERE loan_status IN ('Fully Paid','Current');


/* ---------------------------------------------------------
   16. BAD LOAN APPLICATION PERCENTAGE
   (Charged Off loans)
   --------------------------------------------------------- */
SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0)
    / COUNT(id) AS bad_loan_percentage
FROM bank_loan_data;


/* ---------------------------------------------------------
   17. TOTAL BAD LOAN APPLICATIONS
   --------------------------------------------------------- */
SELECT COUNT(id) AS bad_loan_applications
FROM bank_loan_data
WHERE loan_status = 'Charged Off';


/* ---------------------------------------------------------
   18. TOTAL BAD LOAN FUNDED AMOUNT
   --------------------------------------------------------- */
SELECT SUM(loan_amount) AS bad_loan_funded_amount
FROM bank_loan_data
WHERE loan_status = 'Charged Off';


/* ---------------------------------------------------------
   19. TOTAL BAD LOAN AMOUNT RECEIVED
   --------------------------------------------------------- */
SELECT SUM(total_payment) AS bad_loan_amount_received
FROM bank_loan_data
WHERE loan_status = 'Charged Off';

