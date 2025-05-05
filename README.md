# Introducción

Este repositorio forma parte de un proyecto desarrollado en el marco del curso de 📊 SQL for Data Analytics de [Luke Barousse](https://www.youtube.com/watch?v=7mz73uXD9DA&list=PL_CkpxkuPiT-RJ7zBfHVWwgltEWIVwrwb&index=35), con el objetivo de aplicar conocimientos prácticos en análisis de datos a partir de fuentes reales relacionadas con el mercado laboral TI.

Durante el proyecto se analizan datos recopilados en 2023 sobre ofertas de empleo, habilidades requeridas y niveles salariales en el sector tecnológico, con un enfoque particular en los perfiles de analistas de datos, a través de consultas SQL, se identifican las habilidades técnicas más demandadas y mejor remuneradas.

El propósito final es obtener una visión clara y accionable sobre qué competencias son clave para desarrollarse profesionalmente como **Analista de Datos** y cómo orientar la formación técnica en base a datos reales del sector.

Mira las consultas aqui: [SQL_proyecto ](/SQL_proyecto/)


# Antecedentes

Dada la necesidad de continuar mi 📚 aprendizaje como analista de datos y adquirir experiencia válida sin estar trabajando activamente en el área, busqué formas alternativas de desarrollar esta experiencia. Fue así como encontré este curso, el cual no solo me permitió practicar y fortalecer mis habilidades en SQL, sino que también me brindó una visión clara sobre las competencias más demandadas y mejor remuneradas en el mercado laboral actual.

## Las preguntas que se responden con las consultas SQL son:

1.- ¿Cuáles son los puestos de analista de datos mejor pagados?

2.- ¿Qué habilidades se requieren para estos puestos?

3.- ¿Cuáles son las habilidades más demandadas para los analistas de datos?

4.- ¿Qué habilidades se asocian con salarios más altos?

5.- ¿Cuáles son las habilidades más recomendables para aprender?


# Herramientas Utilizadas

- **SQL:** Lo utilicé para consultar la base de datos y obtener la información requerida.

- **PostgreSQL:** Usé este sistema de gestión de bases de datos, que ya había trabajado durante el bootcamp y que se vuelve a considerar en el curso.

- **Visual Studio Code:** Aprendí a utilizar este editor de código, que me permitió gestionar bases de datos, ejecutar consultas SQL y publicar en GitHub.

- **Git y GitHub:** También fueron herramientas nuevas para mí; permiten compartir mis scripts y análisis en SQL.

- **Jupyter Notebook:** Pegué y adecué el código generado por la IA para crear imágenes, utilizando las librerías: pandas, matplotlib y seaborn de Python

-**ChatGPT:** Lo usé para crear el código Python para generar las imágenes.

-**Tableau:** Herramienta de visualización.


# Análisis

Las consultas de este proyecto tenían como 🧪  objetivo investigar aspectos específicos del mercado laboral para analistas de datos.

### 1.- ¿Cuáles son los puestos de analista de datos mejor pagados?
Para identificar las ofertas mejor remunerados, filtré las mismas por analista de datos (Data Analyst), salario promedio anual NOT NULL (salary_year_avg IS NOT NULL) y ubicación cosiderando solo los trabajos remotos (anywhere).  

````SQL
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
    salary_year_avg IS NOT NULL AND -- Descartar los 'nulos' porque son los primeros en ser mostrados si se mantienen
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere'
-- Ordenar por salario
ORDER BY
    salary_year_avg DESC
-- Mostrar las 10 ofertas mejor remuneradas
LIMIT 10;
````
Se puede observar:

- Amplia gama salarial: Los 10 puestos de analista de datos mejor pagados oscilan entre 184.000 USD/año y $650.000 USD/año, lo que representa una interesante oferta para latinoamericanos.

- Variedad de puestos: Los puestos van desde analista de datos pasando por principal hasta director de análisis, lo que refleja diversas funciones y especializaciones dentro del análisis de datos.

![top_paying_jobs](assets\1_top_paying_jobs_Python.png)
*Gráfico de barras de los 10 mejores salarios para analistas de datos; ChatGPT generó el código para generar el gráfico a partir de los resultados de mi consulta en SQL*


### 2.- ¿Qué habilidades se requieren para estos puestos?
Para identificar las habilidades requeridas por las ofertas mejor remunerados, usé la consulta de la pregunta 1 para crear una subconsulta donde se obtiene las 10 ofertas mejor remuneradas (top_paying_jobs) y los resultados de ésta se unieron con las tablas necesarias para obtener las habilidades.

````sql
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
    WHERE
        salary_year_avg IS NOT NULL AND
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere'
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
    ) AS top_paying_jobs
-- Join para obtener las habilidades requeridas 
JOIN skills_job_dim sjd ON top_paying_jobs.job_id = sjd.job_id
JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
ORDER BY
    salary_year_avg DESC
````
Se puede observar:

Habilidades más demandadas: SQL, Python y Tableau encabezan las habilidades requeridas por las ofertas para trabajo remoto mejor pagadas en el 2023.

![top_paying_job_skills](assets\2_top_paying_job_skills.png)
*Gráfico de barras de las habilidades requeridas por los 10 mejores salarios para analistas de datos; ChatGPT generó el código para generar el gráfico a partir de los resultados de mi consulta en SQL*


### 3.- ¿Cuáles son las habilidades más demandadas para los analistas de datos?
Uní las tablas hasta tener ofertas y habilidades juntas, filtré por analista de datos, agrupé por habilidades y las conté con la función de agregación COUNT.

````sql
SELECT
    skills,  
    COUNT(*) AS count
    FROM
        job_postings_fact AS jpf
    JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
    JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
    WHERE
    job_title_short = 'Data Analyst'AND
    job_work_from_home = 'TRUE'
GROUP BY
    skills
ORDER BY
    count DESC
LIMIT 5;
````

- **Herramientas de análisis:** 
SQL, Excel y Python.
- **Herramientas de visualización:** 
Tableau y Power BI.

![top_demanded_skills](assets\3_top_demanded_skills.png)
*Gráfico de barras de las 5 habilidades más requeridas para analistas de datos en trabajos remotos; ChatGPT generó el código para generar el gráfico a partir de los resultados de mi consulta en SQL*

### 4.- ¿Qué habilidades se asocian con salarios más altos?
Uní las tablas para tener las ofertas, las habilidades y los salarios juntos y poder luego ordenar.

````sql
-- Campos a mostrar
SELECT
  skills,  
  ROUND(AVG (salary_year_avg),0) AS avg_salary
-- Tabla resultante después del join
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
````
Las habilidades mejor pagadas son poco demandadas.

| Habilidad   | Salario Promedio (USD) |
|-------------|----------------------|
| svn         | 400000               |
| solidity    | 179000               |
| couchbase   | 160515               |
| datarobot   | 155486               |
| golang      | 155000               |
| mxnet       | 149000               |
| dplyr       | 147633               |
| vmware      | 147500               |
| terraform   | 146734               |
| twilio      | 138500               |


### 5.- ¿Cuáles son las habilidades más recomendables para aprender?
Uní los resultados de las dos preguntas anteriores para tener lo que considero las habilidades más recomendables para aprender, trabajos remotos.

````sql
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
    FROM
        job_postings_fact AS jpf
        JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
        JOIN skills_dim sd ON sjd.skill_id = sd.skill_ids 
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
````
Tenemos las 37 habilidades más demandadas para analistas de datos con sus salarios.

Mira el gráfico público en [Tableau](https://public.tableau.com/views/Habilidadesysalariosparaanalistasdedatos2023/Dashboard1?:language=en-GB&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

![Salarios_Habilidades](assets\Salarios_Habilidades.png)
*Mapa de calor que relaciona las habilidades más demandadas con sus salarios; usé Tableau para generar el gráfico a partir de los resultados de mi consulta en SQL*

# ¿Qué Aprendí?

**🧩 Creación de consultas avanzadas:** Mejoré mi capacidad para crear consultas avanzadas en SQL, utilizando subconsultas, uniendo tablas con JOIN y creando tablas temporales con WITH.

**📊 Funciones de agregación:** Utilicé funciones de agregación como COUNT() y AVG() que junto con la cláusulas GROUP BY y ORDER BY que me permitieron obtener información relevante.

**💡 Resolución de problemas:** Ejercité el pensamiento lógico y la resolución de problemas, convertiendo preguntas del mundo real en consultas en SQL, transformando los datos en información accionable.

**🔧 Nuevas técnicas de visualización:** Integré  ChatGPT como herramienta de apoyo en análisis y visualización junto con Jupyter Notebook y usé Tableau  someramente.

# Conclusiones

Las conclusiones que permiten establecer o seguir una ruta de aprendizaje para analista de datos.

**1. La más demandada:** Es SQL la herramienta por excelencia que todo analista debe incluir en su satck tecnológico.

**2. Las otras más demandadas:** Por orden de demanda siguen: Excel, Python, Tableau, R, SAS (Statistical Analysis System) y Power BI entre las 7 más demandadas.

**3. Las mejor pagadas:** De las 37 más demandadas la mejor pagada es SAS, las otras mejor pagadas son Go, Confluence, Hadoop, Snowflake, Azure y Bigquery, se pueden considerar para aprendizaje a futuro.

**4. Top de pagos:** Finalmente hay una herramienta premium fuera del grupo de las 37, por la posibilidad de pago que la misma representa SVN, 400.000 USD/año.



