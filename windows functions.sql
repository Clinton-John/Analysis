-- WINDOW functions
-- same to the group by but difference is that the windows function allows you to keep details of each row while at the same time perfoming aggregation

select gender, avg(salary) as avg_salary
from parks_and_recreation.employee_demographics as dem
join parks_and_recreation.employee_salary as sal
 on dem.employee_id = sal.employee_id
 group by gender
 ;  -- groub by aggregates everything together into one row
 
 select gender, avg(salary) over() -- average of the entire column
from parks_and_recreation.employee_demographics as dem
join parks_and_recreation.employee_salary as sal
 on dem.employee_id = sal.employee_id
 ;  -- the where looks at the average salary of each and every row contrary to the groupby function above which groups them into a single row

-- the window function is only conducted based on one columns which is the gender 
select  dem.first_name, dem.last_name, gender, avg(salary) over(partition by gender) 
from parks_and_recreation.employee_demographics as dem
join parks_and_recreation.employee_salary as sal
 on dem.employee_id = sal.employee_id
 ; -- gives average of each gender and passes it out based on the gender. it allows addition of other rows without it being affected
 -- the group by cannot return the above function because it gives a totally different outcome and the fields are re arranged
 
 -- window function with the sum
select  dem.first_name, dem.last_name, gender, -- gives sum of the females and the sum of the males
sum(salary) over(partition by gender) as sum_salary
from parks_and_recreation.employee_demographics as dem
join parks_and_recreation.employee_salary as sal
	on dem.employee_id = sal.employee_id
 ;
 -- rolling total to add the sum of salaries and combine from the first row going on to the next rows
select  dem.first_name, dem.last_name, gender, salary,
sum(salary) over(partition by gender order by dem.employee_id) as sum_salary
from parks_and_recreation.employee_demographics as dem
join parks_and_recreation.employee_salary as sal
	on dem.employee_id = sal.employee_id
 ; 
 
 -- ROW NUMBER  with ver() gives all the rows a unique new number
 select dem.employee_id, dem.first_name, dem.last_name, gender, 
 row_number() over()
from parks_and_recreation.employee_demographics as dem
join parks_and_recreation.employee_salary as sal
	on dem.employee_id = sal.employee_id
 ;
 
 -- ROW NUMBER  with over() and partition by, partitions with the gender and then gives the 
 select dem.employee_id, dem.first_name, dem.last_name, gender, 
 row_number() over(partition by gender)
from parks_and_recreation.employee_demographics as dem
join parks_and_recreation.employee_salary as sal
	on dem.employee_id = sal.employee_id
 ; 
 
  -- ROW NUMBER  with over(), partition by, and order by salary partitions with the gender, orders by salary and their number
 select dem.employee_id, dem.first_name, dem.last_name, sal.salary gender, 
 row_number() over(partition by gender order by salary desc) as row_num
from parks_and_recreation.employee_demographics as dem
join parks_and_recreation.employee_salary as sal
	on dem.employee_id = sal.employee_id
 ;
 
 -- RANK same to row_number but if it finds a duplicate number based on the order by then it ranks them as the same number
select dem.employee_id, dem.first_name, dem.last_name, sal.salary gender, 
 row_number() over(partition by gender order by salary desc) as row_num,
 rank() over(partition by gender order by salary desc) as rank_num
from parks_and_recreation.employee_demographics as dem
join parks_and_recreation.employee_salary as sal
	on dem.employee_id = sal.employee_id
 ; -- the next number after the repetiton is going to skip a single numeric value
 
 -- DENSE_RANK different from the previous rank but it doesnt skip a number as the rank eg after 5,5 it goes to 6 instead of 7
 SELECT dem.employee_id, dem.first_name, dem.last_name, sal.salary gender, 
 ROW_NUMBER() over(partition by gender order by salary desc) as row_num,
 rank() over(partition by gender order by salary desc) as rank_num,
 DENSE_RANK() over(partition by gender order by salary desc) as dense_rank_num
FROM parks_and_recreation.employee_demographics as dem
JOIN parks_and_recreation.employee_salary as sal
	ON dem.employee_id = sal.employee_id
 ;
 
 
 
 
 
 