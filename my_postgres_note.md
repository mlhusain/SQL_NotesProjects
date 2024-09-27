

# PostgreSQL Basic Terminology

| **Term**       | **Definition**                                                |
|----------------|----------------------------------------------------------------|
| `Database`     | A collection of tables and other database objects.             |
| `Table`        | A structured collection of data organized in rows and columns. |
| `Column`       | A vertical entity in a table that holds data of a specific type.|
| `Row`          | A horizontal entity in a table that represents a single record.|
| `Schema`       | A namespace that contains database objects like tables and views.|
| `Query`        | A request for data or operations on data using SQL commands.   |
| `Index`        | A performance optimization feature that speeds up data retrieval.|
| `Primary Key`  | A unique identifier for a row in a table.                     |
| `Foreign Key`  | A column that establishes a relationship between tables.       |
| `View`         | A virtual table based on the result of a query.                |
| `Function`     | A stored procedure or function that performs an operation.     |
| `Trigger`      | A function that automatically executes in response to certain events.|
| `Transaction`  | A sequence of operations performed as a single unit of work.   |
| `SQL`          | Structured Query Language, used to manage and manipulate relational databases.|
| `DDL`          | Data Definition Language, used to define and modify database structures (e.g., `CREATE`, `ALTER`, `DROP`).|
| `DML`          | Data Manipulation Language, used to manage data (e.g., `SELECT`, `INSERT`, `UPDATE`, `DELETE`).|
| `Join`         | An operation that combines rows from two or more tables based on a related column.|
| `Aggregate Function` | A function that performs a calculation on a set of values and returns a single value (e.g., `SUM`, `AVG`).|
| `Subquery`     | A query nested inside another query.                           |

## Library Analogy for Database Concepts
	Database = Library: The whole collection of books and resources.
  	Schema = Section/Genre: Organizational grouping within the library.
  	Table = Book: Individual item within the section, containing structured information.

## Troubleshooting: "No active connection, no schema has been selected to create in"

If you encounter the following error after opening an SQL file and trying to execute it:


### Solution

1. Go to the toolbar.
2. From the dropdown menu, select the correct database and schema to connect to.
3. Ensure the connection is active before attempting to execute the SQL file.
4. This should resolve the issue.

## SQL Data Types
| **Category**   | **Data Type**                | **Description**                               |
|----------------|-------------------------------|-----------------------------------------------|
| **Numeric**    | `INT`, `INTEGER`              | Integer values                                |
|                | `BIGINT`                      | Large integer values                         |
|                | `SMALLINT`                    | Small integer values                         |
|                | `DECIMAL`, `NUMERIC`          | Exact numeric values with specified precision |
|                | `FLOAT`, `REAL`               | Approximate numeric values (floating-point)  |
|                | `DOUBLE PRECISION`            | Double-precision floating-point numbers      |
| **Character**  | `CHAR(n)`, `CHARACTER(n)`     | Fixed-length character string                |
|                | `VARCHAR(n)`, `CHARACTER VARYING(n)` | Variable-length character string            |
|                | `TEXT`                        | Variable-length text data                    |
| **Date/Time**  | `DATE`                        | Calendar date                                |
|                | `TIME`                        | Time of day (without time zone)              |
|                | `TIMESTAMP`                   | Date and time (without time zone)            |
|                | `TIMESTAMPTZ`                 | Date and time (with time zone)               |
|                | `INTERVAL`                    | Time span or duration                        |
| **Boolean**    | `BOOLEAN`                     | True or false values                         |
| **Binary**     | `BYTEA`                       | Binary data (byte array)                     |
| **UUID**       | `UUID`                        | Universally unique identifier                |
| **JSON**       | `JSON`                        | JSON data (textual representation)           |
|                | `JSONB`                       | Binary JSON data (more efficient storage)    |
| **Arrays**     | `ARRAY`                       | Array of any valid data type                 |
| **Special**    | `SERIAL`                      | Auto-incrementing integer (used for primary keys) |
|                | `BIGSERIAL`                   | Auto-incrementing large integer              |
|                | `OID`                         | Object Identifier (internally used by PostgreSQL) |


---

## Basic SQL Query Keywords

| **Keyword**  | **Purpose**                                             | **Order of Use** |
|--------------|---------------------------------------------------------|------------------|
| `SELECT`     | Specifies the columns to be retrieved                   | 1st              |
| `FROM`       | Specifies the table(s) from which to retrieve data      | 2nd              |
| `WHERE`      | Filters records based on a condition                    | 3rd              |
| `GROUP BY`   | Groups records with identical values into summary rows  | 4th              |
| `HAVING`     | Filters groups based on a condition                      | 5th              |
| `ORDER BY`   | Sorts the result set based on one or more columns        | 6th              |
| `LIMIT`      | Limits the number of rows returned                       | 7th              |


---

## First Thing First
1. Drop table if exists
2. Each query ends with semi-colon (;)
3. Showing first 3 records and pin the table
4. SQL is not case sensitive
5. Proper Commenting


---

## SQL Script for Managing `scores` Table

This script demonstrates how to create and populate the `scores` table.

```sql
-- Drop the table if it already exists
DROP TABLE IF EXISTS scores;

-- Create the table
CREATE TABLE scores (
    ID VARCHAR(3),
    Course_name VARCHAR(20),
    Score FLOAT
);

-- Insert data into the table
INSERT INTO scores (ID, Course_name, Score)
VALUES
    ('101', 'Environmental', 4),
    ('102', 'Transportation', 3.75),
    ('103', 'Environmental', 4),
    ('104', 'Structural', 3.5),
    ('105', 'Transportation', 3.75),
    ('106', 'Hydrology', 3.25);
```
---
## SQL Basic Keywords 

```sql
-- Display all records from the math_score table
SELECT *
FROM math_score;

-- Calculate the average math score for each section
-- GROUP BY clause is used to aggregate results by section_id
SELECT section_id, AVG(math_score) AS avg_score
FROM math_score
GROUP BY section_id;

-- Perform aggregation to calculate average, count, minimum, and maximum scores grouped by section_id
-- GROUP BY clause is used to aggregate results by section_id
-- This query provides a comprehensive summary of scores for each section
SELECT section_id, 
       AVG(math_score) AS avg_score, 
       COUNT(*) AS frequency, 
       MIN(math_score) AS min_score, 
       MAX(math_score) AS max_score
FROM math_score
GROUP BY section_id
ORDER BY section_id;

-- Alternative query to check the average score in Math by classroom section
-- GROUP BY clause is used to aggregate results by section_id
-- ORDER BY clause sorts the results by section_id
SELECT section_id, 
       AVG(math_score) AS avg_score, 
       COUNT(*) AS frequency, 
       MIN(math_score) AS min_score, 
       MAX(math_score) AS max_score
FROM math_score
GROUP BY section_id
ORDER BY section_id;

-- Test query to check the average score in Math without reference columns
-- This query is commented out since it doesn't provide information on section_id
-- SELECT AVG(math_score) AS avg_score 
-- FROM math_score 
-- GROUP BY section_id;

-- Use HAVING clause to filter the aggregated results
-- This query finds sections where the average math score is greater than 92
-- GROUP BY clause is used to aggregate results by section_id
-- HAVING clause filters the results based on the aggregated average score
SELECT section_id, 
       AVG(math_score) AS avg_score
FROM math_score
GROUP BY section_id
HAVING AVG(math_score) > 92
ORDER BY section_id;

-- Display all records from the math_score table
-- Limit the number of records to 5 for MySQL
-- In SQL Server, use TOP 5 instead of LIMIT 5
SELECT *
FROM math_score
LIMIT 5;  -- For MySQL: SELECT TOP 5 * FROM math_score;
```
---
# SQL Script for Table Creation, Data Insertion, Joins, Unions, and Aggregations:
1. Creating and Populating the students Table
```sql
-- Drop the table if it exists to avoid errors on re-creation
DROP TABLE IF EXISTS students;

-- Create the 'students' table
CREATE TABLE students (
    id VARCHAR(3),
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    grade NUMERIC
);

-- Insert sample data into the 'students' table
INSERT INTO students (id, first_name, last_name, grade) VALUES
('101', 'Abdul', 'Latif', 9),
('102', 'Mohammad', 'Ali', 10),
('103', 'Zakia', 'Sultana', 8),
('104', 'Samir', 'Kumar', 9),
('105', 'Suman', 'Sarkar', 10);
```
2. Creating and Populating the scores Table
```sql

-- Drop the table if it exists
DROP TABLE IF EXISTS scores;

-- Create the 'scores' table
CREATE TABLE scores (
    id VARCHAR(3),
    course_name VARCHAR(20),
    scores NUMERIC
);

-- Insert sample data into the 'scores' table
INSERT INTO scores (id, course_name, scores) VALUES
('101', 'STAT', 99.10),
('102', 'MATH', 78.00),
('103', 'ICE', 97.41),
('104', 'EEE', 96.26),
('105', 'CSE', 95.16),
('106', 'PHY', 94.64);
```
3. Creating and Populating the math_score Table
```sql
-- Drop the table if it exists
DROP TABLE IF EXISTS math_score;

-- Create the 'math_score' table
CREATE TABLE math_score (
    section_id VARCHAR(1),
    student_number VARCHAR(3),
    math_score NUMERIC
);

-- Insert sample data into the 'math_score' table
INSERT INTO math_score (section_id, student_number, math_score) VALUES
('A', '101', 89),
('A', '102', 78),
('A', '103', 88),
('B', '201', 79),
('B', '202', 90),
('B', '203', 60),
('C', '301', 98),
('C', '302', 77),
('C', '303', 87),
('C', '304', 92);
```
4. Creating and Populating the students2 Table
```sql

-- Drop the table if it exists
DROP TABLE IF EXISTS students2;

-- Create the 'students2' table
CREATE TABLE students2 (
    id VARCHAR(3),
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    grade NUMERIC
);

-- Insert sample data into the 'students2' table
INSERT INTO students2 (id, first_name, last_name, grade) VALUES
('106', 'Momen', 'Mondol', 7),
('107', 'Mohammad', 'Zakaria', 9),
('108', 'Sushanto', 'Chakrabarti', 10),
('109', 'Zerin', 'Tasneem', 10),
('110', 'Yasmin', 'Tazreen', 8),
('101', 'Abdul', 'Latif', 9);
```
## JOIN Operations (Left join means left table priority all records from the left table will retrieve, and right join means right table priority)
1. INNER JOIN Between scores and students
```sql
-- Retrieve all records where there is a match between 'scores' and 'students' on 'id'
SELECT * 
FROM scores 
INNER JOIN students 
ON scores.id = students.id;
```
2. LEFT JOIN Between students and math_score
```sql
-- Retrieve all records from 'students' and matching records from 'math_score' based on 'student_number'
SELECT * 
FROM students AS st
LEFT JOIN math_score AS ms
ON st.id = ms.student_number;
```
3. FULL JOIN Between students and math_score
```sql

-- Retrieve all records from 'students' and 'math_score', including unmatched records from both tables
SELECT * 
FROM students
FULL JOIN math_score 
ON students.id = math_score.student_number;
```
## UNION Operations
1. UNION Between students and math_score
```sql
-- Perform a UNION operation combining results from 'students' and 'math_score'
-- Note: UNION requires same number of columns and compatible data types
SELECT * 
FROM students 
UNION 
SELECT * 
FROM math_score;
```
2. UNION ALL Between students and students2
```sql
-- Combine results from 'students' and 'students2' including duplicates, and sort by 'id'
SELECT * 
FROM students 
UNION 
SELECT * 
FROM students2
ORDER BY id;
```
3. Count Rows in Each Table with UNION
```sql
-- Count the number of rows in each table and display with table names
SELECT 'students' AS table_name, COUNT(*) AS value_count 
FROM students
UNION 
SELECT 'students2' AS table_name, COUNT(*) AS value_count 
FROM students2;
```

---

## Temporary Tables and Common Table Expression (CTE)

1. Create and Query Temporary Table

```sql
-- Create a temporary table combining data from 'students' and 'students2'

CREATE TEMPORARY TABLE students_combined AS 
SELECT * 
FROM students 
UNION ALL 
SELECT * 
FROM students2
ORDER BY id;

-- Query the temporary table
SELECT * 
FROM students_combined;
```

2. Subquery for Row Count

```sql
-- Count rows using a subquery with UNION ALL
SELECT COUNT(*) 
FROM (
    SELECT * 
    FROM students 
    UNION ALL 
    SELECT * 
    FROM students2
    ORDER BY id
) AS a;
```

3. Common Table Expression (CTE)

```sql
-- Use a CTE to combine 'students' and 'students2', and count rows
WITH a AS (
    SELECT * 
    FROM students
    UNION 
    SELECT * 
    FROM students2
)
SELECT COUNT(*) 
FROM a;

-- Count rows in 'math_score'
SELECT COUNT(*) 
FROM math_score;
```
## Additional Query

Count Non-Null Student IDs After RIGHT JOIN

```sql
-- Count the number of non-null student IDs after a RIGHT JOIN between 'students' and 'math_score'
SELECT COUNT(*) 
FROM (
    SELECT * 
    FROM students 
    RIGHT JOIN math_score 
    ON students.id = math_score.student_number
) AS qna
WHERE qna.id IS NOT NULL;

-- Display all records from 'students'
SELECT * 
FROM students;

-- Count records in 'students' with RIGHT JOIN on 'math_score'
SELECT COUNT(*)
FROM students
RIGHT JOIN math_score 
ON students.id = math_score.student_number
WHERE students.id IS NOT NULL;
```
---
## Importing CSV file Using Dbeave/PgAdmin

	Exploring Data type and size such as bigint or int
	Right-clicking on  the schema - improt data- select the csv locaton - next- configure column structure option at top right corner- check and configure the columns based on exploration at first - next - proceed- next

---
## Export Data Using Dbeaver
### Exporting table from schema: 
go to scema - table - rigt click on the table- Export- select location- next- next
### Exporting table from subquery result 
right click on result table - export data- select location - next - next

---

Module 6: Calculated / Derived Columns
Topics Covered:

    Creating new columns based on existing columns
    Mathematical operations (addition, subtraction, division, multiplication, etc.)
    Data types and their impact on computation
    Data type conversion
    Learning more about the data

Exploring the Schema

    How many tables are in the schema?
    How many columns are there?
    What are the data types of each column?

```sql
-- Display the first three rows of the table
SELECT * FROM us_counties_pop_est LIMIT 3;

-- Count distinct states in the data
SELECT count(DISTINCT (state_name)) FROM us_counties_pop_est;
-- Returns 51 but we know the U.S. has 50 states, indicating possible anomalies
```


## Searching Methods in SQL
Using LIKE and ILIKE for Pattern Matching:

    LIKE is case-sensitive, while ILIKE is case-insensitive.
```sql
-- Case-sensitive search
SELECT * FROM us_counties_pop_est WHERE state_name LIKE 'Washington';
```


-- Case-sensitive search: returns no result because 'w' is lowercase
SELECT * FROM us_counties_pop_est WHERE state_name LIKE 'washington';

-- Case-insensitive search
SELECT * FROM us_counties_pop_est WHERE state_name ILIKE 'washington';
```

## Partial Matching Using ILIKE and %%

```sql
-- Find states containing 'colo'
SELECT * FROM us_counties_pop_est WHERE state_name ILIKE '%colo%';

-- Count rows where state name contains 'colo'
SELECT count(*) FROM us_counties_pop_est WHERE state_name ILIKE '%colo%';
-- Returns: 64
```
Find Counties Containing "dc"

```sql
-- Query to find counties that have 'dc' in their names (case-insensitive)
SELECT * FROM us_counties_pop_est WHERE county_name ILIKE '%dc%';
```
## Mathematical Operations in SQL
### Basic Mathematical Operators

    The ANSI standard operators (+, -, *, /) are common across databases.
    PostgreSQL supports additional operators like exponentiation (^), square root (|/), and modulus (%).

```sql
-- Addition
SELECT 2+3; -- Result: 5

-- Subtraction
SELECT 2-3; -- Result: -2

-- Multiplication
SELECT 2*3; -- Result: 6

-- Division (integer)
SELECT 2/3; -- Result: 0 (integer division)

-- Division (floating point)
SELECT 2.0/3; -- Result: 0.6666666666666667

```

### CAST: Data Type Conversion
#### General Form of Data Type Conversion

    CAST(expression AS target_data_type)
    PostgreSQL shorthand: expression::target_data_type

```sql
-- Convert an integer to a numeric to perform decimal division
SELECT CAST(5 AS numeric)/2;  -- Returns: 2.5
SELECT 5::numeric/2;           -- Returns: 2.5
```

## Population Analysis
#### Calculate Natural Increase in 2019

We can calculate the 2019 population estimate by adding and subtracting components like births, deaths, migration, and residual changes.
Step 1: Create a Temporary Table for Population Data

```sql
DROP TABLE IF EXISTS uspop;
CREATE TEMPORARY TABLE uspop AS 
SELECT 
    state_name AS state, 
    county_name AS county,
    pop_est_2018 AS pop18,
    pop_est_2019 AS pop19,
    births_2019 AS births,
    deaths_2019 AS deaths,
    international_migr_2019 AS mig19,
    domestic_migr_2019 AS dom19,
    residual_2019 AS residual
FROM us_counties_pop_est;

-- View the first 10 rows of the temp table
SELECT * FROM uspop LIMIT 10;

```

Step 2: Calculate 2019 Total Population Estimate

```sql
-- Calculate the estimated population for 2019
SELECT *,
    pop18 + births - deaths + mig19 + residual AS total_pop_19
FROM uspop 
LIMIT 10;
```

Validate the 2019 Population Estimate

```sql
-- Validate by comparing the calculated and actual 2019 population
SELECT *,
    pop19 - (pop18 + births - deaths + mig19 + residual) AS difference 
FROM uspop;
```

## Calculating Percent Area
### a) Percent Land Area

```sql
SELECT state_name AS state, county_name AS county, 
area_land::NUMERIC / (area_land + area_water) * 100 AS perc_land_area 
FROM us_counties_pop_est;
```

### a) Percent water Area
```sql
SELECT state_name AS state, county_name AS county, 
area_water::NUMERIC / (area_land + area_water) * 100 AS perc_water_area 
FROM us_counties_pop_est;
```

### c) Precaution: Casting During Integer Division
When performing integer division, numeric casting is required to ensure correct division results. For instance, rounding results after division ensures precision.


### Using the ROUND Function:Round Land Area Percentage
```sql
SELECT state_name AS state, county_name AS county, 
round(area_land::NUMERIC / (area_land + area_water) * 100, 2) AS perc_land_area 
FROM us_counties_pop_est;

SELECT state_name AS state, county_name AS county, 
round(area_water::NUMERIC / (area_land + area_water) * 100, 2) AS perc_water_area 
FROM us_counties_pop_est;

```

## Using CASE Statements: 
A CASE statement works like an IF-ELSE function. Here's an example to label regions based on numeric codes.

```sql

SELECT region, count(*) 
FROM us_counties_pop_est 
GROUP BY region;

SELECT region, count(*) 
FROM us_counties_pop_est 
GROUP BY 1;

SELECT state_fips, county_fips, region, state_name,
CASE 
    WHEN region = 1 THEN 'Northeast Region'
    WHEN region = 2 THEN 'Midwest Region'
    WHEN region = 3 THEN 'South Region'
    WHEN region = 4 THEN 'West Region'
    ELSE 'Other'
END AS region_name 
FROM us_counties_pop_est 
LIMIT 10;

WITH region_name_table AS (
    SELECT state_fips, county_fips, region, state_name,
    CASE 
        WHEN region = 1 THEN 'Northeast Region'
        WHEN region = 2 THEN 'Midwest Region'
        WHEN region = 3 THEN 'South Region'
        WHEN region = 4 THEN 'West Region'
        ELSE 'Other'
    END AS region_name 
    FROM us_counties_pop_est
)
SELECT region_name, count(*) 
FROM region_name_table 
GROUP BY region_name;
```

## Quiz: Temporary Table and Conditional Columns
### a) Creating a Temporary Table with Percent Water Area

The following code creates a temporary table, water_area, with columns for both land and water percentage areas:

```sql

DROP TABLE IF EXISTS water_area;
CREATE TEMPORARY TABLE water_area AS
SELECT state_name AS state, county_name AS county,
-- Calculate percent land area
round(area_land::NUMERIC / (area_land + area_water) * 100, 2) AS perc_land_area,
-- Calculate percent water area
round(area_water::NUMERIC / (area_land + area_water) * 100, 2) AS perc_water_area
FROM us_counties_pop_est ucpe;
```

### b) Querying the Number of Counties with Water Area under 10%

To find the number of counties with a water area under 10%, you can use the following query:

```sql

SELECT * 
FROM water_area 
WHERE perc_water_area < 10;
```
---

# Window Functions

### The syntax of a window function in SQL typically follows this format:

```sql
<window_function>(expression) 
OVER ([PARTITION BY column] [ORDER BY column])
```

#### Explanation:

1. <window_function>: This can be any aggregate function like SUM(), AVG(), ROW_NUMBER(), etc., that operates over a "window" of rows.


2. expression: Defines the target column or expression to apply the function on.


3. OVER: Defines the "window" over which the function operates.

PARTITION BY: (Optional) Divides the result set into partitions, and the function is applied to each partition independently.

ORDER BY: (Optional) Orders rows within each partition before applying the window function.




Example:
```sql
SELECT 
    employee_id, 
    department_id, 
    salary, 
    RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS salary_rank
FROM employees;
```
This ranks employees within each department (PARTITION BY department_id) based on their salary (ORDER BY salary DESC).

---

### Window Functions in a Columns

| **Window Function** | **Description**                               | **Example**                                  |
|---------------------|-----------------------------------------------|----------------------------------------------|
| `ROW_NUMBER()`      | Assigns a unique row number to each row.      | `ROW_NUMBER() OVER (ORDER BY salary)`        |
| `RANK()`            | Assigns a rank with gaps for ties.            | `RANK() OVER (ORDER BY salary DESC)`         |
| `DENSE_RANK()`      | Assigns a rank without gaps for ties.         | `DENSE_RANK() OVER (ORDER BY salary DESC)`   |
| `NTILE(n)`          | Divides rows into `n` equal groups.           | `NTILE(4) OVER (ORDER BY salary)`            |
| `LAG()`             | Returns the value from the previous row.      | `LAG(salary, 1) OVER (ORDER BY emp_id)`      |
| `LEAD()`            | Returns the value from the next row.          | `LEAD(salary, 1) OVER (ORDER BY emp_id)`     |
| `FIRST_VALUE()`     | Returns the first value in a partition.       | `FIRST_VALUE(salary) OVER (ORDER BY emp_id)` |
| `LAST_VALUE()`      | Returns the last value in a partition.        | `LAST_VALUE(salary) OVER (ORDER BY emp_id)`  |
| `SUM()`             | Returns the cumulative sum of values.         | `SUM(salary) OVER (PARTITION BY dept_id)`    |
| `AVG()`             | Returns the average value.                    | `AVG(salary) OVER (PARTITION BY dept_id)`    |
| `COUNT()`           | Returns the number of rows.                   | `COUNT(*) OVER (PARTITION BY dept_id)`       |
| `MAX()`             | Returns the maximum value.                    | `MAX(salary) OVER (PARTITION BY dept_id)`    |
| `MIN()`             | Returns the minimum value.                    | `MIN(salary) OVER (PARTITION BY dept_id)`    |


---

### Here is a comprehensive overview of all Aggregate Window Functions, including the Standard Deviation window functions:

#### Common Aggregate Window Functions

1. SUM(): Calculates the cumulative total of values within a window.

```sql
SELECT department, salary, 
SUM(salary) OVER (PARTITION BY department ORDER BY hire_date) AS running_total
FROM employees;
```

2. COUNT(): Counts the number of rows within a window.

```sql
SELECT department, 
COUNT(*) OVER (PARTITION BY department) AS employee_count
FROM employees;
```

3. AVG(): Computes the average value within the window.

```sql
SELECT department, salary, 
AVG(salary) OVER (PARTITION BY department) AS avg_salary
FROM employees;
```

4. MIN(): Finds the minimum value in the window.

```sql
SELECT department, salary, 
MIN(salary) OVER (PARTITION BY department) AS min_salary
FROM employees;
```

5. MAX(): Finds the maximum value in the window.

```sql
SELECT department, salary, 
MAX(salary) OVER (PARTITION BY department) AS max_salary
FROM employees;
```


#### Rank and Row Window Functions

6. ROW_NUMBER(): Assigns a unique row number within each partition.

```sql
SELECT department, salary, 
ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS rank
FROM employees;
```

7. RANK(): Assigns ranks, but gives the same rank to equal values and skips ranks for ties.

```sql
SELECT department, salary, 
RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rank
FROM employees;
```

8. DENSE_RANK(): Similar to RANK(), but does not skip ranks for ties.

```sql
SELECT department, salary, 
DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dense_rank
FROM employees;
```

9. NTILE(): Divides rows into a specified number of buckets or groups.

```sql
SELECT department, salary, 
NTILE(4) OVER (PARTITION BY department ORDER BY salary DESC) AS salary_quartile
FROM employees;
```


#### Lag/Lead Window Functions

10. LAG(): Returns the value from the previous row in the window.


```sql
SELECT employee_id, salary, 
LAG(salary) OVER (PARTITION BY department ORDER BY hire_date) AS prev_salary
FROM employees;
```

11. LEAD(): Returns the value from the next row in the window.


```sql
SELECT employee_id, salary, 
LEAD(salary) OVER (PARTITION BY department ORDER BY hire_date) AS next_salary
FROM employees;
```

#### First and Last Value Window Functions

12. FIRST_VALUE(): Returns the first value in the window.


```sql
SELECT employee_id, hire_date, salary, 
FIRST_VALUE(salary) OVER (PARTITION BY department ORDER BY hire_date) AS first_salary
FROM employees;
```

13. LAST_VALUE(): Returns the last value in the window.


```sql
SELECT employee_id, hire_date, salary, 
LAST_VALUE(salary) OVER (PARTITION BY department ORDER BY hire_date) AS last_salary
FROM employees;
```

#### Standard Deviation Window Functions

14. STDDEV_POP(): Calculates the population standard deviation within the window.



Use this when you have the complete dataset (the population).


```sql
SELECT department, salary, 
STDDEV_POP(salary) OVER (PARTITION BY department) AS stddev_pop_salary
FROM employees;
```

15. STDDEV_SAMP(): Calculates the sample standard deviation within the window.



#### Use this when you're working with a subset of data (a sample).

```sql
SELECT department, salary, 
STDDEV_SAMP(salary) OVER (PARTITION BY department) AS stddev_samp_salary
FROM employees;
```

Variance Window Functions (Related to Standard Deviation)

16. VAR_POP(): Calculates the population variance within the window.



#### Variance is the square of the standard deviation.

```sql
SELECT department, salary, 
VAR_POP(salary) OVER (PARTITION BY department) AS var_pop_salary
FROM employees;
```

17. VAR_SAMP(): Calculates the sample variance within the window.

```sql
SELECT department, salary, 
VAR_SAMP(salary) OVER (PARTITION BY department) AS var_samp_salary
FROM employees;
```

### Example with Multiple Aggregate Window Functions:

```sql
SELECT employee_id, department, salary,
   SUM(salary) OVER (PARTITION BY department ORDER BY hire_date) AS running_total,
   AVG(salary) OVER (PARTITION BY department) AS avg_salary,
   STDDEV_SAMP(salary) OVER (PARTITION BY department) AS stddev_salary,
   RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rank
FROM employees;
```

#### Explanation of Key Clauses:

1. PARTITION BY: Divides the dataset into partitions or groups. The window function is applied within each partition.

Example: PARTITION BY department groups the data by department.



2. ORDER BY: Defines the order of rows within each partition.

Example: ORDER BY hire_date orders rows based on the hire date within the partition.



3. Frame Clause: Optional, it defines a subset of rows in the window for the calculation (like ROWS BETWEEN 1 PRECEDING AND CURRENT ROW).




---

##### Key Takeaways:

Aggregate window functions allow you to calculate cumulative, ranking, and statistical functions (like standard deviation) over a defined window of rows.

Window functions do not collapse the rows like GROUP BY; they allow you to maintain row-level detail while computing aggregates.

Common window functions include SUM(), AVG(), COUNT(), STDDEV_POP(), STDDEV_SAMP(), VAR_POP(), and VAR_SAMP().


These functions are especially powerful for performing advanced analytics, like calculating running totals, ranking data, and analyzing variability within datasets.



----

## WINDOW vs ORDER BY


GROUP BY: Aggregates data by grouping rows based on specified columns. Each group returns a single row with aggregate results (e.g., SUM, COUNT). It collapses rows into a summary.

Example: Grouping sales by region to get the total sales per region.

```sql
SELECT region, SUM(sales)
FROM sales_data
GROUP BY region;
```

Window Functions: Operate over a set of rows related to the current row without collapsing them into one. They allow you to compute aggregates while still keeping the original rows visible.

Example: Calculating a running total of sales across regions while keeping all rows.

```sql
SELECT region, sales, SUM(sales) OVER (PARTITION BY region ORDER BY date) AS running_total
FROM sales_data;
```

Key Differences:

GROUP BY reduces rows; Window Functions retain all rows.

Window Functions provide aggregate results without losing row-level detail.

GROUP BY is limited to group-level operations, while Window Functions offer more flexibility (e.g., row comparisons within partitions).

---


