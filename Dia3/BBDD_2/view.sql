-- ############
-- ### View ###
-- ############

-- 1. Vista de Alumnas Matriculadas en el Grado en Ingeniería Informática
CREATE VIEW vista_alumnas_informatica AS
SELECT a.nombre, a.apellido1, a.apellido2, a.nif
FROM alumno a
JOIN alumno_se_matricula_asignatura am ON a.id = am.id_alumno
JOIN asignatura asig ON am.id_asignatura = asig.id
JOIN grado g ON asig.id_grado = g.id
WHERE a.sexo = 'M' AND g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

-- 2. Vista de Asignaturas en el Grado en Ingeniería Informática
CREATE VIEW vista_asignaturas_informatica AS
SELECT asig.nombre
FROM asignatura asig
JOIN grado g ON asig.id_grado = g.id
WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

-- 3. Vista de Profesores con sus Departamentos
CREATE VIEW vista_profesores_departamento AS
SELECT p.apellido1, p.apellido2, p.nombre, d.nombre AS departamento
FROM profesor p
LEFT JOIN departamento d ON p.id_departamento = d.id;

-- 4. Vista de Asignaturas con Año de Inicio y Fin de Alumno con NIF Específico
CREATE VIEW vista_asignaturas_alumno_nif AS
SELECT asig.nombre, ce.anyo_inicio, ce.anyo_fin
FROM alumno a
JOIN alumno_se_matricula_asignatura am ON a.id = am.id_alumno
JOIN asignatura asig ON am.id_asignatura = asig.id
JOIN curso_escolar ce ON am.id_curso_escolar = ce.id
WHERE a.nif = '26902806M';

-- 5. Vista de Departamentos con Profesores
CREATE VIEW vista_departamentos_con_profesores AS
SELECT d.nombre AS departamento, COUNT(p.id_profesor) AS numero_profesores
FROM departamento d
LEFT JOIN profesor p ON d.id = p.id_departamento
GROUP BY d.nombre;

-- 6. Vista de Grados con Asignaturas
CREATE VIEW vista_grados_con_asignaturas AS
SELECT g.nombre AS grado, COUNT(asig.id) AS numero_asignaturas
FROM grado g
LEFT JOIN asignatura asig ON g.id_grado = asig.id_grado
GROUP BY g.nombre;

-- 7. Vista de Créditos por Tipo de Asignatura en Cada Grado
CREATE VIEW vista_creditos_por_tipo AS
SELECT g.nombre AS grado, asig.tipo AS tipo_asignatura, SUM(asig.creditos) AS total_creditos
FROM grado g
JOIN asignatura asig ON g.id = asig.id_grado
GROUP BY g.nombre, asig.tipo;

-- 8. Vista de Alumnos Matriculados por Año Escolar
CREATE VIEW vista_alumnos_por_curso AS
SELECT ce.anyo_inicio, COUNT(DISTINCT am.id_alumno) AS numero_alumnos_matriculados
FROM curso_escolar ce
JOIN alumno_se_matricula_asignatura am ON ce.id = am.id_curso_escolar
GROUP BY ce.anyo_inicio;

-- 9. Vista de Profesores y Número de Asignaturas
CREATE VIEW vista_profesores_asignaturas AS
SELECT p.id_profesor, p.nombre, p.apellido1, p.apellido2, COUNT(asig.id) AS numero_asignaturas
FROM profesor p
LEFT JOIN asignatura asig ON p.id_profesor = asig.id_profesor
GROUP BY p.id_profesor, p.nombre, p.apellido1, p.apellido2;

-- 10. Vista de Alumnos que Nacieron en 1999
CREATE VIEW vista_alumnos_nacidos_1999 AS
SELECT *
FROM alumno
WHERE EXTRACT(YEAR FROM fecha_nacimiento) = 1999;