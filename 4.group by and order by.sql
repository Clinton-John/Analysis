-- using the GROUP BY in mysql

SELECT * from parks_and_recreation.employee_demographics;

select gender from parks_and_recreation.employee_demographics group by gender;

-- selects all the ages available and groups them by the average age that is of the male and of the female
SELECT gender, AVG(age), MAX(age), MIN(age), count(age) FROM parks_and_recreation.employee_demographics GROUP BY gender;


SELECT * from parks_and_recreation.employee_salary;
SELECT occupation from parks_and_recreation.employee_salary GROUP BY occupation;
-- grouping using both the occupation and the slary returns some rows two times because of the difference in salary

SELECT occupation, salary from parks_and_recreation.employee_salary group by occupation, salary;
-- ORDER BY 
SELECT * from parks_and_recreation.employee_demographics order by first_name DESC; -- the default is ascending(ASC). to change to descending (DESC)

SELECT * from parks_and_recreation.employee_demographics order by gender; 
-- you can order by using more than 2 columns the gender and the age. it will sort the gender first then sort the age later
SELECT * from parks_and_recreation.employee_demographics order by gender, age; 

-- you can order by using more than 2 columns the gender and the age. it will sort the gender first then sort the age later
SELECT * from parks_and_recreation.employee_demographics order by gender, age DESC;  -- this gives the gender and the age in a DESC order

-- alternatively instead of using the column name you can use the column position
SELECT * from parks_and_recreation.employee_demographics order by 5, 4;

-- HAVING AND WHERE
-- HAVING was specifically created for this specfic function that is to be used after the GROUP BY FUNCTION
SELECT gender, AVG(age) from parks_and_recreation.employee_demographics group by gender;   

SELECT gender, AVG(age) from parks_and_recreation.employee_demographics group by gender HAVING AVG(age) > 40;

-- using both the where and having on the same sentence
select occupation, avg(salary) from parks_and_recreation.employee_salary group by occupation;  

-- using where to find any field containing the word manager and then using a having to find where the average salary is more than 75000
select occupation, avg(salary) from parks_and_recreation.employee_salary 
where occupation like '%manager%' 
group by occupation having avg(salary) > 75000;




