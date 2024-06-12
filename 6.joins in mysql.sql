-- Joins
-- is used to combine two or more tables together if they have a similar column, even if the names are different but the data must be same

SELECT * FROM parks_and_recreation.employee_demographics;
SELECT * FROM parks_and_recreation.employee_salary;
-- using the two tables because the column employee_id is same

-- INNER JOIN  used to join all the similar rows from the first table to the rows in the second table
SELECT * 
FROM parks_and_recreation.employee_demographics
INNER JOIN parks_and_recreation.employee_salary 
	ON parks_and_recreation.employee_demographics.employee_id = parks_and_recreation.employee_salary.employee_id
;  -- join the employee_salary to the employee_demographics table and use the employee_id column to include the rows that are joined

-- you can use aliasing to reduce the length of the code because the one produced is too long
SELECT * 
FROM parks_and_recreation.employee_demographics as dem
INNER JOIN parks_and_recreation.employee_salary as sal
	ON dem.employee_id = sal.employee_id
; -- still produces the results as the one in the original code running

-- selecting specific columns using the inner join
SELECT dem.employee_id, age, salary
FROM parks_and_recreation.employee_demographics as dem
INNER JOIN parks_and_recreation.employee_salary as sal
	ON dem.employee_id = sal.employee_id
;
-- Outer Joins  has two different types, left joins and the right joins
-- left join takes everything from the left table, and only the matches from the right table
-- right join takes everything from the right table, and only the matches from the left table

SELECT * 
FROM parks_and_recreation.employee_demographics as dem
LEFT JOIN parks_and_recreation.employee_salary as sal
	ON dem.employee_id = sal.employee_id
; -- THE dem table did not have a emp_id with number2 hence in the outcome there is no number 2. it takes everything fom the dem table

SELECT * 
FROM parks_and_recreation.employee_demographics as dem
RIGHT JOIN parks_and_recreation.employee_salary as sal
	ON dem.employee_id = sal.employee_id
; -- everything from the sal table and only matches from the dem table

-- SELF JOIN  is where you join the table to itself
SELECT *
from parks_and_recreation.employee_salary as emp1
JOIN parks_and_recreation.employee_salary as emp2
ON emp1.employee_id = emp2.employee_id
;
-- assigning the first employee to the next employee is done through
SELECT *
from parks_and_recreation.employee_salary as emp1
JOIN parks_and_recreation.employee_salary as emp2
ON emp1.employee_id + 1 = emp2.employee_id
; -- now table is joined but the first emp on the employee demographics is assigned to the next employee on the emp_salary table

-- to make it more specific and get the names
SELECT emp1.employee_id as emp_id_santa,
emp1.first_name as emp_first_santa,
emp1.last_name as emp_last_name_Santa,
emp2.employee_id as emp_first,
emp2.first_name as emp_first,
emp2.last_name as emp_last_name
from parks_and_recreation.employee_salary emp1
JOIN parks_and_recreation.employee_salary emp2
ON emp1.employee_id + 1 = emp2.employee_id
;

-- Joining multiple tables together
select * from parks_and_recreation.parks_departments; -- the parks_department is just a reference table and mostly data isnt inserted or deleted

-- using the inner join to join all the tables because the employee_salary table has the department id which is a match 
select * 
from parks_and_recreation.employee_demographics as dem
inner join parks_and_recreation.employee_salary as sal
	on dem.employee_id = sal.employee_id
inner join parks_and_recreation.parks_departments as dep
	on sal.dept_id = dep.department_id
    ;
-- the tables are all joined together even if the employee_Demographics doesnt have a column that is same









