/*
Learning how to use the COALESCE concept in SQL. More than that, I am learning to use the amputation technique
in which I use the average yearly salary to replace the null values. 
*/

SELECT 
    job_title_short,
    COALESCE(salary_year_avg, ROUND((SELECT avg(salary_year_avg) FROM job_postings_fact)), 2) as salary_estimate_2,
    COALESCE(salary_year_avg, ROUND((LAG(COALESCE(salary_year_avg, ROUND((SELECT avg(salary_year_avg) FROM job_postings_fact)), 2)) OVER() + LEAD(COALESCE(salary_year_avg, ROUND((SELECT avg(salary_year_avg) FROM job_postings_fact)), 2)) OVER()) / 2), 2) AS salary_estimate3,
    ROW_NUMBER() OVER() as row_num,
    LAG(COALESCE(salary_year_avg, ROUND((SELECT avg(salary_year_avg) FROM job_postings_fact)), 2)) OVER() as prior_value, 
    LEAD(COALESCE(salary_year_avg, ROUND((SELECT avg(salary_year_avg) FROM job_postings_fact)), 2)) OVER() as lead_value 
FROM job_postings_fact
WHERE
    job_title_short like '%Data Analyst%';

