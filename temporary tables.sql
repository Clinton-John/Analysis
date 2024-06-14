-- TEMP Tables (temporary tables)
-- they are the tables that are only visible to the session that they are created in
-- for storing intermediate results for complex queries, and to manipulate data before inserting into a permanent database

create temporary table temp_table
(
f_name varchar(50),
l_name varchar(50),
fav_anime varchar(100)
); -- creates a table but it isnt reflected on the already existing databases

insert into temp_table
values('John', 'Doe', 'Bondocks');
select * from temp_table;

create temporary table temp_salary_over50
select * from parks_and_recreation.employee_salary
where salary > 50000;

select * from temp_salary_over50;
-- as long as the workbench isnt closed the temp_table can work regardless of the tab that is open. we can open a new the code will still excecute
-- ctes mostly for more advanced operations




