-- CASE statement.   same to the if else statement

select * from parks_and_recreation.employee_demographics;

select first_name, last_name, age,
case 
	when age <= 30 then 'Young'
    when age between 31 and 50 then 'old'
end as age_bracket
from parks_and_recreation.employee_demographics;

-- using the CASE statement to check for the conditions to increase the users salary based on the following
-- < 50000 then increase by 5%
-- > 50000 then increase by 7% 
-- < Finance department increase by 10%
select * from parks_and_recreation.parks_departments;
select first_name, last_name, salary,
case 
	when salary < 50000 then (salary * 0.05)+salary
    when salary >= 50000 then (salary * 0.07)+salary
    when emp_table.dept_id = 6 then (salary * 0.10)+salary
end as new_salary
from parks_and_recreation.employee_salary as emp_table
; -- you can also have more than one case statements











