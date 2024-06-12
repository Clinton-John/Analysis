-- string functions

select length('james bond');

-- use the length function to get the lenght of the first_name
select first_name, length(first_name) as length
 from parks_and_recreation.employee_demographics
 order by 2
 ; -- for example to ensure that all the mobile phone numbers entered are 10 digits
 -- converting to upper and to lower
 
 select upper('James');
 select lower('James');
 
 select first_name, upper(first_name)
 from parks_and_recreation.employee_demographics;
 -- TRIM to remove the white spaces before and after some words
 select trim('        hello world  ');
  select ltrim('        hello world  '); -- removes the white space on the left side
  select rtrim('        hello world  ');  -- removes the white space only on the right side
 
 -- the LEFT function
 select  first_name, left(first_name, 3) as lef3, -- gets only the 3 charachters from the left in the specified column
 right(first_name, 4) as right4,
 substring(first_name, 3, 2) as substr, -- in the first_name go to the 3rd charchter and take the next two  
birth_date,
substring(birth_date, 6, 2) as birth_month -- to find the month of birth

 from parks_and_recreation.employee_demographics; 
 
 -- REPLACE used to replace a specific word/string with a specified string
 select first_name,  replace(first_name, 'a', 'b')
 from parks_and_recreation.employee_demographics
 ;
 
 select locate('s', 'jamesbond');
 -- LOCATE
  select first_name,  locate('an', first_name) -- locate the word an in every 
 from parks_and_recreation.employee_demographics
 ;
 
 -- concatenation of different columns
  select first_name,  last_name,
  concat(first_name, ' ' , last_name) as full_name
 from parks_and_recreation.employee_demographics
 ;
 
 
 
 
 