-- Full Data Cleaning Project
-- import the data from local machine in the tables section

SELECT * 
FROM layoffs;

-- because we want to have a high number of changes to the raw data, it is important to create a new staging table to avoid problems

create table layoffs_staging
like layoffs;

select * from layoffs_staging;

insert layoffs_staging
select * from layoffs; 
-- the layoffs_staging is the copy to the original raw data 

-- step1, Removing the Duplicates
-- when each row is unique, the row_number function will assign a unique number to it which is 1. if it finds similar rows then assigns 2/3
-- it only checks on the specified columns stated in the partition by clause inside the over function. its better to set all of the columns
SELECT *,
ROW_NUMBER() OVER(
	partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions
)  as row_num
FROM layoffs_staging;

-- to check on the duplicate values and remove them, create a cte to check if value of row_num is greater than 1
with duplicate_cte as
(
		SELECT *,
	ROW_NUMBER() OVER(
		partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions
	)  as row_num
	FROM layoffs_staging
)
select * 
from duplicate_cte
where row_num > 1
;

-- checking if the duplicate_cte table is returned perfectly as expected
select * 
from layoffs_staging
where company = 'Ola'; 

-- deleting the duplicated cannot be done within the cte. any update cannot work within the cte
-- create another table with the extra row_num column and then delete the rows where the row_num is greater than 1

-- drop table if exists layoffs_staging2;
CREATE TABLE `layoffs_staging2` (
  `company` text DEFAULT NULL,
  `location` text DEFAULT NULL,
  `industry` text DEFAULT NULL,
  `total_laid_off` int(11) DEFAULT NULL,
  `percentage_laid_off` text DEFAULT NULL,
  `date` text DEFAULT NULL,
  `stage` text DEFAULT NULL,
  `country` text DEFAULT NULL,
  `funds_raised_millions` int(11) DEFAULT NULL,
  `row_num` INT(11)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

select * from layoffs_staging2;

-- now this table will have an extra column to be used during analysis where anything above 2 is a duplicate
insert into layoffs_staging2
SELECT *,
		ROW_NUMBER() OVER(
		partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions
	)  as row_num
	FROM layoffs_staging;

-- now we can select the rows and delete the ones that are greater than one
select *
from layoffs_staging2
where row_num > 1;

-- delete the duplicates
delete
from layoffs_staging2
where row_num > 1;

select *
from layoffs_staging2
where row_num > 1;

-- STANDARDIZING THE DATA
-- 1. remove the whitespaces from the company column

select company, TRIM(company)
from layoffs_staging2;

UPDATE layoffs_staging2
set company = TRIM(company);
select * from layoffs_staging2;

-- updating all the columns to be same label i.e the crypto column should change the crypto currency to be crypto alone
select * 
from layoffs_staging2 
where industry like 'Crypto%';

update layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%';

select distinct industry from layoffs_staging2
order by 1
;
-- checking all of the columns
select DISTINCT location 
from layoffs_staging2
order by 1;

select DISTINCT country
from layoffs_staging2 
order by 1;
-- the united states appears twice because of the added fullstop value at the end hence the need to fix that 

select * from layoffs_staging2
where country like 'United States'
order by 1;

update layoffs_staging2 
set country = 'United States'
where country like 'United States%';

select distinct country 
from layoffs_staging2 
order by 1;
-- a different option to deal with it is
select distinct country, trim(trailing '.' from country)
from layoffs_staging2
order by 1;
update layoffs_staging2
set country = trim(trailing '.' from country)
where country like 'United States'
;

-- converting a time column which is in a text format into a date type
select `date`,
str_to_date(`date`, '%m/%d/%Y')
from layoffs_staging2;

UPDATE layoffs_staging2
set `date` = str_to_date(`date`, '%m/%d/%Y');

select * from layoffs_staging2;
-- alter to switch from text into a table
alter table layoffs_staging2
modify column `date` DATE;

-- working with the null and blank values
-- total_laid_off column
select * 
from layoffs_staging2 
where total_laid_off is null
 and percentage_laid_off is null;

select * 
from layoffs_staging2 
where industry is null 
or industry = '';
-- update the blank rows and columns to a null value
update layoffs_staging2 
set industry = NULL 
where industry = '';

select * from layoffs_staging2
where company = 'Airbnb';
-- since all of the Airbnb companies are under the travel industry, update the blank industries to their corresponding values

-- is effective when the number of rows is too small 
update layoffs_staging2
set industry = 'Travel'
where company = 'Airbnb';

-- in cases where there is a large number of rows and columns that are null and empty then 
select t1.company, t1.industry, t2.company, t2.industry
from layoffs_staging2 as t1
join layoffs_staging2 as t2
	on t1.company = t2.company
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;

-- updating
update 
layoffs_staging2 as t1
join layoffs_staging2 as t2
	on t1.company = t2.company
set t1.industry = t2.industry 
where t1.industry is null 
and t2.industry is not null;


select * 
from layoffs_staging2 
where industry is null or industry = ''; 
-- the above did not have another column with the same company industry hence it wasnt updated

select * from layoffs_staging2
where total_laid_off is null 
and percentage_laid_off is null;

-- deleting the rows that lacks the total_laid_off and the percentage_laid_off
delete 
from layoffs_staging2
where total_laid_off is null 
and percentage_laid_off is null;

-- delete the row_num column in the table
alter table layoffs_staging2
drop column row_num;

select * from layoffs_staging2;

-- sum of the total_laid_off per country, orderd by the country and grouped in a descending order 
select country , sum(total_laid_off)
from layoffs_staging2
group by country
order by 2 desc
;

-- find totak sum of total_laid-off per day and how they are distributed
select `date`, sum(total_laid_off)
from layoffs_staging2
group by `date`
order by 1 desc;

-- to select the laid off by the years then use the year function  
select YEAR(`date`), sum(total_laid_off)
from layoffs_staging2
group by YEAR(`date`)
order by 1 desc;


select stage, sum(total_laid_off)
from layoffs_staging2
group by stage
order by 1 desc;


-- using the substring function to access the month from the provided date
select substring(`date`, 6, 2) as `month`
from layoffs_staging2;

-- ROLLING TOTAL LAYOFFS
select substring(`date`, 6, 2) as `month`, sum(total_laid_off)
from layoffs_staging2
where substring(`date`, 6, 2) is not null
group by `month`
order by 1 asc
; -- returns the number of total laid offs per month on all of the months from the years

-- to return for the specific month of each and every year then 
select substring(`date`, 1, 7) as month_year, sum(total_laid_off) as laid_off
from layoffs_staging2
where substring(`date`, 6, 2) is not null
group by month_year
order by 1 asc
;
-- rolling total for the total_laid-off from the first day of being laid off

with rolling_total as 
(
select substring(`date`, 1, 7) as month_year, sum(total_laid_off) as rolling_laid_off
from layoffs_staging2
where substring(`date`, 6, 2) is not null
group by month_year
order by 1 asc
)
select month_year, rolling_laid_off, sum(rolling_laid_off) over(order by month_year) as new_rolling_total
 from rolling_total
; -- rolling total from the first month of laying off individuals adding them up till the last month of laying off

select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc
;
-- grouping the company lay_offs by the years
select company, year(`date`),sum(total_laid_off) as company_laid_off
from layoffs_staging2
group by company, year(`date`)
order by 3 desc
;
-- ordering the total_laid_offs and ranking them according to total number of layoffs each and every year
with company_year(company, years, total_laid_off) as(
select company, year(`date`),sum(total_laid_off)
from layoffs_staging2
group by company, year(`date`)
order by 3 desc
)
select *, dense_rank() over(partition by years order by total_laid_off desc) as ranking
from company_year
where years is not null
-- order by ranking -- only apply if you want to sort all number ones of the ranks irregardless of the year
;
  
-- to have the option to look at specifics function such as only the top 5 then you can use 2 ctes together
with company_year(company, years, total_laid_off) as(
select company, year(`date`),sum(total_laid_off)
from layoffs_staging2
group by company, year(`date`)
order by 3 desc
), company_rankings as (
select *, dense_rank() over(partition by years order by total_laid_off desc) as ranking
from company_year
where years is not null
)
select * 
from company_rankings
where ranking <= 5
;


















