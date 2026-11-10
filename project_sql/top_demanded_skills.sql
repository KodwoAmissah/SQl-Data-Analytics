select skills, COUNT(skills_job_dim.job_id) as demand_count
from job_postings_fact
join skills_job_dim 
on job_postings_fact.job_id = skills_job_dim.job_id
join skills_dim 
on skills_job_dim.skill_id = skills_dim.skill_id
where job_title_short ='Data Analyst' AND job_work_from_home='True'
group by skills
order by demand_count desc
limit 10;