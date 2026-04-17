SELECT
    COUNT(job_id) as job_count,
    EXTRACT(MONTH FROM job_posted_date) as month
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    month
Order By 
    job_count DESC;





SELECT
    job_schedule_type as schedule_type,
    AVG(salary_year_avg) as avg_yearly,
    AVG(salary_hour_avg) as avg_hourly
FROM
    job_postings_fact
WHERE
    job_posted_date > '2023-06-01'
GROUP BY
    job_schedule_type;






SELECT
   EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') as month,
   COUNT(job_id) as job_count
FROM
    job_postings_fact
WHERE
    EXTRACT(YEAR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') = 2023
GROUP BY
    month
ORDER BY
    month;




SELECT
    jpf.company_id,
    cd.name as company_name,
    jpf.job_health_insurance,
    job_posted_date
FROM
    job_postings_fact jpf
Join
    company_dim as cd on jpf.company_id = cd.company_id
WHERE
    jpf.job_health_insurance = 'Yes' and
    EXTRACT(QUARTER FROM jpf.job_posted_date) = 2
    AND extract(year from jpf.job_posted_date) = 2023;
