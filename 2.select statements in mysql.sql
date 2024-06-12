SELECT * FROM parks_and_recreation.employee_demographics;

SELECT first_name from parks_and_recreation.employee_demographics;

SELECT first_name, last_name, age from parks_and_recreation.employee_demographics;
 SELECT first_name, last_name, birth_date, age, age+10 from parks_and_recreation.employee_demographics;
 -- The order of operation in sql is the PEMDAS (paranthesis, exponential, multiplication, division, addition, subtraction)
 -- selecting unique values from a number of rows
 SELECT gender from parks_and_recreation.employee_demographics;
  SELECT DISTINCT gender from parks_and_recreation.employee_demographics;
SELECT DISTINCT first_name,  gender from parks_and_recreation.employee_demographics; 
-- it wotn return only twp values but only the same names and the same gender will be considered uniqu
   