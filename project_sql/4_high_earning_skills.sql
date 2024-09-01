/*
Question: Which Machine Learning related skills are most optimal? The possession of which skills 
contribute to the highest salaries?
- There's an interest in seeing which skills may seperate or distinguish ones earning potential.
*/

SELECT 
    skills,
    ROUND(AVG(job_postings_fact.salary_year_avg),0) as average_salary
FROM job_postings_fact 
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    LOWER(job_title) LIKE '%machine learning%' AND
    salary_year_avg IS NOT NULL
GROUP BY 
    skills
ORDER BY 
    average_salary DESC
LIMIT 20
 
 /*
1. Programming Languages and Tools Dominate: The top-earning skills are heavily skewed 
toward programming languages such as Haskell, Kotlin, Clojure, Golang, Swift, Scala, Rust, and Julia, 
as well as tools like Chef and Redis.

2. Data and Spreadsheet Proficiency: Skills related to data manipulation and spreadsheet tools, 
including Sheets, Spreadsheet, Excel, Looker, Postgresql, Redshift, and BigQuery, are highly valued, 
showing the importance of data analysis and management.

3. Modern Development and Collaboration: Expertise in modern development environments 
(e.g., TypeScript, Airflow) and collaboration tools (e.g., Slack) also command high salaries, 
reflecting the need for efficient, scalable, and collaborative software development practices.
 */