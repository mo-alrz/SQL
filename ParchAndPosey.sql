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

--  OR
--    Find list of orders ids where either gloss_qty or poster_qty is greater than 4000. Only include the id field in the resulting table.
SELECT id
FROM orders
WHERE gloss_qty > 4000 OR poster_qty > 4000;

--    Write a query that returns a list of orders where the standard_qty is zero and either the gloss_qty or poster_qty is over 1000.
SELECT *
FROM orders
WHERE standard_qty = 0 AND (gloss_qty > 1000 OR poster_qty > 1000);

--    Find all the company names that start with a 'C' or 'W', and the primary contact contains 'ana' or 'Ana', but it doesn't contain 'eana'.
SELECT *
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%')
      AND (primary_poc LIKE '%ana%' or primary_poc LIKE '%Ana%')
      AND primary_poc NOT LIKE '%eana%';

--Join (Inner -> Returns rows that appear in both tables,
--      Left -> pulls all the data that exists in both tables, as well as all of the rows from the table in the FROM even if they do not exist in the JOIN statement,
--      Right -> pulls all the data that exists in both tables, as well as all of the rows from the table in the JOIN even if they do not exist in the FROM statement,
--      Full outer -> returns all records when there is a match in left (table1) or right (table2) table records.)
--Try pulling all the data from the accounts table, and all the data from the orders table.
SELECT a.* , o.*
FROM accounts a
JOIN orders o
ON o.account_id = a.id;

--Try pulling standard_qty, gloss_qty, and poster_qty from the orders table, and the website and the primary_poc from the accounts table.
SELECT o.standard_qty, o.gloss_qty, o.poster_qty, a.website, a.primary_poc
FROM accounts a
JOIN orders o
ON o.account_id = a.id;

--Provide a table for all web_events associated with account name of Walmart. There should be three columns. Be sure to
--include the primary_poc, time of the event, and the channel for each event. Additionally, you might choose to add a
--fourth column to assure only Walmart events were chosen.
SELECT a.primary_poc, w.occurred_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
WHERE a.name = 'Walmart';

--Provide a table that provides the region for each sales_rep along with their associated accounts. Your final table
--should include three columns: the region name, the sales rep name, and the account name. Sort the accounts
--alphabetically (A-Z) according to account name.
SELECT r.name region, s.name sales_rep, a.name account
FROM account a
JOIN sales_rep s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
ORDER BY a.name;

--Provide the name for each region for every order, as well as the account name and the unit price they paid
--(total_amt_usd/total) for the order. Your final table should have 3 columns: region name, account name, and unit price.
--A few accounts have 0 for total, so I divided by (total + 0.001) to assure not dividing by zero.
SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.001) unit_price
FROM orders o
JOIN account a
ON a.id = o.account_id
JOIN sales_rep s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id;

--Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for
--the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the
--account name. Sort the accounts alphabetically (A-Z) according to account name.
SELECT r.name region, s.name sales_rep, a.name account
FROM account a
JOIN sales_rep s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
WHERE r.name = 'Midwest'
ORDER BY a.name;

--Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for
--accounts where the sales rep has a first name starting with S and in the Midwest region. Your final table should include
--three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.
SELECT r.name region, s.name sales_rep, a.name account
FROM account a
JOIN sales_rep s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
WHERE s.name LIKE 'S%' AND r.name = 'Midwest'
ORDER BY a.name;

--Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for
--accounts where the sales rep has a last name starting with K and in the Midwest region. Your final table should include
--three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z)
--according to account name.
SELECT r.name region, s.name sales_rep, a.name account
FROM account a
JOIN sales_rep s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
WHERE s.name LIKE '% K%' AND r.name = 'Midwest'
ORDER BY a.name;

--Provide the name for each region for every order, as well as the account name and the unit price they paid
--(total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity
--exceeds 100. Your final table should have 3 columns: region name, account name, and unit price. In order to avoid a
--division by zero error, adding .001 to the denominator here is helpful total_amt_usd/(total+0.001).
SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.001) unit_price
FROM orders o
JOIN account a
ON a.id = o.account_id
JOIN sales_rep s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
WHERE standard_qty > 100;

--Provide the name for each region for every order, as well as the account name and the unit price they paid
--(total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds
-- 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name,
-- and unit price. Sort for the smallest unit price first. In order to avoid a division by zero error, adding .001 to the
-- denominator here is helpful (total_amt_usd/(total+0.01).
SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.001) unit_price
FROM orders o
JOIN account a
ON a.id = o.account_id
JOIN sales_rep s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price;

--Provide the name for each region for every order, as well as the account name and the unit price they paid
--(total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds
-- 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and
-- unit price. Sort for the largest unit price first. In order to avoid a division by zero error, adding .001 to the
-- denominator here is helpful (total_amt_usd/(total+0.01).
SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.001) unit_price
FROM orders o
JOIN account a
ON a.id = o.account_id
JOIN sales_rep s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price DESC;

--What are the different channels used by account id 1001? Your final table should have only 2 columns: account name and
--the different channels. You can try SELECT DISTINCT to narrow down the results to only the unique values.
SELECT DISTINCT a.name, w.channels
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
WHERE a.id = 1001;

--Find all the orders that occurred in 2015. Your final table should have 4 columns: occurred_at, account name, order
--total, and order total_amt_usd.
SELECT a.name, o.occurred_at, o.total, o.total_amt_usd
FROM accounts
JOIN orders
ON a.id = o.account_id
WHERE o.occurred_at BETWEEN '01-01-2015' AND '01-01-2016'
ORDER BY o.occurred_at DESC;

--Union
--The UNION operator is used to combine the result-set of two or more SELECT statements.
--  Every SELECT statement within UNION must have the same number of columns
--  The columns must also have similar data types
--  The columns in every SELECT statement must also be in the same order
SELECT column_name(s) FROM table1
UNION
SELECT column_name(s) FROM table2;

--The UNION operator selects only distinct values by default. To allow duplicate values, use UNION ALL:
SELECT column_name(s) FROM table1
UNION ALL
SELECT column_name(s) FROM table2;

--Aggregations
--Find the total amount of poster_qty paper ordered in the orders table.
SELECT SUM(poster_qty) AS total_poster_sales
FROM orders;

--Find the total amount of standard_qty paper ordered in the orders table.
SELECT SUM(standard_qty) AS total_standard_sales
FROM orders;

--Find the total dollar amount of sales using the total_amt_usd in the orders table.
SELECT SUM(total_amt_usd) AS total_dollar_sales
FROM orders;

--Find the total amount spent on standard_amt_usd and gloss_amt_usd paper for each order in the orders table.
SELECT standard_amt_usd + gloss_amt_usd AS total_standard_gloss
FROM orders;

--Find the standard_amt_usd per unit of standard_qty paper.
SELECT SUM(standard_amt_usd)/SUM(standard_qty) AS standard_price_per_unit
FROM orders;

--When was the earliest order ever placed? You only need to return the date.
SELECT MIN(occurred_at)
FROM orders;

--Try performing the same query as in question 1 without using an aggregation function.
SELECT occurred_at
FROM orders
ORDER BY occurred_at
LIMIT 1;

--When did the most recent (latest) web_event occur?
SELECT MAX(occurred_at)
FROM orders;

--Try to perform the result of the previous query without using an aggregation function.
SELECT occurred_at
FROM orders
ORDER BY occurred_at DESC
LIMIT 1;

--Find the mean (AVERAGE) amount spent per order on each paper type, as well as the mean amount of each paper type
--purchased per order. Your final answer should have 6 values - one for each paper type for the average number of sales,
--as well as the average amount.
SELECT AVG(standard_qty), AVG(gloss_qty), AVG(poster_qty), AVG(standard_amt_usd),AVG(gloss_amt_usd), AVG(poster_amt_usd)
FROM orders;

--Via the video, you might be interested in how to calculate the MEDIAN. Though this is more advanced than what we have
--covered so far try finding - what is the MEDIAN total_usd spent on all orders?
SELECT *
FROM (SELECT total_amt_usd
      FROM orders
      ORDER BY total_amt_usd
      LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;

--Which account (by name) placed the earliest order? Your solution should have the account name and the date of the order.
SELECT a.name, o.occurred_at
FROM accounts a
JOIN orders o
ON a.id = o.account_id
ORDER BY occurred_at
LIMIT 1;

--Find the total sales in usd for each account. You should include two columns - the total sales for each company's orders in usd and the company name.
SELECT a.name, SUM(o.total_amt_usd)
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name;

--Via what channel did the most recent (latest) web_event occur, which account was associated with this web_event?
--Your query should return only three values - the date, channel, and account name.
SELECT w.occurred_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
ORDER BY w.occurred_at DESC
LIMIT 1;

--Find the total number of times each type of channel from the web_events was used. Your final table should have two
--columns - the channel and the number of times the channel was used.
SELECT w.channel, COUNT(*)
FROM web_events w
GROUP BY w.channel;

--Who was the primary contact associated with the earliest web_event?
SELECT a.primary_poc
FROM web_events w
JOIN accounts a
ON a.id = w.account_id
ORDER BY w.occurred_at
LIMIT 1;

--What was the smallest order placed by each account in terms of total usd. Provide only two columns - the account
--name and the total usd. Order from smallest dollar amounts to largest.
SELECT a.name, MIN(o.total_amt_usd) smallest_order
FROM accounts
JOIN orders
ON a.id = o.account_id
GROUP BY a.name
ORDER BY smallest_order;

--Find the number of sales reps in each region. Your final table should have two columns - the region and the number of
--sales_reps. Order from fewest reps to most reps.
SELECT r.name, COUNT(s.id)
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
GROUP BY r.name
ORDER BY num_reps;

--For each account, determine the average amount of each type of paper they purchased across their orders. Your result
--should have four columns - one for the account name and one for the average quantity purchased for each of the paper
--types for each account.
SELECT a.name, AVG(poster_qty),AVG(standard_qty),AVG(gloss_qty)
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name;

--For each account, determine the average amount spent per order on each paper type. Your result should have four columns
--one for the account name and one for the average amount spent on each paper type.
SELECT a.name, AVG(gloss_amt_usd),AVG(standard_amt_usd),AVG(poster_amt_usd)
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name;

--Determine the number of times a particular channel was used in the web_events table for each sales rep. Your final table
--should have three columns - the name of the sales rep, the channel, and the number of occurrences. Order your table
--with the highest number of occurrences first.
SELECT s.name, w.channel, COUNT(*) num_events
FROM web_events w
JOIN accounts a
ON a.id = w.account_id
JOIN sales_reps s
ON a.sales_rep_id = s.id
GROUP BY s.name, w.channel
ORDER BY num_events DESC;

--Determine the number of times a particular channel was used in the web_events table for each region. Your final table
--should have three columns - the region name, the channel, and the number of occurrences. Order your table with the
--highest number of occurrences first.
SELECT r.name, w.channel, COUNT(*) num_events
FROM web_events w
JOIN accounts a
ON a.id = w.account_id
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
GROUP BY s.name, w.channel
ORDER BY num_events DESC;

--Use DISTINCT to test if there are any accounts associated with more than one region.
--The below two queries have the same number of resulting rows (351), so we know that every account is associated with
--only one region. If each account was associated with more than one region, the first query should have returned more
--rows than the second query.
SELECT a.id account_id, a.name account_name, r.id region_id, r.name region_name
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id;

--and

SELECT DISTINCT id, name
FROM accounts;

--Have any sales reps worked on more than one account?
--Actually all of the sales reps have worked on more than one account. The fewest number of accounts any sales rep works
--on is 3. There are 50 sales reps, and they all have more than one account. Using DISTINCT in the second query assures
--that all of the sales reps are accounted for in the first query.
SELECT s.id, s.name, COUNT(*) num_accounts
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
ORDER BY num_accounts;

--and

SELECT DISTINCT id, name
FROM sales_reps;

--Having
--WHERE subsets the returned data based on a logical condition.
--WHERE appears after the FROM, JOIN, and ON clauses, but before GROUP BY.
--HAVING appears after the GROUP BY clause, but before the ORDER BY clause.
--HAVING is like WHERE, but it works on logical statements involving aggregations.
--How many of the sales reps have more than 5 accounts that they manage?
SELECT COUNT(*) num_reps_above5
FROM (SELECT s.id sales_id, COUNT(a.id) acc_num
      FROM accounts a
      JOIN sales_reps s
      ON a.sales_rep_id = s.id
      GROUP BY sales_id
      HAVING COUNT(a.id) > 5
      ORDER BY acc_num) AS table1;

--How many accounts have more than 20 orders?
SELECT a.id acc_id, COUNT(o.id) ord_num
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY acc_id
HAVING COUNT(o.id) > 20
ORDER BY ord_num;

--Which account has the most orders?
SELECT a.id acc_id, COUNT(o.id) ord_num
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY acc_id
ORDER BY COUNT(o.id)DESC
LIMIT 1;

--Which accounts spent more than 30,000 usd total across all orders?
SELECT a.id, SUM(o.total_amt_usd) total_payments
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id
HAVING SUM(o.total_amt_usd) > 30000
ORDER BY total_payments;

--Which accounts spent less than 1,000 usd total across all orders?
SELECT a.id, SUM(o.total_amt_usd) total_payments
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id
HAVING SUM(o.total_amt_usd) < 1000
ORDER BY total_payments;

--Which account has spent the most with us?
SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY total_spent DESC
LIMIT 1;

--Which account has spent the least with us?
SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY total_spent
LIMIT 1;

--Which accounts used facebook as a channel to contact customers more than 6 times?
SELECT a.id, w.channel, COUNT(w.channel) count_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.id,w.channel
HAVING w.channel = 'facebook' AND COUNT(w.channel) > 6
ORDER BY count_of_channel DESC;

--Which account used facebook most as a channel?
SELECT a.id, w.channel, COUNT(w.channel) count_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
WHERE w.channel = 'facebook'
GROUP BY a.id,w.channel
ORDER BY count_of_channel DESC
LIMIT 1;

--Which channel was most frequently used by most accounts?
SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.id, a.name, w.channel
ORDER BY use_of_channel DESC
LIMIT 10;

--Dates and times
--Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least. Do you notice
--any trends in the yearly sales totals?
SELECT SUM(total_amt_usd), DATE_PART('year',occurred_at)
FROM orders
GROUP BY 2
ORDER BY 1 DESC;

--Which month did Parch & Posey have the greatest sales in terms of total dollars? Are all months evenly represented by
--the dataset?
SELECT DATE_PART('month', occurred_at) ord_month, SUM(total_amt_usd) total_spent
FROM orders
WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY 1
ORDER BY 2 DESC;

--Which year did Parch & Posey have the greatest sales in terms of total number of orders? Are all years evenly
--represented by the dataset?
SELECT COUNT(*), DATE_PART('year',occurred_at)
FROM orders
GROUP BY 2
ORDER BY 1 DESC
LIMIT 1;

--Which month did Parch & Posey have the greatest sales in terms of total number of orders? Are all months evenly
--represented by the dataset?
SELECT DATE_PART('month', occurred_at) ord_month, COUNT(*) total_sales
FROM orders
WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY 1
ORDER BY 2 DESC;

--In which month of which year did Walmart spend the most on gloss paper in terms of dollars?
SELECT a.name, SUM(gloss_amt_usd), DATE_TRUNC('month',o.occurred_at)
FROM accounts a
JOIN orders o
ON a.id = o.account_id
WHERE a.name = 'Walmart'
GROUP BY 1,3
ORDER BY 2 DESC
LIMIT 1;

--Case statements
--Write a query to display for each order, the account ID, total amount of the order, and the level of the order -
--‘Large’ or ’Small’ - depending on if the order is $3000 or more, or smaller than $3000.
SELECT account_id, total_amt_usd,
CASE WHEN total_amt_usd >= 3000 THEN 'Large'
     ELSE 'Small' END AS order_level
FROM orders;

--Write a query to display the number of orders in each of three categories, based on the total number of items in each
--order. The three categories are: 'At Least 2000', 'Between 1000 and 2000' and 'Less than 1000'.
SELECT COUNT(id), CASE WHEN total > 2000 THEN 'At Least 2000'
                       WHEN total BETWEEN 1000 and 2000 THEN 'Between 1000 and 2000'
                       ELSE 'Less than 1000' END AS category
FROM orders
GROUP BY 2;

--We would like to understand 3 different levels of customers based on the amount associated with their purchases. The
--top level includes anyone with a Lifetime Value (total sales of all orders) greater than 200,000 usd. The second level
--is between 200,000 and 100,000 usd. The lowest level is anyone under 100,000 usd. Provide a table that includes the
--level associated with each account. You should provide the account name, the total sales of all orders for the customer,
--and the level. Order with the top spending customers listed first.
SELECT a.name, SUM(o.total_amt_usd), CASE WHEN SUM(o.total_amt_usd) > 200000 THEN 'Top'
                                          WHEN SUM(o.total_amt_usd) BETWEEN 100000 AND 200000 THEN 'Middle'
                                          ELSE 'Low' END AS level
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY 1
ORDER BY 2 DESC;

--We would now like to perform a similar calculation to the first, but we want to obtain the total amount spent by
--customers only in 2016 and 2017. Keep the same levels as in the previous question. Order with the top spending customers
--listed first.
SELECT a.name, SUM(o.total_amt_usd), CASE WHEN SUM(o.total_amt_usd) > 200000 THEN 'TOP'
                                          WHEN SUM(o.total_amt_usd) BETWEEN 100000 AND 200000 THEN 'Middle'
                                          ELSE 'Low' END AS level
FROM orders o
JOIN accounts a
ON a.id = o.account_id
WHERE DATE_PART('year',occurred_at) IN (2016,2017)
GROUP BY 1
ORDER BY 2 DESC;

--We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders.
--Create a table with the sales rep name, the total number of orders, and a column with top or not depending on if they
--have more than 200 orders. Place the top sales people first in your final table.
SELECT s.name, COUNT(o.id) orders_number, CASE WHEN COUNT(o.id) > 200 THEN 'Top'
                                               ELSE 'Not' END AS level
FROM orders o
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY 1
ORDER BY 2 DESC;

--The previous did not account for the middle, nor the dollar amount associated with the sales. Management decides they
--want to see these characteristics represented as well. We would like to identify top performing sales reps, which are
--sales reps associated with more than 200 orders or more than 750000 in total sales. The middle group has any rep with
--more than 150 orders or 500000 in sales. Create a table with the sales rep name, the total number of orders, total
--sales across all orders, and a column with top, middle, or low depending on this criteria. Place the top sales people
--based on dollar amount of sales first in your final table. You might see a few upset sales people by this criteria!
SELECT s.name, COUNT(o.id) orders_number, SUM(o.total_amt_usd),
CASE WHEN COUNT(o.id) > 200 OR SUM(o.total_amt_usd) > 750000 THEN 'Top'
     WHEN COUNT(o.id) > 150 OR SUM(o.total_amt_usd) > 500000 THEN 'Middle'
     ELSE 'Low' END AS level
FROM orders o
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY 1
ORDER BY 3 DESC;

--Sub-queries & Temporary Tables
--Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.
SELECT t3.rep_name, t3.region_name, t3.total_amt
  FROM(SELECT region_name, MAX(total_amt) total_amt
         FROM(SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
                FROM sales_reps s
                JOIN accounts a
                  ON a.sales_rep_id = s.id
                JOIN orders o
                  ON o.account_id = a.id
                JOIN region r
                  ON r.id = s.region_id
            GROUP BY 1, 2) t1
         GROUP BY 1) t2
JOIN (SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
        FROM sales_reps s
        JOIN accounts a
          ON a.sales_rep_id = s.id
        JOIN orders o
          ON o.account_id = a.id
        JOIN region r
          ON r.id = s.region_id
    GROUP BY 1,2
    ORDER BY 3 DESC) t3
ON t3.region_name = t2.region_name AND t3.total_amt = t2.total_amt;

--For the region with the largest (sum) of sales total_amt_usd, how many total (count) orders were placed?
SELECT count_orders
     FROM (SELECT r.name, COUNT(o.id) count_orders,SUM(o.total_amt_usd) total_amt_usd
           FROM sales_reps s
           JOIN accounts a
             ON a.sales_rep_id = s.id
           JOIN orders o
             ON o.account_id = a.id
           JOIN region r
             ON r.id = s.region_id
       GROUP BY 1
       ORDER BY 2 DESC
          LIMIT 1) t1;

--How many accounts had more total purchases than the account name which has bought the most standard_qty paper
--throughout their lifetime as a customer?
SELECT COUNT(id)
FROM (SELECT a.id id, SUM(o.total) total
        FROM accounts a
        JOIN orders o
          ON a.id = o.account_id
    GROUP BY 1
      HAVING SUM(o.total) > (SELECT total
                               FROM (SELECT a.name, SUM(o.standard_qty) std_qty, SUM(o.total) total
                                       FROM accounts a
                                       JOIN orders o
                                         ON a.id = o.account_id
                                   GROUP BY 1
                                   ORDER BY 2 DESC
                                      LIMIT 1) t1)
                           ORDER BY 2 desc) t2;

--For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events
--did they have for each channel?
SELECT a.name, w.channel, COUNT(*)
  FROM accounts a
  JOIN web_events w
    ON a.id = w.account_id AND a.id =  (SELECT id
                                          FROM (SELECT a.id, a.name, SUM(o.total_amt_usd) tot_spent
                                                  FROM orders o
                                                  JOIN accounts a
                                                    ON a.id = o.account_id
                                              GROUP BY a.id, a.name
                                              ORDER BY 3 DESC
                                                 LIMIT 1) inner_table)
GROUP BY 1, 2
ORDER BY 3 DESC;

--What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?
SELECT ROUND(AVG (total),2) average
FROM (SELECT a.id id, SUM(o.total_amt_usd) total
        FROM accounts a
        JOIN orders o
          ON a.id = o.account_id
    GROUP BY 1
    ORDER BY 2 DESC
       LIMIT 10) t1;

--What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per
--order, on average, than the average of all orders.
SELECT AVG(avg_amt)
  FROM (SELECT o.account_id, AVG(o.total_amt_usd) avg_amt
          FROM orders o GROUP BY 1 HAVING AVG(o.total_amt_usd) > (SELECT AVG(o.total_amt_usd) avg_all
                                                                    FROM orders o)) temp_table;

--Sub queries using With
--Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.
WITH t1 AS (
     SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
      FROM sales_reps s
      JOIN accounts a
      ON a.sales_rep_id = s.id
      JOIN orders o
      ON o.account_id = a.id
      JOIN region r
      ON r.id = s.region_id
      GROUP BY 1,2
      ORDER BY 3 DESC),
t2 AS (
      SELECT region_name, MAX(total_amt) total_amt
      FROM t1
      GROUP BY 1)
SELECT t1.rep_name, t1.region_name, t1.total_amt
FROM t1
JOIN t2
ON t1.region_name = t2.region_name AND t1.total_amt = t2.total_amt;

--For the region with the largest sales total_amt_usd, how many total orders were placed?
WITH t1 AS (
      SELECT r.name region_name, SUM(o.total_amt_usd) total_amt
      FROM sales_reps s
      JOIN accounts a
      ON a.sales_rep_id = s.id
      JOIN orders o
      ON o.account_id = a.id
      JOIN region r
      ON r.id = s.region_id
      GROUP BY r.name),
t2 AS (
      SELECT MAX(total_amt)
      FROM t1)
SELECT r.name, COUNT(o.total) total_orders
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
JOIN region r
ON r.id = s.region_id
GROUP BY r.name
HAVING SUM(o.total_amt_usd) = (SELECT * FROM t2);

--How many accounts had more total purchases than the account name which has bought the most standard_qty paper
--throughout their lifetime as a customer?
WITH t1 AS (
      SELECT a.name account_name, SUM(o.standard_qty) total_std, SUM(o.total) total
      FROM accounts a
      JOIN orders o
      ON o.account_id = a.id
      GROUP BY 1
      ORDER BY 2 DESC
      LIMIT 1),
t2 AS (
      SELECT a.name
      FROM orders o
      JOIN accounts a
      ON a.id = o.account_id
      GROUP BY 1
      HAVING SUM(o.total) > (SELECT total FROM t1))
SELECT COUNT(*)
FROM t2;

--For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events
--did they have for each channel?
WITH t1 AS (
      SELECT a.id, a.name, SUM(o.total_amt_usd) tot_spent
      FROM orders o
      JOIN accounts a
      ON a.id = o.account_id
      GROUP BY a.id, a.name
      ORDER BY 3 DESC
      LIMIT 1)
SELECT a.name, w.channel, COUNT(*)
FROM accounts a
JOIN web_events w
ON a.id = w.account_id AND a.id =  (SELECT id FROM t1)
GROUP BY 1, 2
ORDER BY 3 DESC;

--What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?
WITH t1 AS (
      SELECT a.id, a.name, SUM(o.total_amt_usd) tot_spent
      FROM orders o
      JOIN accounts a
      ON a.id = o.account_id
      GROUP BY a.id, a.name
      ORDER BY 3 DESC
      LIMIT 10)
SELECT AVG(tot_spent)
FROM t1;

--What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per
--order, on average, than the average of all orders.
WITH t1 AS (
      SELECT AVG(o.total_amt_usd) avg_all
      FROM orders o
      JOIN accounts a
      ON a.id = o.account_id),
     t2 AS (
      SELECT o.account_id, AVG(o.total_amt_usd) avg_amt
      FROM orders o
      GROUP BY 1
      HAVING AVG(o.total_amt_usd) > (SELECT * FROM t1))

SELECT AVG(avg_amt) FROM t2;

--LEFT & RIGHT
--In the accounts table, there is a column holding the website for each company. The last three digits specify what
--type of web address they are using. A list of extensions (and pricing) is provided here. Pull these extensions and
--provide how many of each website type exist in the accounts table.
SELECT RIGHT(website, 3) AS domain, COUNT(*) num_companies
FROM accounts
GROUP BY 1
ORDER BY 2 DESC;

--There is much debate about how much the name (or even the first letter of a company name) matters. Use the accounts
--table to pull the first letter of each company name to see the distribution of company names that begin with each letter
--(or number).
SELECT LEFT(UPPER(name), 1) AS first_letter, COUNT(*) num_companies
FROM accounts
GROUP BY 1
ORDER BY 2 DESC;

--Use the accounts table and a CASE statement to create two groups: one group of company names that start with a number
--and a second group of those company names that start with a letter. What proportion of company names start with a letter?
SELECT SUM(num) nums, SUM(letter) letters
FROM (SELECT name,
             CASE WHEN LEFT(UPPER(name), 1) IN ('0','1','2','3','4','5','6','7','8','9') THEN 1 ELSE 0 END AS num,
             CASE WHEN LEFT(UPPER(name), 1) IN ('0','1','2','3','4','5','6','7','8','9') THEN 0 ELSE 1 END AS letter
      FROM accounts) t1;

--Consider vowels as a, e, i, o, and u. What proportion of company names start with a vowel, and what percent start with
--anything else?
SELECT SUM(vowels) vowels, SUM(other) other
FROM (SELECT name,
             CASE WHEN LEFT(UPPER(name), 1) IN ('A','E','I','O','U') THEN 1 ELSE 0 END AS vowels,
             CASE WHEN LEFT(UPPER(name), 1) IN ('A','E','I','O','U') THEN 0 ELSE 1 END AS other
      FROM accounts) t1;

--POSITION, STRPOS, & SUBSTR -> POSITION(',' IN city_state), STRPOS(city_state, ',')
--Use the accounts table to create first and last name columns that hold the first and last names for the primary_poc.
SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ') -1 ) first_name,
       RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name
FROM accounts;

--Now see if you can do the same thing for every rep name in the sales_reps table. Again provide first and last name columns.
SELECT LEFT(name, STRPOS(name, ' ') -1 ) first_name,
       RIGHT(name, LENGTH(name) - STRPOS(name, ' ')) last_name
FROM sales_reps;

--Concat
--Each company in the accounts table wants to create an email address for each primary_poc. The email address should be
--the first name of the primary_poc . last name primary_poc @ company name .com.
SELECT LOWER(first_name) || . ||
       LOWER(last_name) || '@' ||
       LOWER(REPLACE(company, ' ', '')) || '.com'
FROM(  SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ') -1 ) first_name,
              RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name ,
              name company
       FROM accounts) t1;

--We would also like to create an initial password, which they will change after their first log in. The first password
--will be the first letter of the primary_poc's first name (lowercase), then the last letter of their first name
--(lowercase), the first letter of their last name (lowercase), the last letter of their last name (lowercase), the number
--of letters in their first name, the number of letters in their last name, and then the name of the company they are
--working with, all capitalized with no spaces.
SELECT first_name, last_name, company,
       LOWER(LEFT(first_name,1)) ||
       LOWER(RIGHT(first_name,1)) ||
       LOWER(LEFT(last_name,1)) ||
       LOWER(RIGHT(last_name,1)) ||
       LENGTH(first_name) ||
       LENGTH(last_name) ||
       UPPER(REPLACE(company,' ',''))
FROM ( SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ') -1 ) first_name,
              RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name,
              name company
       FROM accounts) t1;

--CAST
--SELECT date orig_date, (SUBSTR(date, 7, 4) || '-' || LEFT(date, 2) || '-' || SUBSTR(date, 4, 2))::DATE new_date
--FROM sf_crime_data;

--COALESCE
--Run the query entered below in the SQL workspace to notice the row with missing data.
SELECT *
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;

--Use COALESCE to fill in the accounts.id column with the order.id for the NULL value for the table in 1.
SELECT COALESCE(o.id,a.id) as filled_id, a.name, a.website, a.lat, a.long, a.primary_poc, a.sales_rep_id, o.*
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;

--Use COALESCE to fill in the orders. account id column with the account. id for the NULL value for the table in 1.
SELECT COALESCE(o.id,a.id) filled_id, a.name, a.website, a.lat, a.long, a.primary_poc, a.sales_rep_id,
       COALESCE(o.account_id,a.id) account_id, o.occurred_at, o.standard_qty, o.gloss_qty, o.poster_qty, o.total,
       o.standard_amt_usd, o.gloss_amt_usd, o.poster_amt_usd, o.total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;

--Use COALESCE to fill in each of the qty and usd columns with 0 for the table in 1.
SELECT COALESCE(o.id, a.id) filled_id, a.name, a.website, a.lat, a.long, a.primary_poc, a.sales_rep_id,
       COALESCE(o.account_id, a.id) account_id, o.occurred_at, COALESCE(o.standard_qty, 0) standard_qty,
       COALESCE(o.gloss_qty,0) gloss_qty, COALESCE(o.poster_qty,0) poster_qty, COALESCE(o.total,0) total,
       COALESCE(o.standard_amt_usd,0) standard_amt_usd, COALESCE(o.gloss_amt_usd,0) gloss_amt_usd, COALESCE(o.poster_amt_usd,0) poster_amt_usd,
       COALESCE(o.total_amt_usd,0) total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;

--run the query in 1 with the WHERE removed and COUNT the number of id s
SELECT COUNT(*)
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id;

--run the query in 5 but with the COALESCE function used in questions 2 through 4.
SELECT COALESCE(o.id, a.id) filled_id, a.name, a.website, a.lat, a.long, a.primary_poc, a.sales_rep_id,
       COALESCE(o.account_id, a.id) account_id, o.occurred_at, COALESCE(o.standard_qty, 0) standard_qty,
       COALESCE(o.gloss_qty,0) gloss_qty, COALESCE(o.poster_qty,0) poster_qty, COALESCE(o.total,0) total,
       COALESCE(o.standard_amt_usd,0) standard_amt_usd, COALESCE(o.gloss_amt_usd,0) gloss_amt_usd,
       COALESCE(o.poster_amt_usd,0) poster_amt_usd, COALESCE(o.total_amt_usd,0) total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id;

--WINDOW functions
--Divide the accounts into 4 levels in terms of the amount of standard_qty for their orders. Your resulting table should
--have the account_id, the occurred_at time for each order, the total amount of standard_qty paper purchased, and one of
--four levels in a standard_quartile column.
SELECT account_id,
       occurred_at,
       standard_qty,
       NTILE(4) OVER (PARTITION BY account_id ORDER BY standard_qty) AS standard_quartile
  FROM orders
 ORDER BY account_id DESC;

--Divide the accounts into two levels in terms of the amount of gloss_qty for their orders. Your resulting table should
--have the account_id, the occurred_at time for each order, the total amount of gloss_qty paper purchased, and one of
--two levels in a gloss_half column.
SELECT account_id,
       occurred_at,
       gloss_qty,
       NTILE(2) OVER (PARTITION BY account_id ORDER BY gloss_qty) AS gloss_half
  FROM orders
 ORDER BY account_id DESC;

--Divide the orders for each account into 100 levels in terms of the amount of total_amt_usd for their orders. Your
--resulting table should have the account_id, the occurred_at time for each order, the total amount of total_amt_usd paper
--purchased, and one of 100 levels in a total_percentile column.
SELECT account_id,
       occurred_at,
       total_amt_usd,
       NTILE(100) OVER (PARTITION BY account_id ORDER BY total_amt_usd) AS total_percentile
  FROM orders
 ORDER BY account_id DESC;


