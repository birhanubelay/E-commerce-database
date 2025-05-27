--create TABLE commerce_platform.employee_table(
--employee_id SERIAL primary key,
--first_name VARCHAR(15) not null,
--last_name VARCHAR(15) not null,
--gender VARCHAR(15) not null,
--department VARCHAR(50) not null,
--hire_date Date not null,
--salary DECIMAL(10,2) not null
--);
--insert INTO commerce_platform.employee_table(first_name,last_name,gender,department,hire_date,salary)
--VALUES('John','Doe','Male','IT','2028-05-01',60000.00),
--      ('Jane','Smith','Female','HR','2019-06-15',50000.00),
--      ('Michael','Johnson','Male','Finance','2017-03-10',75000.00),
--      ('Emily','Davis','Female','IT','2020-11-20',70000.00),
--      ('Sarah','Brown','Female','Marketing','2016-07-30',45000.00),
--      ('David','Wilson','Male','Sales','2019-01-05',55000.00),
--      ('Chris','Taylor','Male','IT','2022-02-25',65000.00);
--
--
--
--create table commerce_platform.products_table(
--product_id SERIAL primary key,
--product_name varchar(20),
--category varchar(25),
--price decimal(10,2),
--stock int
--);
--insert into commerce_platform.products_table (product_name,category,price,stock)
--values('Laptop','Electronics',1200.00,30),
--('Desk','Furniture',300.00,50),
--('Chair','Furniture',150.00,200),
--('Smartphone','Electronics',800.00,75),
--('Monitor','Electronics',250.00,40),
--('Bookshelf','Furniture',100.00,60),
--('Printer','Electronics',200.00,25);
--
--
--create table commerce_platform.sales_table (
--    sale_id SERIAL primary key,
--    product_id SERIAL references commerce_platform.products_table(product_id),
--    employee_id SERIAL references commerce_platform.employee_table(employee_id),
--    sale_date date,
--    quantity int,
--    total decimal(10,2)
--);

--insert into commerce_platform.sales_table(product_id,employee_id,sale_date, quantity, total)
--VALUES
--(1, 1, '2021-01-15', 2, 2400.00),
--(2, 2, '2021-03-22', 1, 300.00),
--(3, 3, '2021-05-10', 4, 600.00),
--(4, 4, '2021-07-18', 3, 2400.00),
--(5, 5, '2021-09-25', 2, 500.00),
--(6, 6, '2021-11-30', 1, 100.00),
--(7, 1, '2022-02-15', 1, 200.00),
--(1, 2, '2022-04-10', 1, 1200.00),
--(2, 3, '2022-06-20', 2, 600.00),
--(3, 4, '2022-08-05', 3, 450.00),
--(4, 5, '2022-10-11', 1, 800.00),
--(5, 6, '2022-12-29', 4, 1000.00);

--1
 SELECT  *
FROM  commerce_platform.employee_table;

--2
 SELECT first_name AS name
FROM commerce_platform.employee_table;

--3
SELECT DISTINCT department FROM commerce_platform.employee_table;

--4
SELECT COUNT(*) AS total_employees FROM commerce_platform.employee_table;

--5 
SELECT SUM(salary) AS total_salary FROM commerce_platform.employee_table;

--6
SELECT AVG(salary) AS average_salary FROM commerce_platform.employee_table;

--7
SELECT MAX(salary) AS highest_salary FROM commerce_platform.employee_table;

--8
SELECT MIN(salary) AS lowest_salary FROM commerce_platform.employee_table;

--9
SELECT COUNT(*) AS total_male_employees FROM commerce_platform.employee_table WHERE gender = 'Male';

--10
SELECT COUNT(*) AS total_female_employees FROM commerce_platform.employee_table WHERE gender = 'Female';

--11
SELECT COUNT(*) AS hired_in_2020 FROM commerce_platform.employee_table
WHERE EXTRACT(YEAR FROM hire_date) = 2020;

--12
SELECT AVG(salary) AS average_salary_it FROM commerce_platform.employee_table
WHERE department = 'IT';

--13
SELECT department, COUNT(department) AS num_employees
FROM commerce_platform.employee_table
GROUP BY department;

--14
SELECT department, SUM(salary) AS total_salary
FROM commerce_platform.employee_table
GROUP BY department;

--15
SELECT department, MAX(salary) AS max_salary
FROM commerce_platform.employee_table
GROUP BY department;

--16
SELECT department, MIN(salary) AS min_salary
FROM commerce_platform.employee_table
GROUP BY department;

--17
SELECT gender, COUNT(gender) AS total_employees
FROM commerce_platform.employee_table
GROUP BY gender;

--18
SELECT gender, AVG(salary) AS average_salary
FROM commerce_platform.employee_table
GROUP BY gender;

--19
SELECT * FROM commerce_platform.employee_table
ORDER BY salary DESC
LIMIT 5;

--20
SELECT COUNT(DISTINCT first_name) AS unique_first_names
FROM commerce_platform.employee_table;

--21
SELECT employees.*, sales.*
FROM commerce_platform.employee_table employees
LEFT JOIN commerce_platform.sales_table sales
ON employees.employee_id = sales.employee_id;

--22
SELECT *
FROM commerce_platform.employee_table
ORDER BY hire_date
LIMIT 10;

--23
SELECT *
FROM commerce_platform.employee_table employees
LEFT JOIN commerce_platform.sales_table sales
ON employees.employee_id = sales.employee_id
WHERE sales.sale_id IS NULL;

--24
SELECT employees.employee_id,employees.first_name,employees.last_name, COUNT(sales.sale_id) AS total_sales
FROM commerce_platform.employee_table employees
LEFT JOIN commerce_platform.sales_table sales
ON employees.employee_id = sales.employee_id
GROUP BY employees.employee_id,employees.first_name,employees.last_name;

--25
SELECT employee.employee_id,employee.first_name,employee.last_name, SUM(sales.total) AS total_sales
FROM commerce_platform.employee_table employee
JOIN commerce_platform.sales_table sales
ON employee.employee_id = sales.employee_id
GROUP BY employee.employee_id,employee.first_name,employee.last_name
ORDER BY total_sales DESC
LIMIT 1;

--26
SELECT employees.department, AVG(sales.quantity) AS average_quantity
FROM commerce_platform.employee_table employees
JOIN commerce_platform.sales_table sales
ON employees.employee_id = sales.employee_id
GROUP BY employees.department;

--27
SELECT employees.employee_id, employees.first_name, employees.last_name, SUM(sales.total) AS total_sales_2021
FROM commerce_platform.employee_table employees
JOIN commerce_platform.sales_table sales
ON employees.employee_id = sales.employee_id
WHERE EXTRACT(YEAR FROM sales.sale_date) = 2021
GROUP BY employees.employee_id, employees.first_name, employees.last_name;

--28
SELECT employees.employee_id, employees.first_name, employees.last_name, SUM(sales.quantity) AS total_quantity
FROM commerce_platform.employee_table employees
JOIN commerce_platform.sales_table sales
ON employees.employee_id = sales.employee_id
GROUP BY employees.employee_id, employees.first_name, employees.last_name
ORDER BY total_quantity DESC
LIMIT 3;

--29
SELECT employees.department, SUM(sales.quantity) AS total_quantity
FROM commerce_platform.employee_table employees
JOIN commerce_platform.sales_table sales
ON employees.employee_id = sales.employee_id
GROUP BY employees.department;

--30
SELECT product.category, SUM(sales.total) AS total_revenue
FROM commerce_platform.sales_table sales
JOIN commerce_platform.products_table product
ON sales.product_id = product.product_id
GROUP BY product.category;




       


