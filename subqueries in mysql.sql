-- SUBQUERIES   a query within another query

select * 
from parks_and_recreation.employee_demographics
where employee_id in (
		select employee_id   -- can only return one column because the in is an operator. 
		from parks_and_recreation.employee_salary
		where dept_id = 1
);

-- using subqueries with the select statement
select first_name, salary,
(select avg(salary) from parks_and_recreation.employee_salary) as avg_salary
from parks_and_recreation.employee_salary
;

-- using the subqueries with the from statement
select gender, avg(age), max(age), min(age), count(gender)
from parks_and_recreation.employee_demographics
group by gender
;
-- to find the average of the oldest ages, the minimum ages, the average of counts
select *
from (
   select gender, avg(age), max(age), min(age), count(age)
from parks_and_recreation.employee_demographics
group by gender
) as agg_table
; -- this will produce the results that are same to the previous one 

-- now to find the average of the fields that we just found and added in the new output, the following will apply
select avg(`max(age)`)
from (
   select gender, avg(age), max(age), min(age), count(age)
from parks_and_recreation.employee_demographics
group by gender
) as agg_table
-- group by gender
;

-- to avoid using the backticks
select avg(max_age)
from (
   select gender, 
   avg(age) as avg_age,
   max(age) as max_age, 
   min(age) as min_age, 
   count(age) as count_age
from parks_and_recreation.employee_demographics
group by gender
) as agg_table
-- group by gender
;












