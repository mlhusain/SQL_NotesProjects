

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


## First Thing First
1. Drop table if exists
2. Each query ends with semi-colon (;)
3. Showing first 3 records and pin the table
4. SQL is not case sensitive
5. Proper Commenting




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
## Table Structure: math_score

Assume a table named math_score with columns:

    student_id – Unique identifier for each student.
    section_id – The section or classroom the student belongs to.
    math_score – The math score of the student.


### Query 1: Basic Selection of Data
To view all the data in the math_score table:
SELECT * 
FROM math_score;
This will return all the rows in the math_score table. You can further limit the results using the LIMIT clause (see Query 6).

### Query 2: Calculating Average Math Score by Section

To find the average math score for each section, use the following SQL query:

```sql
SELECT section_id, AVG(math_score) AS avg_score 
FROM math_score 
GROUP BY section_id;

    
### Query 3: Detailed Aggregation: Average, Count, Minimum, and Maximum.

To get more detailed statistics (average, count, minimum, and maximum scores) for each section:

SELECT section_id, 
       AVG(math_score) AS avg_score, 
       COUNT(*) AS frequency, 
       MIN(math_score) AS min_score, 
       MAX(math_score) AS max_score 
FROM math_score 
GROUP BY section_id;

	This query will return the following for each section:
	avg_score: The average score.
	frequency: The number of students (rows) in each section.
	min_score: The lowest math score.
	max_score: The highest math score.

### Query 4: Aggregation with Ordering

You can further order the results by section_id:


SELECT section_id, 
       AVG(math_score) AS avg_score, 
       COUNT(*) AS frequency, 
       MIN(math_score) AS min_score, 
       MAX(math_score) AS max_score
       FROM math_score 
       GROUP BY section_id 	
       ORDER BY section_id;

ORDER BY: Orders the results by the section_id.

###Query 5: Using the HAVING Clause to Filter Aggregated Results

Suppose you only want sections where the average math score is greater than 92. This is where the HAVING clause is useful. HAVING is used to filter aggregated results (after GROUP BY):

sql

SELECT section_id, AVG(math_score) AS avg_score 
FROM math_score 
GROUP BY section_id 
HAVING AVG(math_score) > 92 
ORDER BY section_id;

    HAVING: Filters the aggregated result, allowing only sections with an average score greater than 92.

###Query 6: Limiting the Number of Results

To limit the number of rows returned in a result set, use the LIMIT clause:


SELECT * 
FROM math_score 
LIMIT 5;

    This query will return only the first 5 rows from the math_score table.
    For MySQL, an alternative to LIMIT is SELECT TOP:


SELECT TOP 5 * 
FROM math_score;

###Summary of Key SQL Concepts:

GROUP BY: Groups rows that have the same values into summary rows.
AVG(): Calculates the average value.
COUNT(): Counts the number of rows.
MIN() / MAX(): Returns the minimum and maximum values.
HAVING: Filters records after aggregation, often used with GROUP BY.
LIMIT: Restricts the number of rows returned.
    
