/* Practice for Unions 
-Union combines results from two or more select sttements
-They need to have the same amount of columns, and the data type must match
*/

SELECT 
    job_title_short,
    company_id,
    job_location
FROM january_jobs

UNION

--Get jobs and companies from Febuary

SELECT 
    job_title_short,
    company_id,
    job_location
FROM february_jobs

UNION
-- Add in all march jobs

SELECT 
    job_title_short,
    company_id,
    job_location
FROM march_jobs

/*
Union All operator also comines the result of two or mroe select statments
- This operator returns all rows, even duplicates(Unlike Union)
-Mostly use this to combine two tables together 
*/


SELECT 
    job_title_short,
    company_id,
    job_location
FROM january_jobs

UNION ALL

--Get jobs and companies from Febuary

SELECT 
    job_title_short,
    company_id,
    job_location
FROM february_jobs

UNION ALL
-- Add in all march jobs

SELECT 
    job_title_short,
    company_id,
    job_location
FROM march_jobs
