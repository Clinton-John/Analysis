-- Stored procedures
-- used to save the sql code to allow you use it over and over again

select * 
from parks_and_recreation.employee_salary
where salary > 50000
;

create procedure large_salaries()
select * 
from parks_and_recreation.employee_salary
where salary > 50000
; -- creates a procedure and is stored in the stored procedure. this then allows for it to be accessed and used in a different place 

-- calling the stored procedure
call large_salaries();
-- having different queries within a single stored procedure using a delimeter
create procedure mixed_salaries()
select * 
from parks_and_recreation.employee_salary
where salary > 50000;
select * 
from parks_and_recreation.employee_salary
where salary <= 20000;
; -- this will create a stored procedure one then excecute the second part of the code as a standalone and give out its result


-- DELIMITERS In stored procedures
-- there can be a number of different delimiters that can be used and you can choose from a specific

-- set the delimiter to be $$ then thats what will be used throughout
DELIMITER $$ 
create procedure large_salaries3()
BEGIN
	select * 
	from parks_and_recreation.employee_salary
	where salary > 50000;
	select * 
	from parks_and_recreation.employee_salary
	where salary <= 30000;
END $$
DELIMITER ; -- return the delimiter back to the original

call large_salaries3(); -- returns two procedures 

-- PAARMETERS
-- are the variables that are passed as inputs into some stored procedures
DELIMITER $$ 
create procedure large_salaries4(employee_id_param int)
BEGIN
	select salary 
	from parks_and_recreation.employee_salary
    where employee_id = employee_id_param
	;
END $$
DELIMITER ;

call large_salaries4(2); -- returns the salary of the second value 













