/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and 
    helps identify the most financially rewarding skills to acquire or improve
*/

/*
Respuesta: ¿Cuáles son las principales habilidades en función del salario?
- Observa el salario promedio asociado con cada habilidad para los puestos de analista de datos
- Se centra en puestos con salarios específicos, independientemente de la ubicación
- ¿Por qué? Revela cómo las diferentes habilidades afectan los niveles salariales de los analistas de datos y
ayuda a identificar las habilidades más gratificantes económicamente para adquirir o mejorar
*/


-- Campos a mostrar
SELECT
  skills,  
  ROUND(AVG (salary_year_avg),0) AS avg_salary
-- Tabla resultante después de join
FROM
  job_postings_fact AS jpf
  JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
  JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
-- Filtrar para obtener los datos deseados 
WHERE
  job_title_short = 'Data Analyst' AND
  salary_year_avg IS NOT NULL
GROUP BY
  skills
ORDER BY
  avg_salary DESC
LIMIT 25;

/*
Salario pormedio anual por habilidad:
[
  {
    "skills": "svn",
    "avg_salary": "400000"
  },
  {
    "skills": "solidity",
    "avg_salary": "179000"
  },
  {
    "skills": "couchbase",
    "avg_salary": "160515"
  },
  {
    "skills": "datarobot",
    "avg_salary": "155486"
  },
  {
    "skills": "golang",
    "avg_salary": "155000"
  },
  {
    "skills": "mxnet",
    "avg_salary": "149000"
  },
  {
    "skills": "dplyr",
    "avg_salary": "147633"
  },
  {
    "skills": "vmware",
    "avg_salary": "147500"
  },
  {
    "skills": "terraform",
    "avg_salary": "146734"
  },
  {
    "skills": "twilio",
    "avg_salary": "138500"
  },
  {
    "skills": "gitlab",
    "avg_salary": "134126"
  },
  {
    "skills": "kafka",
    "avg_salary": "129999"
  },
  {
    "skills": "puppet",
    "avg_salary": "129820"
  },
  {
    "skills": "keras",
    "avg_salary": "127013"
  },
  {
    "skills": "pytorch",
    "avg_salary": "125226"
  },
  {
    "skills": "perl",
    "avg_salary": "124686"
  },
  {
    "skills": "ansible",
    "avg_salary": "124370"
  },
  {
    "skills": "hugging face",
    "avg_salary": "123950"
  },
  {
    "skills": "tensorflow",
    "avg_salary": "120647"
  },
  {
    "skills": "cassandra",
    "avg_salary": "118407"
  },
  {
    "skills": "notion",
    "avg_salary": "118092"
  },
  {
    "skills": "atlassian",
    "avg_salary": "117966"
  },
  {
    "skills": "bitbucket",
    "avg_salary": "116712"
  },
  {
    "skills": "airflow",
    "avg_salary": "116387"
  },
  {
    "skills": "scala",
    "avg_salary": "115480"
  }
]
*/