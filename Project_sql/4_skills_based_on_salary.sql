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

/*Here's a breakdown of the results

-
Top pay comes from specialization
The highest salaries aren’t from basic analyst skills—they come from niche or advanced tools, especially those overlapping with engineering or systems work.
Hybrid roles earn more
Skills that combine data analysis with engineering, backend, or DevOps (e.g., Kafka, FastAPI, Terraform) consistently show higher pay.
AI/ML skills are valuable but not top-tier alone
Tools like PyTorch and TensorFlow cluster around similar salaries, suggesting they’re becoming standard rather than standout differentiators.
Data infrastructure skills are highly rewarded
Technologies related to pipelines and data systems (Kafka, Airflow, Cassandra) command strong salaries due to their complexity and demand.
Backend and programming skills are increasingly important
Languages and frameworks like Golang and FastAPI indicate a shift toward analysts needing software development capabilities.
[
  {
    "skills": "svn",
    "average": "400000"
  },
  {
    "skills": "vmware",
    "average": "261250"
  },
  {
    "skills": "yarn",
    "average": "219575"
  },
  {
    "skills": "fastapi",
    "average": "185000"
  },
  {
    "skills": "solidity",
    "average": "179000"
  },
  {
    "skills": "golang",
    "average": "162833"
  },
  {
    "skills": "couchbase",
    "average": "160515"
  },
  {
    "skills": "mxnet",
    "average": "149000"
  },
  {
    "skills": "dplyr",
    "average": "147633"
  },
  {
    "skills": "twilio",
    "average": "138500"
  },
  {
    "skills": "gitlab",
    "average": "134709"
  },
  {
    "skills": "perl",
    "average": "133929"
  },
  {
    "skills": "puppet",
    "average": "129820"
  },
  {
    "skills": "datarobot",
    "average": "128993"
  },
  {
    "skills": "kafka",
    "average": "128983"
  },
  {
    "skills": "terraform",
    "average": "127940"
  },
  {
    "skills": "pytorch",
    "average": "124956"
  },
  {
    "skills": "nltk",
    "average": "124875"
  },
  {
    "skills": "hugging face",
    "average": "123950"
  },
  {
    "skills": "keras",
    "average": "123897"
  },
  {
    "skills": "tensorflow",
    "average": "122242"
  },
  {
    "skills": "rust",
    "average": "122040"
  },
  {
    "skills": "airflow",
    "average": "121658"
  },
  {
    "skills": "atlassian",
    "average": "118916"
  },
  {
    "skills": "cassandra",
    "average": "118309"
  }
]


*/