-- SQL JOINs and UNION
-- Consider the two tables as follows
-- students table

DROP TABLE IF EXISTS students;

CREATE TABLE students (

id varchar(3),

first_name varchar(20),

last_name varchar(20),

grade numeric

);

INSERT INTO students (id,first_name,last_name,grade) VALUES

('101','Abdul','Latif',9),

('102','Mohammad','Ali',10),

('103','Zakia','Sultana',8),

('104','Samir','Kumar',9),

('105','Suman','Sarkar',10);

-- Scores table

DROP TABLE IF EXISTS scores;

CREATE TABLE scores(

id varchar(3),

course_name varchar(20),

scores numeric

);

INSERT INTO scores (id,course_name,scores) VALUES

('101','STAT',99.10),

('102','MATH',78.00),

('103','ICE',97.41),

('104','EEE',96.26),

('105','CSE',95.16),

('106','PHY',94.64)

;

-- Math score table

DROP TABLE IF EXISTS math_score;

CREATE TABLE math_score (

section_id varchar(1),

student_number varchar(3),

math_score numeric

);

INSERT INTO math_score (section_id,student_number,math_score) VALUES

('A','101',89),

('A','102',78),

('A','103',88),

('B','201',79),

('B','202',90),

('B','203',60),

('C','301',98),

('C','302',77),

('C','303',87),

('C','304',92);

-- Table for UNION example

DROP TABLE IF EXISTS students2;

CREATE TABLE students2 (

id varchar(3),

first_name varchar(20),

last_name varchar(20),

grade numeric

);

INSERT INTO students2 (id,first_name,last_name,grade) VALUES

('106','Momen','Mondol',7),

('107','Mohammad', 'Zakaria', 9),

('108','Sushanto', 'Chakrabarti', 10),

('109','Zerin', 'Tasneem', 10),

('110', 'Yasmin', 'Tazreen', 8),

('101','Abdul','Latif',9);

-- Table for UNION example

DROP TABLE IF EXISTS students2;

CREATE TABLE students2 (

id varchar(3),

first_name varchar(20),

last_name varchar(20),

grade numeric

);

INSERT INTO students2 (id,first_name,last_name,grade) VALUES

('106','Momen','Mondol',7),

('107','Mohammad', 'Zakaria', 9),

('108','Sushanto', 'Chakrabarti', 10),

('109','Zerin', 'Tasneem', 10),

('110', 'Yasmin', 'Tazreen', 8),

('101','Abdul','Latif',9);

SELECT * FROM scores INNER JOIN students ON scores.id = students.id ;
SELECT * FROM students AS st  LEFT  JOIN math_score AS ms ON st.id = ms.student_number ;
SELECT * FROM students FULL JOIN math_score ON students.id = math_score.student_number ;
SELECT * FROM students UNION SELECT * FROM math_score ; -- UNION must have same COLUMN numbers 
--union all  shows all record with dupicate whrere union not.

SELECT * FROM students 
UNION 
SELECT * FROM students2 ORDER BY id ;

SELECT 'students' AS table_name, count(*) AS value_count FROM students 
UNION SELECT 'students2' AS table_name, count(*) AS value_cont FROM students2 ;

-- Create temporary table
DROP TABLE IF EXISTS students_combined;
CREATE TEMPORARY TABLE students_combined AS 
SELECT * FROM students 
UNION ALL 
SELECT * FROM students2
ORDER BY id ;
 SELECT * FROM students_combined;

--Subquery
SELECT count(*) FROM
(
SELECT * FROM students 
UNION ALL 
SELECT * FROM students2
ORDER BY id) AS a;


-- Common Table Expresion (CTE)

WITH a AS (
  SELECT * FROM students
  UNION 
  SELECT * FROM students2
)
SELECT COUNT(*) FROM a;
SELECT count(*) FROM math_score ;

-- with a AS (
--  SELECT * FROM students
--  UNION 
--  SELECT * FROM students2
--)
--SELECT COUNT(*) FROM a
--ORDER BY id; The error: ORDER BY clause cannot be used in a SELECT COUNT(*) query. The ORDER BY is only relevant when selecting actual data (rows)


-- Question c: Begin a query with the 'students'table, and count
-- the number of non null student IDs after right joining with the matha_score on
-- students.id= math score.student_number.
-- how many recoreds are retured?

 
--SELECT count(*) FROM(  
--SELECT * FROM students RIGHT JOIN math_score ON students.id = math_score. student_number)
--AS qna
--WHERE students.id IS NOT  NULL ; --error at last line

SELECT count(*) 
FROM (
    SELECT * 
    FROM students 
    RIGHT JOIN math_score 
    ON students.id = math_score.student_number
) AS qna
WHERE qna.id IS NOT NULL;


SELECT * FROM students ;

SELECT count(*)
FROM students
RIGHT JOIN math_score 
ON students.id = math_score.student_number
WHERE students.id IS NOT NULL;







 