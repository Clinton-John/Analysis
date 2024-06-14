-- CTEs  Common Table Expresions
-- used to define a subquery block which can then be referenced in the main query

SELECT  gender, avg(salary), max(salary), min(salary), count(salary)
from parks_and_recreation.employee_demographics as dem
join parks_and_recreation.employee_salary as sal
	on dem.employee_id = sal.employee_id
group by gender;

-- converting the above code to a cte using the keyword with

with cte_example as
(
SELECT  gender, avg(salary) as avg_sal, max(salary) as max_sal, min(salary) as min_sal, count(salary) as count_sal
from parks_and_recreation.employee_demographics as dem
join parks_and_recreation.employee_salary as sal
	on dem.employee_id = sal.employee_id
group by gender
)
-- ctes are used mainly after they are defined
-- select *  
-- from cte_example
select avg(avg_sal) 
from cte_example
;
-- instead of using the as in the subquery, it is possible to define the column names at the top, using paranthesis
with cte_example(Gender, AVG_sal, MAX_sal, MIN_sal, COUNT_sal) as
(
SELECT  gender, avg(salary) as avg_sal, max(salary) as max_sal, min(salary) as min_sal, count(salary) as count_sal
from parks_and_recreation.employee_demographics as dem
join parks_and_recreation.employee_salary as sal
	on dem.employee_id = sal.employee_id
group by gender
)
select *  
from cte_example

;




-- cant be used outside the semicolon because it is just a temporary table created 
-- creating multiple ctes within the same query
with first_cte as
(
select employee_id, first_name, birth_date
from parks_and_recreation.employee_demographics
where birth_date > '1985-01-01'
),
second_cte as 
(
select employee_id, salary
from parks_and_recreation.employee_salary
where salary > 50000
)
select * from
first_cte 
join second_cte
	on first_cte.employee_id = second_cte.employee_id
;






