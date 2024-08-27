-- Eda
select *
from layoffs2;

-- Maximum
select max(total_laid_off), max(percentage_laid_off)
from layoffs2;

select *
from layoffs2
where percentage_laid_off = 1
order by funds_raised_millions desc; 

select company, sum(total_laid_off)as sum_of_total_laid_off
from layoffs2
group by company 
order by 2 desc;

select max(`date`), min(`date`)
from layoffs2;

select industry, sum(total_laid_off) as sum_of_total_laid_off
from layoffs2
group by industry
order by 2 desc;


select year(`date`), sum(total_laid_off) as sum_of_total_laid_off
from layoffs2
group by year(`date`)
order by 1 desc;

select substring(`date`,6,2) as `month`, sum(total_laid_off)
from layoffs2
group by `month`
order by 1;

with rolling_total as
(
select substring(`date`, 1,7) as `month`, sum(total_laid_off) as laid_off
from layoffs2
where substring(`date`, 1,7) is not null
group by `month`
order by 1
)
select `month`,laid_off, sum(laid_off) over(order by `month`) as rolling_total
from rolling_total;

select company, year(`date`) as years, sum(total_laid_off)
from layoffs2
group by company, year(`date`)
order by 3 desc;

with company_year(company, years, total_laid_off) as
(
select company, year(`date`) as years, sum(total_laid_off)
from layoffs2
group by company, year(`date`)
),
company_rank as
(
select *, dense_rank() 
over(partition by years order by total_laid_off desc) as rank_laid_off
from company_year
)
select *
from company_rank
;




















 











































































































































































































