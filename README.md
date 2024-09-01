--Problem: no schema has been selected to create
-- solution: Open the file from Dbeaver - copy the code - select a schema- open new SQL scrip- paste the code and execute.
-- Cause: postgreSQL and Dbeaver save scripts in CDrive at AppData folder, also read from it. 
-- If you want save for sharing that the file, should use  save as option from file manue.
-- Although column name is changed by using alias, during code previous column name must be used. dont know why?!!!
--to drop the existing table


drop table if exists scores;
--Creating Table

create table scores (
ID varchar (3), Course_name varchar (20), Score float)
;

insert into
	scores (ID , Course_name , Score)
values
('101', 'Environmental', '4'),
('102','Transportation', '3.75'),
('103','Environmental ', '4'),
('104', 'Structural', '3.5'),
('105', 'Transportation', '3.75'),
('106', 'Hydrology', '3.25')
;



--SELECT: Showing Data

select *from scores;
--SELECT count(*) FROM scores;
-- Select using alias
select id as course_id, course_name, score as gpa
from scores;
--Where Clause
select *
from scores
where score >= 3.5;

select *
from scores
where score in (3.5, 4);



--GROUP BY CLAUSE:
-- Create a table named math_score

drop table if exists math_score ;

create table math_score (
section_id varchar(1), student_number varchar(3), math_score int
);

insert into
	math_score ( section_id , student_number, math_score)
values
('A', '101', 99),
('A', '102', 88),
('A', '103', 90),
('B', '201', 98),
('B', '202', 95),
('B', '203', 87),
('C', '301', 93),
('C', '302', 91),
('C', '303', 94),
('C', '304', 86)
;

select *
from math_score;
--Avg math score by section 

select section_id, avg(math_score) as avg_score
from math_score
group BY section_id;


--GROUP BY: To perform an aggregation query to calculate average, count, minimum, and maximum scores grouped by section_id
-- Question: what is the average score in Math by classroom section?

select section_id, avg(math_score) as avg_score, count(*) as frequency, min(math_score) as min_score, max(math_score) as max_score
from math_score
group BY section_id
;

select section_id, AVG(math_score) as avg_score, COUNT(*) as frequency, MIN(math_score) as min_score, MAX(math_score) as max_score
from math_score group BY section_id order BY section_id ;
	
--SELECT avg(math_score)AS avg_score FROM math_score GROUP BY section_id ; -- TO test the RESULT WITH OUT referece column

--HAVING CLAUSE: TO FILTER AGGREGATED RESULT 
--Question: which section has average score in math is greater than 92?

SELECT section_id, avg(math_score) AS avg_score FROM math_score GROUP BY section_id HAVING avg(math_score) > 92 ORDER BY section_id ; 

--LIMIT CLAUSE 
SELECT * FROM math_score;
SELECT * FROM math_score LIMIT 5; -- FOR MySQL SELECT top 5 * FROM math_score;
