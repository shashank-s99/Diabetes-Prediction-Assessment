-- DIABETES PREDICTION ASSESSMENT
CREATE TABLE Diabetes (
    EmployeeName varchar(255),
    Patient_id varchar(255),
    gender varchar(255),
	age int,
	hypertension int,
	heart_disease int,
	smoking_history varchar(20),
	bmi double precision,
	HbA1c_level double precision,
	blood_glucose_level int,
	diabetes int

);

--FIRST VIEW OF DATA
SELECT * FROM diabetes;

--1. Retrieve the Patient_id and ages of all patients.
SELECT Patient_id , age FROM Diabetes;

--2. Select all female patients who are older than 40.
SELECT * FROM Diabetes
WHERE gender = 'Female' AND age > 40;

--3. Calculate the average BMI of patients.
SELECT AVG(bmi) AS Average_BMI FROM Diabetes;

--4. List patients in descending order of blood glucose levels.
SELECT employeename , patient_id , age , blood_glucose_level
FROM Diabetes
order by blood_glucose_level DESC;

--5. Find patients who have hypertension and diabetes.
SELECT * FROM diabetes
WHERE heart_disease = 1 AND diabetes = 1;

--6. Determine the number of patients with heart disease.
select count(patient_id) as Heart_Patients
from diabetes 
where heart_disease = 1;

--7. Group patients by smoking history and count how many smokers and non-smokers there are.
SELECT smoking_history , COUNT(*) AS Patient_count
FROM diabetes 
WHERE smoking_history IN ('current','never')
GROUP BY 1;

--8. Retrieve the Patient_ids of patients who have a BMI greater than the average BMI.
SELECT patient_id FROM diabetes
WHERE bmi > (SELECT AVG(bmi) FROM diabetes);

--9. Find the patient with the highest HbA1c level and the patient with the lowest HbA1clevel.
--patient with the highest HbA1c level
SELECT * FROM diabetes
ORDER BY hba1c_level DESC
LIMIT 1;

--patient with the lowest HbA1c level
SELECT * FROM diabetes
ORDER BY hba1c_level ASC
LIMIT 1;

--10. Calculate the age of patients in years (assuming the current date as of now).
SELECT patient_id, age, EXTRACT(YEAR FROM CURRENT_DATE) - age AS Birth_Year
FROM diabetes;

--11. Rank patients by blood glucose level within each gender group.
SELECT employeename as Patient_name, patient_id , gender , blood_glucose_level ,
dense_rank () over (partition by gender order by blood_glucose_level desc) as Glucose_rank
FROM Diabetes;

--12. Update the smoking history of patients who are older than 50 to "Ex-smoker."
-- Start a transaction
BEGIN;

-- Update smoking history for patients older than 50 to "Ex Smoker"
UPDATE diabetes
SET smoking_history = 'Ex Smoker'
WHERE age > 50;

-- Commit the transaction
COMMIT;

select Patient_id , smoking_history , age from diabetes where age > 50;

--13. Insert a new patient into the database with sample data.
INSERT INTO Diabetes 
(Employeename,Patient_id,gender,age,hypertension,heart_disease,smoking_history,bmi,HbA1c_level,blood_glucose_level,diabetes)
VALUES ('Andrew Simon','PT0154235','Male',54,1,1,'Ex Smoker',26.12,6.2,187,1);
SELECT * FROM diabetes
WHERE Employeename = 'Andrew Simon';

--14. Delete all patients with heart disease from the database.
DELETE FROM Diabetes
WHERE heart_disease = 1;
SELECT * FROM Diabetes WHERE heart_disease = 1;

--15. Find patients who have hypertension but not diabetes using the EXCEPT operator.
SELECT Employeename, Patient_id , hypertension , diabetes FROM diabetes WHERE hypertension = 1
EXCEPT
SELECT Employeename, Patient_id , hypertension , diabetes FROM diabetes WHERE diabetes = 1;

--16. Define a unique constraint on the "patient_id" column to ensure its values are unique.
ALTER TABLE diabetes ADD CONSTRAINT Unique_Patient_id UNIQUE(Patient_id);

--17. Create a view that displays the Patient_ids, ages, and BMI of patients.
CREATE VIEW Patient_details AS
SELECT Patient_id, age, bmi FROM diabetes;
SELECT * FROM Patient_details;

--18. Suggest improvements in the database schema to reduce data redundancy and improve data integrity.
/*Here are suggestions for improving the database schema:

Normalization: Ensure the database follows normalization principles to
minimize data redundancy and dependencies.

Foreign Keys: Use foreign keys to establish relationships, ensuring
referential integrity and preventing orphaned records.

Indexes: Create indexes on frequently used columns to improve query
performance, but avoid excessive indexing.

Default Values and Constraints: Employ default values and constraints
to enforce data integrity rules, reducing the risk of invalid data.

Audit Trails: Implement audit trails to track changes, providing a
historical record and enhancing accountability.*/

--19. Explain how you can optimize the performance of SQL queries on this dataset.
/*Here are few points for optimizing SQL queries on this dataset: 

Indexing: Create indexes on columns frequently used in WHERE clauses or JOIN
conditions to enhance query performance. 

Limit SELECT Columns: Select only the necessary columns in your queries to
reduce data transfer and improve efficiency. 

Optimize WHERE Clauses: Ensure efficient WHERE clauses by avoiding functions
on indexed columns and optimizing conditions. 

Use JOINs Efficiently: Optimize JOIN operations by selecting the appropriate
type and ensuring efficient join conditions. 

Update Statistics Regularly: Keep table statistics up-to-date to assist the
query planner in making informed execution plans.*/

