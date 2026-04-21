/*
I am looking to identify the skills that are required for the top paying data analyst jobs
    -use the top 10 highest -paying data analyst jobs from the first query
    -add the specific skills required for these roles 
*/

WITH top_paying_jobs as (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name as company_name,
        job_location
    FROM
        job_postings_fact
    LEFT JOIN
        company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title LIKE '%Data Analyst%' AND
        (job_location LIKE '%OH%' OR
        job_location LIKE '%IN%' OR
        job_location LIKE '%IL%') AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)
SELECT
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;