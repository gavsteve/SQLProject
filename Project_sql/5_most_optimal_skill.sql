/*
Now I am looking at what are the most optimal skills to learn (aka it's in hgih demand and a high-paying skill)
*/

With top_demand as (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        count(skills_job_dim.skill_id) as demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short like '%Data Analyst%'
        AND salary_year_avg IS NOT NULL
    Group BY    
        skills_dim.skill_id

), skills_salary as (
    SELECT
        skills_job_dim.skill_id,
        ROUND(avg(salary_year_avg), 0) as average

    FROM
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short like '%Data Analyst'
        AND salary_year_avg IS NOT NULL
    GROUP BY
        skills_job_dim.skill_id
)

SELECT
    top_demand.skill_id,
    top_demand.skills,
    demand_count,
    average
FROM
    top_demand
INNER join skills_salary ON top_demand.skill_id = skills_salary.skill_id
WHERE
    demand_count >10
ORDER BY
    average DESC,
    demand_count DESC
LIMIT 25;

    



