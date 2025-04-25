/*
Answer: What are the most optimal skills to learn (aka it's in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
    offering strategic insights for career development in data analysis
*/

/*
Respuesta: ¿Cuáles son las habilidades más óptimas para aprender (es decir, que tienen una gran demanda y son habilidades bien remuneradas)?
- Identificar habilidades con una gran demanda y asociadas con salarios promedio altos para puestos de analista de datos
- Concentrarse en puestos remotos con salarios específicos
- ¿Por qué? Se enfoca en habilidades que ofrecen seguridad laboral (alta demanda) y beneficios financieros (salarios altos),
ofreciendo perspectivas estratégicas para el desarrollo profesional en análisis de datos
*/

-- Luke´s query1

WITH skills_demand AS(
        SELECT
            sjd.skill_id,
            sd.skills,  
            COUNT(sjd.job_id) AS demand_count
        FROM
            job_postings_fact AS jpf
        JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
        JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
        WHERE
            job_title_short = 'Data Analyst' AND
            salary_year_avg IS NOT NULL AND
            job_location = 'Anywhere'
        GROUP BY
            sjd.skill_id, sd.skills
), average_salary AS (
    SELECT
        sjd.skill_id,
        sd.skills,  
        ROUND(AVG (salary_year_avg),0) AS avg_salary
    FROM
        job_postings_fact AS jpf
    JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
    JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_location = 'Anywhere'
    GROUP BY
        sjd.skill_id, sd.skills
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM 
    skills_demand
JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
   demand_count > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;



----- Usar los queris anteriores y ajustarlos para puestos remotos en CTE

-- Habilidades más demandadas para analista de datos

WITH demand_skills AS (
    SELECT
        sd.skills,
        sjd.skill_id,  
        COUNT(*) AS demand_count
    FROM
        job_postings_fact AS jpf
        JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
        JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_location = 'Anywhere'
    GROUP BY
        skills, sjd.skill_id
    ORDER BY
        demand_count DESC
    LIMIT 100
),

-- Salario pormedio anual por habilidad

paying_skills AS (
    SELECT
        sd.skills,
        sjd.skill_id, 
        ROUND(AVG (salary_year_avg),0) AS avg_salary
    -- Tabla resultante después de join
    FROM
        job_postings_fact AS jpf
        JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
        JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
    -- Filtrar para obtener los datos deseados 
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_location = 'Anywhere'
    GROUP BY
        skills, sjd.skill_id
    ORDER BY
        avg_salary DESC
    LIMIT 100
)

SELECT
    demand_skills.skill_id,
    demand_skills.skills,
    demand_count,
    avg_salary
FROM 
    demand_skills
JOIN paying_skills ON demand_skills.skill_id = paying_skills.skill_id
WHERE
   demand_count > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 100;

