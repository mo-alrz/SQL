--Why Businesses Like Databases
--
--    Data integrity is ensured - only the data you want entered is entered, and only certain users are able to enter
--    data into the database.
--
--    Data can be accessed quickly - SQL allows you to obtain results very quickly from the data stored in a database.
--    Code can be optimized to quickly pull results.
--
--    Data is easily shared - multiple individuals can access data stored in a database, and the data is the same for
--    all users allowing for consistent results for anyone with access to your database.

--A few key points about data stored in SQL databases:
--
--    Data in databases is stored in tables that can be thought of just like Excel spreadsheets.
--    For the most part, you can think of a database as a bunch of Excel spreadsheets. Each spreadsheet has rows and
--    columns. Where each row holds data on a transaction, a person, a company, etc., while each column holds data
--    pertaining to a particular aspect of one of the rows you care about like a name, location, a unique id, etc.
--
--    All the data in the same column must match in terms of data type.
--    An entire column is considered quantitative, discrete, or as some sort of string. This means if you have one row
--    with a string in a particular column, the entire column might change to a text data type. This can be very bad if
--    you want to do math with this column!
--
--    Consistent column types are one of the main reasons working with databases is fast.
--    Often databases hold a LOT of data. So, knowing that the columns are all of the same type of data means that
--    obtaining data from a database can still be fast.

--Select
SELECT id,account_id,occurred_at
FROM orders;

--Formatting best practices
--1-Using Upper and Lower Case in SQL
--2-Avoid Spaces in Table and Variable Names
--3-Use White Space in Queries
--4-Finish with semicolons

--Limit n -> Shows the first n rows
SELECT *
FROM orders
LIMIT 10;

SELECT occurred_at, account_id, channel
FROM web_events
LIMIT 15;

--Order By -> Between FROM and LIMIT , Default = Ascending
--Write a query to return the 10 earliest orders in the orders table. Include the id, occurred_at, and total_amt_usd.
SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY occurred_at
LIMIT 10;

--Write a query to return the top 5 orders in terms of largest total_amt_usd. Include the id, account_id, and total_amt_usd.
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC
LIMIT 5;

--Write a query to return the lowest 20 orders in terms of smallest total_amt_usd. Include the id, account_id, and total_amt_usd.
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd
LIMIT 20;

--Write a query that displays the order ID, account ID, and total dollar amount for all the orders, sorted first by the
--account ID (in ascending order), and then by the total dollar amount (in descending order).
SELECT id,account_id,total_amt_usd
FROM orders
ORDER BY account_id,total_amt_usd DESC;

--Now write a query that again displays order ID, account ID, and total dollar amount for each order, but this time
--sorted first by total dollar amount (in descending order), and then by account ID (in ascending order).
SELECT id,account_id,total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC,account_id;

--Where < > <= >= = != -> After FROM but before ORDER BY
--Write a query that pulls the first 5 rows and all columns from the orders table that have a dollar amount of
--gloss_amt_usd greater than or equal to 1000.
SELECT *
FROM order
WHERE gloss_amt_usd >= 1000
LIMIT 5;

--Write a query that pulls the first 10 rows and all columns from the orders table that have a total_amt_usd less than 500.
SELECT *
FROM orders
WHERE total_amt_usd < 500
LIMIT 10;

--Filter the accounts table to include the company name, website, and the primary point of contact (primary_poc) just for
--the Exxon Mobil company in the accounts table.
SELECT name,website,primary_poc
FROM accounts
WHERE name = 'Exxon Mobil';

--Arithmetic Operators + - * / -> Derived,Calculated or Computed column
--Create a column that divides the standard_amt_usd by the standard_qty to find the unit price for standard paper for
--each order. Limit the results to the first 10 orders, and include the id and account_id fields.
SELECT id, account_id, standard_amt_usd / standard_qty AS unit_price
FROM orders
LIMIT 10;

--Write a query that finds the percentage of revenue that comes from poster paper for each order. You will need to use
--only the columns that end with _usd. (Try to do this without using the total column.) Display the id and account_id fields also.
--Limit the results to the first 10 orders
SELECT id, account_id,
       poster_amt_usd / (standard_amt_usd+gloss_amt_usd+poster_amt_usd) AS post_percentage
FROM orders
LIMIT 10;

--Logical Operators LIKE IN NOT AND BETWEEN OR
--  LIKE % _ ->
--    The percent sign % represents zero, one, or multiple characters
--    The underscore sign _ represents one, single character

--Use the accounts table to find
--    All the companies whose names start with 'C'.
SELECT *
FROM accounts
WHERE name LIKE 'C%';

--    All companies whose names contain the string 'one' somewhere in the name.
SELECT *
FROM accounts
WHERE name LIKE '%one%';

--    All companies whose names end with 's'.
SELECT *
FROM accounts
WHERE name LIKE '%s';

--    All companies whose names start with 'E' and end with 'l'.
SELECT *
FROM accounts
WHERE name LIKE 'E%l';

--    All companies whose names start with "a" and are at least 8 characters in length
SELECT *
FROM accounts
WHERE name LIKE 'A_______%';

--    All companies whose names have "p" in the second position
SELECT *
FROM accounts
WHERE name LIKE '_r%';

--  IN
--    Use the accounts table to find the account name, primary_poc, and sales_rep_id for Walmart, Target, and Nordstrom.
SELECT name,primary_poc,sales_rep_id
FROM accounts
WHERE name IN ('Walmart', 'Target', 'Nordstrom');

--    Use the web_events table to find all information regarding individuals who were contacted via the channel of organic or adwords.
SELECT *
FROM web_events
WHERE channel IN ('organic' , 'adwords');

--  NOT
--    Use the accounts table to find the account name, primary poc, and sales rep id for all stores except Walmart, Target, and Nordstrom.
SELECT name,primary_poc,sales_rep_id
FROM accounts
WHERE name NOT IN ('Walmart', 'Target', 'Nordstrom');

--    Use the web_events table to find all information regarding individuals who were contacted via any method except using organic or adwords methods.
SELECT *
FROM web_events
WHERE channel NOT IN ('organic' , 'adwords');

--  Use the accounts table to find:

--    All the companies whose names do not start with 'C'.
SELECT *
FROM accounts
WHERE name NOT LIKE 'C%';

--    All companies whose names do not contain the string 'one' somewhere in the name.
SELECT *
FROM accounts
WHERE name NOT LIKE '%one%';

--    All companies whose names do not end with 's'.
SELECT *
FROM accounts
WHERE name NOT LIKE '%s';

-- AND , BETWEEN
--    Write a query that returns all the orders where the standard_qty is over 1000, the poster_qty is 0, and the gloss_qty is 0.
SELECT *
FROM orders
WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0;

--    Using the accounts table, find all the companies whose names do not start with 'C' and end with 's'.
SELECT name
FROM accounts
WHERE name NOT LIKE 'C%' AND name LIKE '%s';

--    Write a query that displays the order date and gloss_qty data for all orders where gloss_qty is between 24 and 29.
--    (BETWEEN operator includes the begin and end values)
SELECT occurred_at, gloss_qty
FROM orders
WHERE gloss_qty BETWEEN 24 AND 29;

--    Use the web_events table to find all information regarding individuals who were contacted via the organic or
--    adwords channels, and started their account at any point in 2016, sorted from newest to oldest.
SELECT *
FROM web_events
WHERE channel IN ('organic','adwords') AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01'
ORDER BY occurred_at;