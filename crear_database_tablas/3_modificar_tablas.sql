/* ⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️

**RECORDATORIO PARA MI: CUANDO INDIQUE PERMISO DENEGADO PARA ACCEDER A LOS ARCHIVOS CSV**

Database Load Issues (follow if receiving permission denied when running SQL code below)

NOTE: If you are having issues with permissions. And you get error: 

Error al cargar desde el query: 'could not open file "[your file path]\job_postings_fact.csv" for reading: Permission denied.'

1. Open pgAdmin (Abra paAdmin)
2. In Object Explorer (left-hand pane), navigate to `sql_course` database (en el panel izquierdo, navegue hasta la base de datos 'sql_course')
3. Right-click `sql_course` and select `PSQL Tool` (haga click derecho sobre 'sql_course' y seleccione 'PSQL Tool')
    - This opens a terminal window to write the following code (esto abre una ventana para escribir el siguiente código)
4. Get the absolute file path of your csv files (consiga la ruta completa al archivo csv)
    1. Find path by right-clicking a CSV file in VS Code and selecting “Copy Path” (encuentre la ruta haciendo click derecho en el archivo en VS Code y seleccione 'copy path')
5. Paste the following into `PSQL Tool`, (with the CORRECT file path) (pegue el siguiente código en la ventana de 'PSQL Tool' con la ruta correcta)

\copy company_dim FROM 'C:\Users\Usuario\Documents\csv_files\company_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy skills_dim FROM 'C:\Users\Usuario\Documents\csv_files\skills_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy job_postings_fact FROM 'C:\Users\Usuario\Documents\csv_files\job_postings_fact.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy skills_job_dim FROM 'C:\Users\Usuario\Documents\csv_files\skills_job_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

*/

-- Carga de datos a partir de csv en las tablas de la base de datos

COPY company_dim
FROM 'C:\Users\Usuario\Documents\csv_files\company_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_dim
FROM 'C:\Users\Usuario\Documents\csv_files\skills_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY job_postings_fact
FROM 'C:\Users\Usuario\Documents\csv_files\job_postings_fact.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_job_dim
FROM 'C:\Users\Usuario\Documents\csv_files\skills_job_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- Mostrar las tablas para comprobar carga

SELECT *
FROM company_dim
LIMIT 10;

SELECT *
FROM skills_dim
LIMIT 10;