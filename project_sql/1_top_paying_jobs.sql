/*
Question: What ML jobs are the highest earning?
- Identify the top 10 highest ML roles that are available remotely with the companies who are offering the role.
- Discard null values (for salary fields).
- Why? By getting the resulting table, we can glean insights into the most valuable skills, employement options, and more.
*/
SELECT 
    job_id,
    job_title,
    companies.name as company_name,
    job_location,
    job_schedule_type,
    salary_year_avg
FROM job_postings_fact as roles 
    LEFT JOIN company_dim as companies ON roles.company_id = companies.company_id
WHERE (LOWER(job_title) LIKE '%machine learning%') AND 
    (job_work_from_home IS TRUE) AND 
    (salary_year_avg IS NOT NULL)
ORDER BY 
    salary_year_avg DESC 
LIMIT 10

