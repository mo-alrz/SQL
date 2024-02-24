INSERT INTO table_name (clname1, clname2, ...)
VALUES (val1, val2, ...);

UPDATE table_name
SET clname1='val1', clname2='val2'
WHERE condition;

DELETE FROM table_name (Delete entire row)
WHERE condition;

-- Top For MySQL
SELECT column_name(s)
FROM table_name
WHERE condition
LIMIT number;

-- Top For Oracle
SELECT column_name(s)
FROM table_name
WHERE ROWNUM <= number;

-- LIKE
-- Starts with the letter "La"
SELECT * FROM Customers
WHERE CustomerName LIKE 'La%';

-- Starts with 'L' followed by one wildcard character, then 'nd' and then two wildcard characters
SELECT * FROM Customers
WHERE CustomerName LIKE "L_nd__";

-- All customers from a city that contains the letter 'L'
SELECT * FROM Customers
WHERE CustomerName LIKE "%L%"

-- Ends with 'a'
SELECT * FROM Customers
WHERE CustomerName LIKE "%a"

-- Starts with "b" and ends with "s"
SELECT * FROM Customers
WHERE CustomerName LIKE "b%s"

-- Starts with "a" and is at least 3 characters in length
SELECT * FROM Customers
WHERE CustomerName LIKE "a__%";

-- 'r' in the second position
SELECT * FROM Customers
WHERE CustomerName LIKE "_r%";

--Wildcards:
--%  Represents zero or more characters
--_  Represents a single character
--[] Represents any single character within the brackets
--^  Represents any character not in the brackets
---  Represents any single character within the specified range
--{} Represents any escaped character


-- all customers starting with either "b", "s", or "p"
SELECT * FROM Customers
WHERE CustomerName LIKE '[bsp]%';

-- all customers starting with "a", "b", "c", "d", "e" or "f"
SELECT * FROM Customers
WHERE CustomerName LIKE '[a-f]%';

-- Union
-- The UNION operator is used to combine the result set of two or more SELECT statements.
--   - Every SELECT statement within UNION must have the same number of columns
--   - The columns must also have similar data types
--   - The columns in every SELECT statement must also be in the same order

-- The following SQL statement returns the cities (only distinct values) from both the "Customers" and the "Suppliers" table:
SELECT City FROM Customers
UNION
SELECT City FROM Suppliers
ORDER BY City;

-- If some customers or suppliers have the same city, each city will only be listed once, because UNION selects only
-- distinct values. Use UNION ALL to also select duplicate values!
SELECT City FROM Customers
UNION ALL
SELECT City FROM Suppliers
ORDER BY City;

-- HAVING
-- The HAVING clause was added to SQL because the WHERE keyword cannot be used with aggregate functions.
SELECT column_name(s)
FROM table_name
WHERE condition
GROUP BY column_name(s)
HAVING condition
ORDER BY column_name(s);

-- Any, All
-- The ANY operator:
--    returns a boolean value as a result
--    returns TRUE if ANY of the subquery values meet the condition
-- ANY means that the condition will be true if the operation is true for any of the values in the range.

-- The ALL operator:
--    returns a boolean value as a result
--    returns TRUE if ALL of the subquery values meet the condition
--    is used with SELECT, WHERE, and HAVING statements
-- ALL means that the condition will be true only if the operation is true for all values in the range.

--Select Into
SELECT *
INTO new_table [IN externaldb]
FROM old_table
WHERE condition;

SELECT * INTO CustomersBackup2017 IN 'Backup.mdb'
FROM Customers;

-- Insert Into
-- The INSERT INTO SELECT statement copies data from one table and inserts it into another table.
-- The INSERT INTO SELECT statement requires that the data types in source and target tables match. (The existing
-- records in the target table are unaffected.)

INSERT INTO table2 (column1, column2, column3, ...)
SELECT column1, column2, column3, ...
FROM table1
WHERE condition;

-- Copy "Suppliers" into "Customers" (the columns that are not filled with data, will contain NULL):
INSERT INTO Customers (CustomerName, City, Country)
SELECT SupplierName, City, Country FROM Suppliers;

-- Copy "Suppliers" into "Customers" (fill all columns):
INSERT INTO Customers (CustomerName, ContactName, Address, City, PostalCode, Country)
SELECT SupplierName, ContactName, Address, City, PostalCode, Country FROM Suppliers;

-- Copy only the German suppliers into "Customers":
INSERT INTO Customers (CustomerName, City, Country)
SELECT SupplierName, City, Country FROM Suppliers
WHERE Country='Germany';

-- IFNULL(), NVL()
-- MySQL
-- The MySQL IFNULL() function lets you return an alternative value if an expression is NULL:
SELECT ProductName, UnitPrice * (UnitsInStock + IFNULL(UnitsOnOrder, 0))
FROM Products;

-- Oracle
SELECT ProductName, UnitPrice * (UnitsInStock + NVL(UnitsOnOrder, 0))
FROM Products;

-- or we can use the COALESCE() function, like this:
SELECT ProductName, UnitPrice * (UnitsInStock + COALESCE(UnitsOnOrder, 0))
FROM Products;

-- Stored Procedures
-- A stored procedure is a prepared SQL code that you can save, so the code can be reused over and over again. So if you
-- have an SQL query that you write over and over again, save it as a stored procedure, and then just call it to execute it.
-- You can also pass parameters to a stored procedure so that the stored procedure can act based on the parameter value(s)
-- that is passed.

-- Store:
CREATE PROCEDURE procedure_name
AS
sql_statement
GO;

-- Execute:
EXEC procedure_name;

-- Setting up multiple parameters is very easy. Just list each parameter and the data type separated by a comma as shown
-- below. The following SQL statement creates a stored procedure that selects Customers from a particular City with a
-- particular PostalCode from the "Customers" table:

-- Store:
CREATE PROCEDURE SelectAllCustomers @City nvarchar(30), @PostalCode nvarchar(10)
AS
SELECT * FROM Customers WHERE City = @City AND PostalCode = @PostalCode
GO;

-- Execute:
EXEC SelectAllCustomers @City = 'London', @PostalCode = 'WA1 1DP';

-- Comment
-- Single line --
-- Multiline /* */

-- SQL DATABASE

CREATE DATABASE dbname;

DROP DATABASE dbname;

BACKUP DATABASE dbname
TO DISK = 'file_path'

-- A differential backup only backs up the parts of the database that have changed since the last full database backup.

WITH DIFFERENTIAL;

CREATE TABLE table_name (
	cl1 datatype,
	cl2 datatype,
	cl3 datatype,
	...
) ;

-- A copy of an existing table can also be created using CREATE TABLE.

CREATE TABLE new_table_name AS
    SELECT column1, column2,...
    FROM existing_table_name
    WHERE ....;

DROP TABLE table_name;

ALTER TABLE table_name
ADD column_name datatype;

-- The ALTER TABLE statement is used to add, delete, or modify columns in an existing table.
-- The ALTER TABLE statement is also used to add and drop various constraints on an existing table.

ALTER TABLE Customers
DROP COLUMN Email;

-- Deletes the "Email" column from the "Customers" table

ALTER TABLE Customers
RENAME COLUMN 'Email' TO 'E-mail'

-- Renames the "Email" column from the "Email" to "E-mail"

ALTER TABLE table_name
MODIFY COLUMN column_name datatype;

-- Changes the data type of a column in a table

CREATE TABLE table_name (
    column1 datatype constraint,
    column2 datatype constraint,
    column3 datatype constraint,
    ....
);

-- Constraints can be specified when the table is created with the CREATE TABLE statement, or after the table is created with the ALTER TABLE statement.

NOT NULL - Ensures that a column cannot have a NULL value

CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255) NOT NULL,
    Age int
);

ALTER TABLE Persons
MODIFY COLUMN Age int NOT NULL;

-- UNIQUE - Ensures that all values in a column are different
-- The UNIQUE constraint ensures that all values in a column are different.
-- Both the UNIQUE and PRIMARY KEY constraints provide a guarantee for uniqueness for a column or set of columns. A PRIMARY
-- KEY constraint automatically has a UNIQUE constraint.

-- SQL Server / Oracle / MS Access:
CREATE TABLE Persons (
    ID int NOT NULL UNIQUE,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int
);

-- MySQL:
CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    UNIQUE (ID)
);

-- To name a UNIQUE constraint, and to define a UNIQUE constraint on multiple columns, use the following SQL syntax:

--MyS QL / SQL Server / Oracle / MS Access:
CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    CONSTRAINT UC_Person UNIQUE (ID,LastName)
);

-- However, you can have many UNIQUE constraints per table, but only one PRIMARY KEY constraint per table.

-- To create a UNIQUE constraint on the "ID" column when the table is already created, use the following SQL:

-- MySQL / SQL Server / Oracle / MS Access:
ALTER TABLE Persons
ADD UNIQUE (ID);

-- To name a UNIQUE constraint, and to define a UNIQUE constraint on multiple columns, use the following SQL syntax:

MySQL / SQL Server / Oracle / MS Access:
ALTER TABLE Persons
ADD CONSTRAINT UC_Person UNIQUE (ID,LastName);

-- DROP a UNIQUE Constraint
-- To drop a UNIQUE constraint, use the following SQL:

-- MySQL:
ALTER TABLE Persons
DROP INDEX UC_Person;

-- SQL Server / Oracle / MS Access:
ALTER TABLE Persons
DROP CONSTRAINT UC_Person;

-- PRIMARY KEY - A combination of a NOT NULL and UNIQUE. Uniquely identifies each row in a table

-- MySQL:
CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    PRIMARY KEY (ID)
);

-- SQL Server / Oracle / MS Access:
CREATE TABLE Persons (
    ID int NOT NULL PRIMARY KEY,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int
);

-- To allow naming of a PRIMARY KEY constraint, and for defining a PRIMARY KEY constraint on multiple columns, use the following SQL syntax:

-- MySQL / SQL Server / Oracle / MS Access:
CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    CONSTRAINT PK_Person PRIMARY KEY (ID,LastName)
);

-- To create a PRIMARY KEY constraint on the "ID" column when the table is already created, use the following SQL:

-- MyS QL / SQL Server / Oracle / MS Access:
ALTER TABLE Persons
ADD PRIMARY KEY (ID);

-- To allow naming of a PRIMARY KEY constraint, and for defining a PRIMARY KEY constraint on multiple columns, use the following SQL syntax:

-- MyS QL / SQL Server / Oracle / MS Access:
ALTER TABLE Persons
ADD CONSTRAINT PK_Person PRIMARY KEY (ID,LastName);

-- To drop a PRIMARY KEY constraint, use the following SQL:

-- MySQL:
ALTER TABLE Persons
DROP PRIMARY KEY;

-- SQL Server / Oracle / MS Access:
ALTER TABLE Persons
DROP CONSTRAINT PK_Person;

-- FOREIGN KEY - Prevents actions that would destroy links between tables
-- The table with the foreign key is called the child table, and the table with the primary key is called the referenced or parent table.

-- MySQL:
CREATE TABLE Orders (
    OrderID int NOT NULL,
    OrderNumber int NOT NULL,
    PersonID int,
    PRIMARY KEY (OrderID),
    FOREIGN KEY (PersonID) REFERENCES Persons(PersonID)
);

-- SQL Server / Oracle / MS Access:
CREATE TABLE Orders (
    OrderID int NOT NULL PRIMARY KEY,
    OrderNumber int NOT NULL,
    PersonID int FOREIGN KEY REFERENCES Persons(PersonID)
);

-- Multiple Column
-- MySQL / SQL Server / Oracle / MS Access:
CREATE TABLE Orders (
    OrderID int NOT NULL,
    OrderNumber int NOT NULL,
    PersonID int,
    PRIMARY KEY (OrderID),
    CONSTRAINT FK_PersonOrder FOREIGN KEY (PersonID)
    REFERENCES Persons(PersonID)
);

-- To create a FOREIGN KEY constraint on the "PersonID" column when the "Orders" table is already created, use the following SQL:

-- MySQL / SQL Server / Oracle / MS Access:
ALTER TABLE Orders
ADD FOREIGN KEY (PersonID) REFERENCES Persons(PersonID);

-- To allow naming of a FOREIGN KEY constraint, and for defining a FOREIGN KEY constraint on multiple columns, use the following SQL syntax:

-- MySQL / SQL Server / Oracle / MS Access:
ALTER TABLE Orders
ADD CONSTRAINT FK_PersonOrder
FOREIGN KEY (PersonID) REFERENCES Persons(PersonID);
DROP a FOREIGN KEY Constraint

-- To drop a FOREIGN KEY constraint, use the following SQL:

-- MySQL:
ALTER TABLE Orders
DROP FOREIGN KEY FK_PersonOrder;

-- SQL Server / Oracle / MS Access:
ALTER TABLE Orders
DROP CONSTRAINT FK_PersonOrder;

-- CHECK - Ensures that the values in a column satisfy a specific condition

-- MySQL:
CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    CHECK (Age>=18)
);

-- SQL Server / Oracle / MS Access:
CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int CHECK (Age>=18)
);

-- MySQL / SQL Server / Oracle / MS Access:
CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    City varchar(255),
    CONSTRAINT CHK_Person CHECK (Age>=18 AND City='Sandnes')
);

-- SQL CHECK on ALTER TABLE
-- To create a CHECK constraint on the "Age" column when the table is already created, use the following SQL:

-- MySQL / SQL Server / Oracle / MS Access:
ALTER TABLE Persons
ADD CHECK (Age>=18);

-- To allow naming of a CHECK constraint, and for defining a CHECK constraint on multiple columns, use the following SQL syntax:

-- MySQL / SQL Server / Oracle / MS Access:
ALTER TABLE Persons
ADD CONSTRAINT CHK_PersonAge CHECK (Age>=18 AND City='Sandnes');
DROP a CHECK Constraint

-- To drop a CHECK constraint, use the following SQL:

-- SQL Server / Oracle / MS Access:
ALTER TABLE Persons
DROP CONSTRAINT CHK_PersonAge;

-- MySQL:
ALTER TABLE Persons
DROP CHECK CHK_PersonAge;

-- DEFAULT - Sets a default value for a column if no value is specified

-- My SQL / SQL Server / Oracle / MS Access:
CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    City varchar(255) DEFAULT 'Sandnes'
);

-- The DEFAULT constraint can also be used to insert system values, by using functions like GETDATE():
CREATE TABLE Orders (
    ID int NOT NULL,
    OrderNumber int NOT NULL,
    OrderDate date DEFAULT GETDATE()
);
SQL DEFAULT on ALTER TABLE

-- To create a DEFAULT constraint on the "City" column when the table is already created, use the following SQL:

-- MySQL:
ALTER TABLE Persons
ALTER City SET DEFAULT 'Sandnes';

-- SQL Server:
ALTER TABLE Persons
ADD CONSTRAINT df_City
DEFAULT 'Sandnes' FOR City;

-- MS Access:
ALTER TABLE Persons
ALTER COLUMN City SET DEFAULT 'Sandnes';

-- Oracle:
ALTER TABLE Persons
MODIFY City DEFAULT 'Sandnes';
DROP a DEFAULT Constraint

-- To drop a DEFAULT constraint, use the following SQL:

-- MySQL:
ALTER TABLE Persons
ALTER City DROP DEFAULT;

-- SQL Server / Oracle / MS Access:
ALTER TABLE Persons
ALTER COLUMN City DROP DEFAULT;

-- SQL Server:
ALTER TABLE Persons
ALTER COLUMN City DROP DEFAULT;

-- CREATE INDEX - Used to create and retrieve data from the database very quickly

-- Creates an index on a table. Duplicate values are allowed:
CREATE INDEX index_name
ON table_name (column1, column2, ...);
CREATE UNIQUE INDEX Syntax

-- Creates a unique index on a table. Duplicate values are not allowed:
CREATE UNIQUE INDEX index_name
ON table_name (column1, column2, ...);

-- MS Access:
DROP INDEX index_name ON table_name;

-- SQL Server:
DROP INDEX table_name.index_name;

-- DB2/Oracle:
DROP INDEX index_name;

-- MySQL:
ALTER TABLE table_name
DROP INDEX index_name;

-- Auto Increment
-- Auto-increment allows a unique number to be generated automatically when a new record is inserted into a table.
-- Often this is the primary key field that we would like to be created automatically every time a new record is inserted.

-- Syntax for MySQL:
CREATE TABLE Persons (
    Personid int NOT NULL AUTO_INCREMENT,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    PRIMARY KEY (Personid)
);

-- By default, the starting value for AUTO_INCREMENT is 1, and it will increment by 1 for each new record.
-- To let the AUTO_INCREMENT sequence start with another value, use the following SQL statement:
ALTER TABLE Persons AUTO_INCREMENT=100;

-- To insert a new record into the "Persons" table, we will NOT have to specify a value for the "Personid" column (a unique value will be added automatically):
INSERT INTO Persons (FirstName,LastName)
VALUES ('Lars', 'Monsen');

-- Dates
-- MySQL comes with the following data types for storing a date or a date/time value in the database:

    DATE - format YYYY-MM-DD
    DATETIME - format: YYYY-MM-DD HH:MI:SS
    TIMESTAMP - format: YYYY-MM-DD HH:MI:SS
    YEAR - format YYYY or YY

-- Create Views
-- In SQL, a view is a virtual table based on the result-set of an SQL statement.
-- A view contains rows and columns, just like a real table. The fields in a view are fields from one or more real tables in the database.
-- You can add SQL statements and functions to a view and present the data as if the data were coming from one single table.
-- A view is created with the CREATE VIEW statement.

CREATE VIEW [Brazil Customers] AS
SELECT CustomerName, ContactName
FROM Customers
WHERE Country = 'Brazil';

-- We can query the view above as follows:

SELECT * FROM [Brazil Customers];

-- A view can be updated with the CREATE OR REPLACE VIEW statement.
-- SQL CREATE OR REPLACE VIEW Syntax:

CREATE OR REPLACE VIEW view_name AS
SELECT column1, column2, ...
FROM table_name
WHERE condition;

-- The following SQL adds the "City" column to the "Brazil Customers" view:

CREATE OR REPLACE VIEW [Brazil Customers] AS
SELECT CustomerName, ContactName, City
FROM Customers
WHERE Country = 'Brazil';
SQL Dropping a View

-- A view is deleted with the DROP VIEW statement.
SQL DROP VIEW Syntax
DROP VIEW view_name;

-- The following SQL drops the "Brazil Customers" view:
-- Example
DROP VIEW [Brazil Customers];


-- SQL Injection
-- SQL injection is a code injection technique that might destroy your database.
-- SQL injection is one of the most common web hacking techniques.
-- SQL injection is the placement of malicious code in SQL statements, via web page input.

-- Save Query Result to CSV
SELECT column1, column2, ...
INTO OUTFILE '/path/to/your/file.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM your_table
WHERE your_condition;





