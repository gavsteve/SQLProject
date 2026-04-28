/*
Here I am looking for the most in-demand skills for data analysts
-I choose to look at the top 5 most common skills across all Data Analyst positions, not just in the midwest
*/

SELECT
    skills,
    count(skills_job_dim.skill_id) as demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short like '%Data Analyst%'
Group BY    
    skills
ORDER BY
    demand_count DESC
LIMIT 5;



