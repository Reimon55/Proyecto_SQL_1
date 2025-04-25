/*
Questions: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available remotly.
- Focuses on job postings with specified salaries (remove nulls).
- Why? Highlight the top paying opportunities for Data Analysts, offering insights into employes 
*/

/*
Preguntas: ¿Cuáles son los trabajos de 'Analista de Datos' mejor remunerados?
- Identifique los 10 puestos de analista de datos mejor remunerados que están disponibles de forma remota.
- Se centra en las ofertas de trabajo con salarios específicos (elimine los nulls).
- ¿Por qué? Resalta las oportunidades mejor remuneradas para analistas de datos
*/

-- Seleccionar los campos a mostrar
SELECT
    job_id,
    job_title AS jobs,
    job_location AS location,
    cd.name AS company,
    job_schedule_type AS schedule,
    salary_year_avg,
    job_posted_date
-- Tablas de donde se extraerán los datos para análisis y los JOIN necesarios
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
LIMIT 10;

