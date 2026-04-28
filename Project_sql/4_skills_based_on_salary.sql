/*
Here I am looking at the top skills based on salary 
*/


SELECT
    skills,
    ROUND(avg(salary_year_avg), 0) as average

FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short like '%Data Analyst'
    AND salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER by average DESC
LIMIT 25;