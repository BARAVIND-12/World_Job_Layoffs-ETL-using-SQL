#removing duplicates from the data

#creating a new table as layoff_stagging
create table job_layoffs.layoff_stagging
like job_layoffs.layoffs;

select * from job_layoffs.layoff_stagging;

#inserting/copying the values from raw data(layoffs) to layoff_springs
insert job_layoffs.layoff_stagging
select *
from job_layoffs.layoffs;

#Using Row_number to find the duplicates in the data 
with duplicate_cte as 
(select *,
ROW_number() over(
partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
from job_layoffs.layoff_stagging)
select *
from duplicate_cte
where row_num > 1;

#creating a new table(layoff_stagging2) to remove the duplicates 
CREATE TABLE`job_layoffs`. `layoff_stagging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select *
from job_layoffs.layoff_stagging2;

#inserting the values into the new table(layoff_stagging2)
insert into job_layoffs.layoff_stagging2
(select *,
ROW_number() over(
partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions  
) as row_num
from layoff_stagging);

#deleting the duplicates from the table
delete
from layoff_stagging2 
where row_num>1;

select *
from layoff_stagging2
where row_num>1;

