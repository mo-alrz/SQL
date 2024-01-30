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

--You need to write a sql query that will return the daily balance history from monetary operations tables for all the time.
--The balance of the day (end day balance) is equal to the balance at the begin of the day with total amount of operations during the day added. The balance at the begin of the day is equal to the balance at the end of the previous day. The balance before the very first operation is zero.
--Input
--operations

-- Column    |  Type      |
-------------+------------+
-- amount    | numeric    |
-- date      | timestamp  |

--    amount             date
----------------------------------------+
--502.944042810036   2020-01-01T00:01:00.000+00:00
--1101.5004691791    2020-01-01T00:02:00.000+00:00
--1618.92180791447   2020-01-01T00:03:00.000+00:00
---1656.39770507234  2020-01-02T10:01:00.000+00:00
--656.39770507234    2020-01-03T00:05:00.000+00:00
---656.39770507234   2020-01-03T00:07:00.000+00:00
--613.944042810036   2020-01-04T01:01:00.000+00:00
--..

--Output

-- Column    |  Type      |
-------------+------------+
-- date      | date       |
-- balance   | numeric    |

--  date    |   balance
----------------------------+
--2020-01-01  3223.3663199036064
--2020-01-02  1566.9686148312664
--2020-01-03  1566.9686148312664
--..
SELECT DISTINCT(date::date) date, SUM(amount) OVER (ORDER BY date::date) balance
FROM operations
ORDER BY 1;

--Your classmates asked you to copy some paperwork for them. You know that there are 'n' classmates and the paperwork has 'm' pages.
--Your task is to calculate how many blank pages do you need. If n < 0 or m < 0 return 0.
--Example:
--n= 5, m=5: 25
--n=-5, m=5:  0
SELECT n, m,
       CASE WHEN n > 0 and m > 0 THEN n * m
       ELSE 0 END AS res
FROM paperwork;

--It's pretty straightforward. Your goal is to create a function that removes the first and last characters of a string.
--You're given one parameter, the original string. You don't have to worry about strings with less than two characters.
SELECT s,CASE WHEN LENGTH(s) >= 2 THEN SUBSTRING(s,2,LENGTH(s)-2)
         ELSE NULL END AS res
FROM removechar;

--The first century spans from the year 1 up to and including the year 100, the second century - from the year 101 up to and including the year 200, etc.
--Task
--Given a year, return the century it is in.
--Examples

--1705 --> 18
--1900 --> 19
--1601 --> 17
--2000 --> 20
--2742 --> 28

--In SQL, you will be given a table years with a column yr for the year. Return a table with a column century.
SELECT yr, CASE WHEN yr % 100 = 0 THEN (yr/100)::INTEGER
           ELSE (yr/100)::INTEGER +1 END AS century
FROM years;

--Create a function with two arguments that will return an array of the first n multiples of x.
--Assume both the given number and the number of times to count will be positive numbers greater than 0.
--Return the results as an array or list ( depending on language ).
--Examples
--countBy(1,10)  should return  {1,2,3,4,5,6,7,8,9,10}
--countBy(2,5)  should return {2,4,6,8,10}
--you are given a table 'counter' with columns 'x' (int) and 'n' (int)
--return a query with columns 'x', 'n' and your result in a column named 'res' (array)
--sort results by column 'x' ascending, then by 'n' ascending
--note that each pair of 'x' and 'n' in 'counter' is unique
SELECT x, n, ARRAY(SELECT generate_series(1, n) * x) AS res
FROM counter
ORDER BY 1,2;

--You need to create a function that calculates the number of weekdays (Monday through Friday) between two dates inclusively.
--The function should be named weekdays accept two arguments of type DATE and return an INTEGER value.
--weekdays(DATE, DATE) INTEGER
--The order of arguments shouldn't matter. To illustrate both of the following queries
--SELECT weekdays('2016-01-01', '2016-01-10');
--SELECT weekdays('2016-01-10', '2016-01-01');
CREATE OR REPLACE FUNCTION weekdays(date1 DATE, date2 DATE)
RETURNS INTEGER AS $$
DECLARE
    int_val INTEGER;
BEGIN
    int_val := (
        SELECT COUNT(*)
        FROM generate_series(
            LEAST(date1, date2),
            GREATEST(date1, date2),
            interval '1 day'
        ) AS date_sequence
        WHERE EXTRACT(DOW FROM date_sequence) BETWEEN 1 AND 5
    );

    RETURN int_val;
END;
$$ LANGUAGE plpgsql;

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
--| 3   | 1          | Physics     | 92    |
--| 4   | 1          | Literature  | 80    |
--...
--The university is considering expelling students who either quit their studies or are consistently performing poorly
--in their courses. A student who quits is defined as a student with no records in the courses table. A student who is
--performing poorly is defined as a student with 3 or more courses with a grade less than 60.
--Write a SQL query that retrieves a list of students who qualify for expulsion based on the criteria described above.
--The query should return the following columns:
--    student_id: The ID of the student
--    name: The name of the student
--    reason: The reason for expelling the student. It should say either "quit studying" if the student has no records
--in the courses table, or "failed in [List of Courses]" where [List of Courses] is a comma-separated list of the courses
--that the student has failed. Each course in the list should be followed by the grade in parentheses. Failed courses should
--be sorted in ascending alphabetical order.
--The result should be ordered by the student ID in ascending order.
--Desired Output
--The desired output should look like this:
--student_id	name	reason
--10	James	failed in Math(59), Physics(57), Science(58)
--11	David	failed in Literature(58), Math(55), Physics(57), Science(56)
--12	Lucy	quit studying
--13	Daniel	quit studying
--14	Grace	quit studying
SELECT * FROM (SELECT student_id,
                      name,
                      CASE WHEN ARRAY_LENGTH(reason,1) >= 3 THEN 'failed in ' || ARRAY_TO_STRING(reason,', ')
                           WHEN 'quit studying'=ANY(reason) THEN 'quit studying'
                           END AS reason
                FROM (SELECT student_id,name, ARRAY_AGG(reason) AS reason
                      FROM (SELECT s.id student_id,
                                   s.name,
                                   CASE WHEN c.score < 60 THEN c.course_name || '(' || c.score || ')'
                                        WHEN c.score is NULL THEN 'quit studying'
                                   END AS reason
                            FROM students s
                            LEFT JOIN courses c
                            ON s.id = c.student_id
                            ORDER BY 1,2,3 ) t1
                      WHERE reason IS NOT NULL
                      GROUP BY 1,2 ) t2 ) t3
WHERE reason IS NOT NULL;



