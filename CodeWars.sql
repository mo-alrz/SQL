--You are given a table named repositories, format as below:
--** repositories table schema **
--    project
--    commits
--    contributors
--    address
--The table shows project names of major cryptocurrencies, their numbers of commits and contributors and also a random donation address ( not linked in any way :) ).
--Your job is to split out the letters and numbers from the address provided, and return a table in the following format:
--** output table schema **
--    project
--    letters
--    numbers
--Case should be maintained.
SELECT
  project,
  REGEXP_REPLACE(address,'[[:digit:]]','','g') letters,
  REGEXP_REPLACE(address,'[[:alpha:]]','','g') numbers
FROM repositories;
--OR
SELECT
    project,
    REGEXP_REPLACE(address, '\d', '', 'g') as letters,
    REGEXP_REPLACE(address, '\D', '', 'g') as numbers,
FROM repositories;

--The objective of this Kata is to show that you are proficient at string manipulation (and perhaps that you can use extensively subqueries).
--You will use people table but will focus solely on the name column
--name
--Greyson Tate Lebsack Jr.
--Elmore Clementina O'Conner
--you will be provided with a full name and you have to return the name in columns as follows.
--name 	first_lastname 	second_lastname
--Greyson Tate 	Lebsack 	Jr.
--Elmore 	Clementina 	O'Conner
--Note: Don't forget to remove spaces around names in your result.
--Note: Due to multicultural context, if full name has more than 3 words, consider the last 2 as first_lastname and second_lastname, all other names belonging to name.
SELECT CASE WHEN LEN > 3 THEN CONCAT(name_array[1],' ',name_array[2])
       ELSE name_array[1] END AS name,
       CASE WHEN LEN > 3 THEN name_array[3]
       ELSE name_array[2] END AS first_lastname,
       CASE WHEN LEN > 3 THEN name_array[4]
       ELSE name_array[3] END AS second_lastname

FROM ( SELECT REGEXP_SPLIT_TO_ARRAY(name,E'\\s+') as name_array,
              ARRAY_LENGTH(regexp_split_to_array(name,E'\\s+'),1) len
       FROM people) t1

--This kata is inspired by SQL Basics: Simple PIVOTING data by matt c.
--You need to build a pivot table WITHOUT using CROSSTAB function. Having two tables products and details you need to
--select a pivot table of products with counts of details occurrences (possible details values are ['good', 'ok', 'bad'].
--Results should be ordered by product's name.
--Model schema for the kata is:
--products     details
--id-----------product—id
--name         id
--             detail
--your query should return table with next columns
-- name
-- good
-- ok
-- bad
SELECT name,COUNT(good) good, COUNT(ok) ok, COUNT(bad) bad
FROM (SELECT p.name AS name,
             CASE WHEN d.detail = 'good' THEN 1 END AS good,
             CASE WHEN d.detail = 'ok' THEN 1 END AS ok,
             CASE WHEN d.detail = 'bad' THEN 1 END AS bad
      FROM products p
      JOIN details d
      ON p.id = d.product_id) t1

GROUP BY 1
ORDER BY 1;

--Let's consider a case where we have a students table and a courses table. The tables have the following structure:
--students:
--| id  | name     | email               |
--|-----|----------|---------------------|
--| 1   | John     | john@example.com    |
--| 2   | Sarah    | sarah@example.com   |
--| 3   | Robert   | robert@example.com  |
--...
--courses:
--| id  | student_id | course_name | score |
--|-----|------------|-------------|-------|
--| 1   | 1          | Math        | 90    |
--| 2   | 1          | Science     | 85    |
--| 3   | 2          | Math        | 92    |
--| 4   | 2          | Science     | 80    |
--...
--We need to find the students who have a higher score in Science than in Math.
--Your SQL query should return the student_id, name (the name of the student), and his or her difference in scores between these courses (named as score_difference).
--Order the result by the difference in scores in descending order, and if diffrence is the same, then by student_id in ascending order.
--Good Luck!
--Desired Output
--The desired output should look like this:
--student_id	name	score_difference
--         3	Robert	25
--         5	Emma	3
--         6	Olivia	2
--        10	James	2
SELECT
       student_id, name, science - math AS score_difference
FROM (
      SELECT
          c.student_id AS student_id,
          s.name AS name,
          MAX(CASE WHEN c.id % 2 = 0 THEN c.score END) AS science,
          MAX(CASE WHEN c.id % 2 <> 0 THEN c.score END) AS math
      FROM
          students s
      JOIN courses c ON s.id = c.student_id
      GROUP BY c.student_id, s.name
      ORDER BY 1) t1
WHERE science > math
ORDER BY 3 DESC,1;

--For this challenge you need to create a RECURSIVE Hierarchical query. You have a table employees of employees, you must
--order each employee by level. You must use a WITH statement and name it employee_levels after that has been defined you must select from it.
--A Level is in correlation what manager managers the employee. e.g. an employee with a manager_id of NULL is at level 1
--and then direct employees with the employee at level 1 will be level 2.
--employees table schema
--    id
--    first_name
--    last_name
--    manager_id (can be NULL)
--resultant schema
--    level
--    id
--    first_name
--    last_name
--    manager_id (can be NULL)
