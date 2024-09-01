/*
Define optimal to be the highest in demand and highest paying. Which skill is the most optimal(with demand given precedent)? 
*/

-- CTE method.

WITH skills_demand AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) as DEMAND
    FROM job_postings_fact 
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        LOWER(job_title) LIKE '%machine learning%' AND 
        salary_year_avg IS NOT NULL
    GROUP BY 
        skills_dim.skill_id, skills
), average_salary AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        ROUND(AVG(job_postings_fact.salary_year_avg),0) as avg_salary
    FROM job_postings_fact 
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        LOWER(job_title) LIKE '%machine learning%' AND
        salary_year_avg IS NOT NULL
    GROUP BY 
        skills_dim.skill_id, skills
)
SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    DEMAND,
    avg_salary
FROM skills_demand 
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
ORDER BY 
    DEMAND DESC,
    avg_salary DESC
LIMIT 15; 

-- Concise method. In this case, salary is given precedent.

SELECT
    skills_dim.skills AS SKILL,
    COUNT(skills_job_dim.job_id) AS DEMAND_COUNT,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    salary_year_avg IS NOT NULL AND
    LOWER(job_title) LIKE '%machine learning%'
GROUP BY
    SKILL
HAVING 
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    DEMAND_COUNT DESC
LIMIT 25;
