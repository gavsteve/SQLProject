/*
Question: What are the top-paying data analyst jobs
    - Identify the top 10 highest-Paying Data Analyst roles that are available in the midwest
    -Focuses on job postings with specified salaries (Remove nulls)
    - Why? Highlight the top-paying opportuynites for Data Analysts, offering insights into finding most optimal skills and roles
*/

WITH Midwest_Data_Analyst_Jobs AS (
    SELECT  
        job_id,
        job_title,
        job_location,
        job_schedule_type,
        salary_year_avg,
        job_posted_date,
        company_id
    FROM
        job_postings_fact
    WHERE
        job_title LIKE '%Data Analyst%' AND
        (job_location LIKE '%OH%' OR
        job_location LIKE '%IN%' OR
        job_location LIKE '%IL%') AND
        salary_year_avg IS NOT NULL
)
SELECT  
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM
    Midwest_Data_Analyst_Jobs
ORDER BY
    salary_year_avg DESC
LIMIT 10;
 
