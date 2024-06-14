-- TRIGGERS and EVENTS
-- triggers are a block of code that excecutes itself when an event takes place on a specific table
-- eg. when data is updated into the employee_salary then the data must also be added into the employee_demographics table


DELIMITER $$
CREATE TRIGGER employee_insert
	AFTER INSERT ON parks_and_recreation.employee_salary
    FOR EACH ROW
BEGIN
	INSERT INTO parks_and_recreation.employee_demographics(employee_id, first_name, last_name)
    VALUES (NEW.employee_id, NEW.first_name, NEW.last_name);
END $$
DELIMITER ;

-- insert only into the employee_salary table
INSERT INTO parks_and_recreation.employee_salary(employee_id,  first_name, last_name, occupation, salary, dept_id)
values(13, 'walter', 'white', 'Entertainment CEO', 45000, null);

select * 
from parks_and_recreation.employee_salary;

select * 
from parks_and_recreation.employee_demographics;

-- EVENTS
-- same to trigger but happens only when it is specified to take place but a trigger will always happen whenever an event takes place
-- for example if a person clocks age 60 then delete them from the database because they are now retired

DELIMITER $$
CREATE EVENT delete_retirees
ON SCHEDULE EVERY 30 second
DO
BEGIN
	DELETE 
    FROM parks_and_recreation.employee_demogaphics
    where age >= 60;
END $$
DELIMITER ;

-- if it doesnt work
show variables like 'event%';

SELECT * from parks_and_recreation.employee_demographics;

















