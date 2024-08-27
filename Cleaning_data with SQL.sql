create table layoffs1
like layoffs;

insert into layoffs1
select *
from layoffs;

select *
from layoffs1;

-- Find and Remove duplicate values
select *,row_number() 
over(partition by company, location, industry, total_laid_off, 
percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoffs1;

create table layoffs2
like layoffs1;

select *
from layoffs2;

insert into layoffs2
select *,row_number() 
over(partition by company, location, industry, total_laid_off, 
percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoffs1;

-- Duplicate values
select *
from layoffs2
where row_num > 1;

delete
from layoffs2
where row_num > 1;

-- Standardization
select distinct(trim(company)) as trim_company, company
from layoffs2;

update layoffs2
set company=trim(company);

select distinct(industry)
from layoffs2
order by 1;

select industry
from layoffs2 
where industry like 'crypto%';

update layoffs2
set industry='Crypto'
where industry like 'Crypto%';

select distinct location
from layoffs2
order by 1;

update layoffs2
set location=trim(location);

select distinct country
from layoffs2
order by 1;

update layoffs2
set country=trim(trailing '.' from country)
where country like 'United States%';

update layoffs2
set stage=trim(stage);

select `date`
from layoffs2;

update layoffs2
set `date`=str_to_date(`date`, '%m/%d/%Y');

select `date`
from layoffs2;

alter table layoffs2
modify column `date` date;

-- Remove null values
select *
from layoffs2
where stage is null;

select total_laid_off
from layoffs2
where total_laid_off is null;

delete
from layoffs2
where total_laid_off is null;

select percentage_laid_off
from layoffs2
where percentage_laid_off is null;

delete
from layoffs2
where percentage_laid_off is null;

alter table layoffs2
drop column row_num;

select *
from layoffs2;

select stage
from layoffs2
where stage is null;

delete
from layoffs2
where stage is null;

select funds_raised_millions
from layoffs2
where funds_raised_millions is null;

delete
from layoffs2
where funds_raised_millions is null;

select industry
from layoffs2
where industry='';






















