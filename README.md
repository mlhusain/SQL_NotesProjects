

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
    
