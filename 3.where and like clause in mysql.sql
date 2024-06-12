-- WHERE CLAUSE
SELECT * FROM parks_and_recreation.employee_demographics WHERE first_name = "Leslie";

SELECT * FROM parks_and_recreation.employee_salary WHERE salary > 80000;
SELECT * FROM parks_and_recreation.employee_salary WHERE salary >= 50000;
-- =, >= , <= , !=,  yy-mm-dd
-- LOGIC OPERATIONS

SELECT * from parks_and_recreation.employee_demographics where birth_date > '1985-01-01' ;
SELECT * from parks_and_recreation.employee_demographics where birth_date > '1985-01-01' AND gender = 'male' ;

-- LIKE STATEMENT
-- % this means that it is anything  while the _ means a specific value 
SELECT * from parks_and_recreation.employee_demographics where first_name = 'Andy';
SELECT * from parks_and_recreation.employee_demographics where first_name LIKE 'and%'; -- any name starting with And will be included
SELECT * from parks_and_recreation.employee_demographics where first_name LIKE '%nd%'; -- any name having nd anywhere will be included
SELECT * from parks_and_recreation.employee_demographics where first_name LIKE '%nd%'; -- any name having nd anywhere will be included

SELECT * from parks_and_recreation.employee_demographics where first_name LIKE 'a__'; -- any name having 3 charachters but starting with an a 
SELECT * from parks_and_recreation.employee_demographics where first_name LIKE 'a__%'; -- starst with a, has more than 3 charachters 







