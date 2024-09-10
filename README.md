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







