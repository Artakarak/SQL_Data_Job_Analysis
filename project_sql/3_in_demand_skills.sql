/*
- Taking a step back to observe the most in demand skills for Machine Learning related roles for all types, 
not just remote or highest earning.
*/
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) as DEMAND
FROM job_postings_fact 
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    LOWER(job_title) LIKE '%machine learning%'
GROUP BY 
    skills
ORDER BY 
    DEMAND DESC
LIMIT 5

/*
The demand for each skill follows the following order:
1. Python
2. Tensorflow
3. Pytorch
4. SQL
5. AWS
*/