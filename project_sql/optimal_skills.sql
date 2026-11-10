WITH skills_demand AS(
    select skills_dim.skills,
    skills_dim.skill_id, 
    COUNT(skills_job_dim.job_id) as demand_count
    from job_postings_fact
    join skills_job_dim 
    on job_postings_fact.job_id = skills_job_dim.job_id
    join skills_dim 
    on skills_job_dim.skill_id = skills_dim.skill_id
    where job_title_short ='Data Analyst' AND job_work_from_home='True'
    AND salary_year_avg is NOT NULL
    group by skills_dim.skill_id
    ),average_salary as(
    select skills_job_dim.skill_id,
    round(avg(salary_year_avg),0)as avg_salary
    from job_postings_fact
    join skills_job_dim 
    on job_postings_fact.job_id = skills_job_dim.job_id
    join skills_dim 
    on skills_job_dim.skill_id = skills_dim.skill_id
    where job_title_short ='Data Analyst' AND salary_year_avg is NOT NULL
    And job_work_from_home='True'
    group by skills_job_dim.skill_id
    )

select skills_demand.skill_id,skills_demand.skills,demand_count,avg_salary   
from skills_demand
join average_salary
on skills_demand.skill_id=average_salary.skill_id
order by avg_salary desc,demand_count DESC
limit 25;