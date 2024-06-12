-- Limit and Aliasing in sql
-- limit specifies the number of rows you want in your output
select * from parks_and_recreation.employee_demographics limit 3;
--  using the limit to find the oldest 3 employees 
select * from parks_and_recreation.employee_demographics order by age DESC limit 3;

-- USING the limit to get a specific row
select * from parks_and_recreation.employee_demographics 
order by age DESC 
limit 2, 1  -- start from position 2 and then take the next 1 row that appears
; 

-- ALIASING   is just a way to change the name of the columns
SELECT gender, AVG(age) from parks_and_recreation.employee_demographics group by gender having AVG(age) > 40;  
-- giving the avg(age ) a name to be used throughout the query 
SELECT gender, AVG(age) as avg_age 
from parks_and_recreation.employee_demographics
 group by gender
 having avg_age > 40;  




