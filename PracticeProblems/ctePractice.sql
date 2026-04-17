/*
Find the count of the number of remote job postings per skill
    - Display the top 5 skills by their demand in remote jobs
    -Include skill ID, name, and count of postings reuiring the skill
*/

-- This was my version which work correctly

SELECT
    sjd.skill_id,
    sd.skills as skill_name,
    COUNT(sjd.job_id) as count
FROM
    skills_job_dim as sjd
INNER JOIN job_postings_fact as jpf on sjd.job_id = jpf.job_id
INNER JOIN skills_dim as sd on sjd.skill_id = sd.skill_id
WHERE    
    jpf. job_location = 'Anywhere'
GROUP BY
    sjd.skill_id,
    sd.skills
Order BY
    count DESC
LIMIT 5;

-- Here is the teachers version, with a CTE 

With remote_jobs_skills AS (
    Select
        skill_id,
        COUNT(*) as skill_count
    FROM
        skills_job_dim as sjd
    INNER JOIN job_postings_fact as jpf on sjd.job_id = jpf.job_id
    WHERE
        jpf.job_work_from_home = True AND
        jpf.job_title_short = 'Data Analyst'
    GROUP BY
        skill_id
)

SELECT 
    sd.skill_id,
    sd.skills,
    skill_count
FROM remote_jobs_skills
INNER JOIN skills_dim as sd on sd.skill_id = remote_jobs_skills.skill_id
ORDER by
    skill_count DESC
LIMIT 5;
