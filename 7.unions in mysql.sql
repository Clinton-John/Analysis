-- UNIONS -- it is used to combine rows in a same or different tables, but not columns as in join
-- you can take one select statements and then combine it to the other select statements

select * from
 parks_and_recreation.employee_demographics
union distinct
select * 
from parks_and_recreation.employee_salary
; -- by default, the above is a union distinct, and it will remove all the similar values

select first_name, last_name 
from parks_and_recreation.employee_demographics
union all
select first_name, last_name
from parks_and_recreation.employee_salary
;-- gives all the results without removing any of the default values

-- union use case
select first_name, last_name, 'Old' as label
from parks_and_recreation.employee_demographics
where age > 50;  -- find all the employees who are old, 50 years and above

-- find the old employees but who are also higly paid
select first_name, last_name, 'Old male' as label
from parks_and_recreation.employee_demographics
where age > 40 and gender = 'Male'
union
select first_name, last_name, 'Old female' as label
from parks_and_recreation.employee_demographics
where age > 40 and gender = 'FeMale'
union  
select first_name, last_name,'Highly Paid' as Label
from parks_and_recreation.employee_salary
where salary > 70000
order by first_name, last_name
;





