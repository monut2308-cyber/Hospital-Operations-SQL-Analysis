-- ============================================================================
-- Hospital Operations & Healthcare Analytics (PostgreSQL)
-- Author: Monu Thakur
-- ============================================================================

-- 1. Total Number of Patients
-- Write an SQL query to find the total number of patients across all hospitals.
SELECT 
    SUM(patients_count) AS total_patients 
FROM hospital;


-- 2. Average Number of Doctors per Hospital
-- Retrieve the average count of doctors available in each hospital.
SELECT 
    ROUND(AVG(doctors_count), 2) AS avg_doctors_per_hospital 
FROM hospital;


-- 3. Top 3 Departments with the Highest Number of Patients
-- Find the top 3 hospital departments that have the highest number of patients.
SELECT 
    department, 
    SUM(patients_count) AS total_patients 
FROM hospital 
GROUP BY department 
ORDER BY total_patients DESC 
LIMIT 3;


-- 4. Hospital with the Maximum Medical Expenses
-- Identify the hospital that recorded the highest medical expenses.
SELECT 
    hospital_name, 
    SUM(medical_expenses) AS total_expenses 
FROM hospital 
GROUP BY hospital_name 
ORDER BY total_expenses DESC 
LIMIT 1;


-- 5. Daily Average Medical Expenses (FIXED)
-- Calculate the average medical expenses per day for each hospital.
SELECT 
    hospital_name, 
    ROUND(SUM(medical_expenses) / NULLIF(SUM(discharge_date - admission_date), 0), 2) AS avg_daily_expenses 
FROM hospital 
GROUP BY hospital_name 
ORDER BY avg_daily_expenses DESC;


-- 6. Longest Hospital Stay (FIXED)
-- Find the patient record with the longest stay by calculating the difference between Discharge Date and Admission Date.
SELECT 
    hospital_name, 
    department, 
    location, 
    patients_count, 
    (discharge_date - admission_date) AS longest_stay_days 
FROM hospital 
ORDER BY longest_stay_days DESC 
LIMIT 1;


-- 7. Total Patients Treated Per City
-- Count the total number of patients treated in each city.
SELECT 
    location AS city, 
    SUM(patients_count) AS total_patients 
FROM hospital 
GROUP BY location 
ORDER BY total_patients DESC;


-- 8. Average Length of Stay Per Department
-- Calculate the average number of days patients spend in each department.
SELECT 
    department, 
    ROUND(AVG(discharge_date - admission_date), 2) AS avg_stay_days 
FROM hospital 
GROUP BY department 
ORDER BY avg_stay_days DESC;


-- 9. Identify the Department with the Lowest Number of Patients
-- Find the department with the least number of patients.
SELECT 
    department, 
    SUM(patients_count) AS total_patients 
FROM hospital 
GROUP BY department 
ORDER BY total_patients ASC 
LIMIT 1;


-- 10. Monthly Medical Expenses Report
-- Group the data by month and calculate the total medical expenses for each month.
SELECT 
    EXTRACT(MONTH FROM admission_date) AS month_number, 
    TRIM(TO_CHAR(admission_date, 'Month')) AS month_name, 
    SUM(medical_expenses) AS total_medical_expenses 
FROM hospital 
GROUP BY month_number, month_name 
ORDER BY month_number;
