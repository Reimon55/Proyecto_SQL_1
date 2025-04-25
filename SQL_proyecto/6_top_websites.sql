/*
Question: Which websites list the largest number of job offers?
- Join the job postings table with the website/source table using an inner join, similar to query 2.
- Group by website or job source and count the number of postings.
- Return the top 5 websites with the most job listings.
Why? Identifies the most active job platforms, helping job seekers and 
analysts understand where most opportunities are posted and which websites dominate the job market.
*/

/*
Pregunta: ¿Qué sitios web tienen la mayor cantidad de ofertas de trabajo?
- Une la tabla de ofertas laborales con la tabla de sitios web o fuentes mediante un inner join, similar a la consulta 2.
- Agrupa por sitio web o fuente de empleo y cuenta la cantidad de publicaciones.
- Devuelve los 5 sitios web con más ofertas publicadas.
¿Por qué? Permite identificar las plataformas de empleo más activas, ayudando a los buscadores de empleo y 
analistas a entender dónde se concentran más oportunidades y qué sitios dominan el mercado laboral
*/


SELECT
    job_via,  
    COUNT(*) AS count
    FROM
        job_postings_fact AS jpf
    --JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
    --JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
    WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE
GROUP BY
    job_via
ORDER BY
    count DESC
LIMIT 10;

/*
-- Top websites

[
  {
    "job_via": "via LinkedIn",
    "count": "7026"
  },
  {
    "job_via": "via Indeed",
    "count": "1339"
  },
  {
    "job_via": "via ZipRecruiter",
    "count": "796"
  },
  {
    "job_via": "via Recruit.net",
    "count": "419"
  },
  {
    "job_via": "via Jobgether",
    "count": "407"
  },
  {
    "job_via": "via Snagajob",
    "count": "293"
  },
  {
    "job_via": "via Get.It",
    "count": "245"
  },
  {
    "job_via": "via HelloWork",
    "count": "215"
  },
  {
    "job_via": "via JobTeaser",
    "count": "173"
  },
  {
    "job_via": "via Totaljobs",
    "count": "146"
  }
]
*/