#standarizing the data

select company
from job_layoffs.layoff_stagging2;

#removing blank spaces from the column company
update job_layoffs.layoff_stagging2
set company=trim(company);

select `date`
from job_layoffs.layoff_stagging2
;

#changing the same industry with different name into one industry
update job_layoffs.layoff_stagging2
set industry="Crypto"
where industry like "crypto%";


update job_layoffs.layoff_stagging2
set country="United states"
where country like "United states%";

#standardizing the date format

UPDATE job_layoffs.layoff_stagging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

alter table job_layoffs.layoff_stagging2
modify column `date` date;

SET SQL_SAFE_UPDATES = 0;

#replacing the industry blank space into null value
update job_layoffs.layoff_stagging2 
set industry= null
where industry='';
 

#replacing the relavant industry null values
update job_layoffs.layoff_stagging2 t1
join job_layoffs.layoff_stagging2 t2
	on t1.company=t2.company
set t1.industry=t2.industry
where t1.industry is null
and t2.industry is not null;

#deleting of the rows which have no values in total_laid_off and percentag_laid_off
select *
from job_layoffs.layoff_stagging2
where total_laid_off is null and percentage_laid_off is null;

delete 
from job_layoffs.layoff_stagging2
where total_laid_off is null and percentage_laid_off is null;

#removing the unnecessay columns from the table
alter table job_layoffs.layoff_stagging2
drop column row_num;