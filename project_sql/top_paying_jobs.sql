select job_id,
job_title,
job_location,
job_schedule_type,
job_posted_date,
salary_year_avg,
company_dim.name
from job_postings_fact
left JOIN company_dim 
on job_postings_fact.company_id = company_dim.company_id
where job_title_short ='Data Analyst' and job_location='Anywhere'
and salary_year_avg is not null
order by salary_year_avg desc
limit 10;