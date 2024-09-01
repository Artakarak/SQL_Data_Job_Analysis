/*
Question: What are the most significant skills for the top 10 highest earning remote Machine Learning related roles?
- Using the query from @1_top_paying_jobs.sql to draw the top 10 earners, which we can now connect to derived tables to pull skills.
- Why? Valauble for job-seekers to know which skills to direct their efforts to. 
*/


with top_salaries AS ( 
    SELECT 
        job_id,
        job_title,
        companies.name as company_name,
        salary_year_avg
    FROM job_postings_fact as roles 
        LEFT JOIN company_dim as companies 
            ON roles.company_id = companies.company_id
    WHERE 
        (LOWER(job_title) LIKE '%machine learning%') AND 
        (job_work_from_home IS TRUE) AND 
        (salary_year_avg IS NOT NULL)
    ORDER BY 
        salary_year_avg DESC 
    LIMIT 10
)
-- To just display the skills asscociated with the top jobs.
SELECT 
    skills,
    top_salaries.*
FROM top_salaries 
    INNER JOIN skills_job_dim ON top_salaries.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC

-- Direct counting method.
/*
SELECT 
    skills,
    COUNT(*) AS COUNT
FROM top_salaries 
    INNER JOIN skills_job_dim ON top_salaries.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
GROUP BY skills
ORDER BY COUNT DESC
*/

/*
These results report PYTHON (1), MONGOdb (2) and EXCEL (3) to be the most desired skills.
*/