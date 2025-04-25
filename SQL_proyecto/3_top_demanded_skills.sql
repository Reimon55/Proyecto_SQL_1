/*
Question: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
Why? Retrieves the top 5 skills with the highest demand in the job market, 
    providing insights into the most valuable skills for job seekers.
*/

/*
Pregunta: ¿Cuáles son las habilidades más demandadas para los analistas de datos?
- Aplicar Join a las tres tablas, para cruzar ofertas y habilidades
- Identificar las 5 habilidades más demandadas para un analista de datos.
- Centrarse en todas las ofertas de trabajo.
¿Por qué? Obtener las 5 habilidades más demandadas en el mercado laboral, 
proporciona información sobre las habilidades más valiosas para quienes buscan trabajo.
*/


SELECT
    skills,  
    COUNT(*) AS count
    FROM
        job_postings_fact AS jpf
    JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
    JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
    WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    skills
ORDER BY
    count DESC
LIMIT 5;

/*
Habilidades más demandadas para analista de datos:
[
  {
    "skills": "sql",
    "count": "92628"
  },
  {
    "skills": "excel",
    "count": "67031"
  },
  {
    "skills": "python",
    "count": "57326"
  },
  {
    "skills": "tableau",
    "count": "46554"
  },
  {
    "skills": "power bi",
    "count": "39468"
  }
]
*/

