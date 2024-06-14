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


