/*
Questions: What skills are required for the top-paying data analyst jobs?
- Uses the top 10 highest-paying Data Analyst jobs from first query
- Add the specified skills requerid for these roles.
- Why? It provides a detailed look at which high-paying jobs demand certain skills,
    helping job seekers undertand which skills to develop that align with top salaries 
*/

/*
Preguntas: ¿Qué habilidades se requieren para los trabajos de analista de datos mejor remunerados?
- Utiliza los 10 trabajos de analista de datos mejor remunerados de la primera consulta
- Agrega las habilidades especificadas requeridas para estos puestos.
- ¿Por qué? Proporciona una visión detallada de qué trabajos bien remunerados exigen determinadas habilidades,
lo que ayuda a los solicitantes de empleo a comprender qué habilidades desarrollar que se alineen con los salarios más altos. 
*/


-- Seleccionar campos a mostrar 
SELECT
    top_paying_jobs.*,
    skills
FROM ( -- Subquery para obtener lo 10 trabajos mejor remunerados
    SELECT
        job_id,
        job_title AS jobs,
        job_location AS location,
        cd.name AS company,
        job_schedule_type AS schedule,
        salary_year_avg,
        job_posted_date
    FROM
        job_postings_fact AS jpf
    JOIN company_dim cd ON jpf.company_id = cd.company_id
    -- Filtrar para obtener solo los datos necesarios
    WHERE
        salary_year_avg IS NOT NULL AND -- Descartar los 'nulos' porque son los primeros en ser mostrados si se mantinen
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere'
    -- Ordenar por salario
    ORDER BY
        salary_year_avg DESC
        -- Mostrar las 10 ofertas mejor remuneradas
    LIMIT 10
    ) AS top_paying_jobs
-- Join para obtener las habilidades requeridas 
JOIN skills_job_dim sjd ON top_paying_jobs.job_id = sjd.job_id
JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
ORDER BY
    salary_year_avg DESC






/* Query del curso:
WITH top_paying_jobs AS
(
    SELECT
        job_id,
        job_title AS jobs,
        cd.name AS company,
        salary_year_avg
    FROM
        job_postings_fact AS jpf
    LEFT JOIN company_dim cd ON jpf.company_id = cd.company_id
    WHERE
        salary_year_avg IS NOT NULL AND
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere'
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT
    tpj.*,
    skills
FROM top_paying_jobs AS tpj
JOIN skills_job_dim sjd ON tpj.job_id = sjd.job_id
JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
ORDER BY
 salary_year_avg DESC
 */