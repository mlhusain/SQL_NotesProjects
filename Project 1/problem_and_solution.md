
## Healthcare Data Analysis: Diabetes and Admission Types 

### Overview:
The objective of this analysis is to explore diabetic patient data, focusing on key aspects such as admission types, gender distribution, A1C results, and patient outcomes. Using SQL queries in a PostgreSQL environment, I aim to uncover insights into how various factors influence readmission rates and patient health status.  

#### Step 1: Load and Explore the Dataset

Goal: Load the dataset into a PostgreSQL database and inspect the structure.

    Loaded the diabetic dataset into the challenge2 schema.
    Verified data integrity by checking the number of records.

```sql

SELECT * FROM diabetic;
SELECT count(*) FROM diabetic; -- 101,766 records
```

#### Step 2: Data Preprocessing

Goal: Clean and transform the dataset for analysis.

    Removed ambiguous values (?) and cleaned missing data.
    Created a temporary table *diab* for further processing.

```sql

CREATE TEMPORARY TABLE diab AS 
SELECT encounter_id, patient_nbr, gender, age, weight, discharge_disposition_id, 
       a1cresult, readmitted,
       CASE WHEN admission_type_id != 6 THEN admission_type_id END AS admission_type_id,
       CASE WHEN race != '?' THEN race END AS race
FROM diabetic;
```
#### Step 3: Data Quality Check

Goal: Check for missing values and ensure data consistency.

    Inspected columns such as encounter_id, patient_nbr, and race for missing or null values.

```sql

SELECT encounter_id, COUNT(*) FROM diab GROUP BY encounter_id HAVING encounter_id IS NULL;
SELECT patient_nbr, COUNT(*) FROM diab GROUP BY patient_nbr HAVING patient_nbr IS NULL;
SELECT race, COUNT(*) FROM diab GROUP BY race HAVING race IS NULL;

    Replaced ? in the race column with NULL.

```
#### Step 4: Unique Encounters and Patients

Goal: Verify uniqueness of encounters and identify patients with multiple records.

    Counted the distinct encounter IDs and patient numbers.
    Identified patients with the highest number of encounters.

```sql

SELECT COUNT(DISTINCT encounter_id) FROM diab; -- 101,766 unique encounters
SELECT COUNT(DISTINCT patient_nbr) FROM diab; -- 71,518 distinct patients

-- Patients with multiple encounters:
SELECT patient_nbr, COUNT(*) 
FROM diab 
GROUP BY patient_nbr 
ORDER BY COUNT(*) DESC 
LIMIT 5;
```
#### Step 5: Mapping Admission Types

Goal: Categorize and summarize admission types.

    Created mapping tables for admission types, discharge disposition, and admission source.
    Joined these mapping tables to provide descriptions for each admission type.

```sql

SELECT admission_type_id, COUNT(*) AS cnt, 
       ROUND((COUNT(*) * 100 / SUM(COUNT(*)) OVER()), 2) AS percentage
FROM diab
GROUP BY admission_type_id
ORDER BY admission_type_id;
```

#### Step 6: Gender Distribution by Admission Type

Goal: Analyze the gender distribution across different admission types.

```sql

SELECT admission_type_id, 
       SUM(CASE WHEN gender = 'Female' THEN 1 ELSE 0 END) AS female_count,
       SUM(CASE WHEN gender = 'Male' THEN 1 ELSE 0 END) AS male_count,
       ROUND(SUM(CASE WHEN gender = 'Female' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS female_percentage,
       ROUND(SUM(CASE WHEN gender = 'Male' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS male_percentage
FROM diab
GROUP BY admission_type_id
ORDER BY admission_type_id;
```

#### Step 7: Age and A1C Results by Admission Type

Goal: Examine age distribution and A1C results for different admission types.

```sql

SELECT age, COUNT(*) AS count, 
       ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM diab
WHERE admission_type_id = 1
GROUP BY age
ORDER BY age;

```


    A1C Results:

```sql

SELECT a1cresult, COUNT(*) FROM diab GROUP BY a1cresult;
```

#### Step 8: A1C and Mortality Analysis

Goal: Identify relationships between A1C results and patient mortality.

    Focused on emergency admissions (admission_type_id = 1) and patients with A1C > 8.

```sql

WITH a AS (
    SELECT age, 
           SUM(CASE WHEN gender = 'Male' THEN 1 ELSE 0 END) AS male_count, 
           SUM(CASE WHEN gender = 'Female' THEN 1 ELSE 0 END) AS female_count
    FROM diab 
    WHERE a1cresult = '>8' AND admission_type_id = 1 
          AND discharge_disposition_id IN (11, 19, 20, 21)
    GROUP BY age
)
SELECT age, male_count, female_count,
       ROUND(male_count * 100.0 / SUM(male_count) OVER(), 2) AS male_percentage,
       ROUND(female_count * 100.0 / SUM(female_count) OVER(), 2) AS female_percentage
FROM a;
```


#### Step 9: Readmission Analysis

Goal: Explore readmission rates for patients with A1C > 8 and discharged within 30 days.

```sql

WITH readmit AS (
    SELECT age, 
           SUM(CASE WHEN gender = 'Male' THEN 1 ELSE 0 END) AS male_count,
           SUM(CASE WHEN gender = 'Female' THEN 1 ELSE 0 END) AS female_count
    FROM diab
    WHERE admission_type_id = 1 AND a1cresult = '>8' AND readmitted = '<30'
    GROUP BY age
)
SELECT age, male_count, female_count, 
       ROUND(male_count * 100.0 / SUM(male_count) OVER(), 2) AS male_percentage,
       ROUND(female_count * 100.0 / SUM(female_count) OVER(), 2) AS female_percentage
FROM readmit;
```

### Conclusion:

This analysis provided insights into admission types, gender and age distributions, A1C results, and readmission rates. It revealed significant patterns, such as the distribution of A1C results among diabetic patients and the gender-based admission trends. Further statistical analysis can be performed to explore causal relationships.
