SELECT
    count(job_id) as number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        When job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END as location_category
FROM
    job_postings_fact
WHERE   job_title_short = 'Data Analyst'
Group By
    location_category

/* 
Lable new column as follows:
 - Anywhere jobs as remote
 -New York jobs as local
*/