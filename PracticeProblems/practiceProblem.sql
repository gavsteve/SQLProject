/* This Query just shows how we are going to use a case 
*/
SELECT
    job_id,
    salary_year_avg,
    CASE
        WHEN salary_year_avg Between 0 and 50000 then 'Low'
        WHEN salary_year_avg Between 50001 and 100000 then 'Standard'
        WHEN salary_year_avg > 100000 then 'High'
        ELSE 'Unknown'
    END as Salary_range
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
ORDER BY
    salary_year_avg DESC;


/* Subquieres and CTE's 
*/

-- Starting with subqueries 
SELECT *
FROM (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH from job_posted_date) = 1
) AS january_jobs;

-- Common Table Expressions (CTEs): define a temporary result set that you can reference 
WITH january_jobs AS (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH from job_posted_date) = 1
)

SELECT *
FROM january_jobs;

--Practice Problem: subqueries

SELECT 
    name as company_name,
    company_id
FROM 
    company_dim
WHERE company_id IN(
    SELECT
        company_id
    FROM
        job_postings_fact
    WHERE
        job_no_degree_mention = 'True'
    ORDER by 
        company_id
);


--Practice Problem: CTE's
WITH company_job_count AS(
    SELECT
        company_id,
        COUNT(*) AS total_jobs
    FROM
        job_postings_fact
    GROUP BY
        company_id
)
SELECT 
    company_dim.name AS company_name,
    company_job_count.total_jobs
FROM 
    company_dim
LEFT JOIN company_job_count on company_job_count.company_id = company_dim.company_id
ORDER by
    total_jobs DESC;

--TWO more practice problems

SELECT
    skills_dim.skill_id,
    skills_dim.skills as skill_name,
    skill_count.count
FROM
    skills_dim
INNER JOIN (
    SELECT
        skill_id,
        COUNT(*) AS count
    FROM skills_job_dim
    GROUP BY skill_id
    ORDER BY count(*) DESC
    Limit 5
) AS skill_count on skills_dim.skill_id = skill_count.skill_id
ORDER BY skill_count.count desc;

-- Problem 2
/*
- First implement a subquery to aggregate job counts per company 
-Base them on size: 'small' 'medium' 'large'

*/

SELECT
    company_dim.name,
    company_dim.company_id,
    job_count.job_counts,
    CASE
        WHEN job_count.job_counts < 10 THEN 'Small'
        WHEN job_count.job_counts BETWEEN 10 AND 50 THEN 'Medium'
        WHEN job_count.job_counts > 50 THEN 'Large'
    END as company_size
FROM
    company_dim
Inner Join (
    SELECT
        company_id,
        COUNT(job_id) as job_counts
    FROM
        job_postings_fact
    GROUP BY
        company_id
) AS job_count on company_dim.company_id = job_count.company_id
ORDER BY
    job_count.job_counts DESC;



/*
-- Trying to figure this out
    SELECT
    company_id,
    COUNT(job_id),
    CASE
        WHEN COUNT(job_id) < 10 THEN 'Small'
        WHEN COUNT(job_id) BETWEEN 10 AND 50 THEN 'Medium'
        WHEN COUNT(job_id) > 50 THEN 'Large'
    END as company_size
FROM
    job_postings_fact
GROUP BY
    company_id
*/


/*
Last Practice problem
Find the job postings from the first quarter that have a salary greater than $70k
-Combine job posting tables from the first quarter of 2023 (Jan - Mar)
-Gets job postings with an average yearly salary > $70000
*/

WITH first_quarter_salary AS (
    SELECT *
    FROM
        january_jobs
    WHERE
        salary_year_avg > 70000 AND
        job_title_short = 'Data Analyst'
    UNION ALL
    SELECT *
    FROM
        february_jobs
    WHERE
        salary_year_avg > 70000 AND
        job_title_short = 'Data Analyst'
    UNION ALL
    SELECT*
    FROM
        march_jobs
    WHERE
        salary_year_avg > 70000 AND
        job_title_short = 'Data Analyst'
)
SELECT
    job_title_short,
    job_id,
    salary_year_avg,
    job_posted_date::Date
FROM
    first_quarter_salary
ORDER BY
    salary_year_avg DESC;

--This is how I did it,

--Now this is how the teacher is gonna do it


SELECT 
    quarter1_jobs.job_title_short,
    quarter1_jobs.job_location,
    quarter1_jobs.job_via,
    quarter1_jobs.job_posted_date::Date,
    quarter1_jobs.salary_year_avg
FROM (
    Select *
    FROM january_jobs
    UNION ALL
    Select *
    FROM february_jobs
    UNION ALL
    Select *
    FROM march_jobs
) AS quarter1_jobs
WHERE
    quarter1_jobs.salary_year_avg > 70000 AND
    quarter1_jobs.job_title_short = 'Data Analyst'
ORDER by
    quarter1_jobs.salary_year_avg DESC;