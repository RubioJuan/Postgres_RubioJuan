-- ######################
-- ### Procedimientos ###
-- ######################

-- 1. Procedimiento para Crear un Alumno
CREATE OR REPLACE PROCEDURE crear_alumno(
    nif_param VARCHAR, nombre_param VARCHAR, apellido1_param VARCHAR, apellido2_param VARCHAR,
    ciudad_param VARCHAR, direccion_param VARCHAR, telefono_param VARCHAR, 
    fecha_nacimiento_param DATE, sexo_param sexo)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO alumno (nif, nombre, apellido1, apellido2, ciudad, direccion, telefono, fecha_nacimiento, sexo)
    VALUES (nif_param, nombre_param, apellido1_param, apellido2_param, ciudad_param, direccion_param, telefono_param, fecha_nacimiento_param, sexo_param);
END;
$$;

-- 2. Procedimiento para Actualizar el Teléfono de un Alumno
CREATE OR REPLACE PROCEDURE actualizar_telefono_alumno(
    id_alumno INT, nuevo_telefono VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE alumno
    SET telefono = nuevo_telefono
    WHERE id = id_alumno;
END;
$$;

-- 3. Procedimiento para Eliminar un Profesor
CREATE OR REPLACE PROCEDURE eliminar_profesor(id_profesor_param INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM profesor WHERE id_profesor = id_profesor_param;
END;
$$;

-- 4. Procedimiento para Buscar Alumno por NIF
CREATE OR REPLACE PROCEDURE buscar_alumno_por_nif(nif_param VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT * FROM alumno WHERE nif = nif_param;
END;
$$;

-- 5. Procedimiento para Crear una Asignatura
CREATE OR REPLACE PROCEDURE crear_asignatura(
    nombre_param VARCHAR, creditos_param FLOAT, tipo_param tipo_asignatura4, 
    curso_param SMALLINT, cuatrimestre_param SMALLINT, id_profesor_param INT, id_grado_param INT)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO asignatura (nombre, creditos, tipo, curso, cuatrimestre, id_profesor, id_grado)
    VALUES (nombre_param, creditos_param, tipo_param, curso_param, cuatrimestre_param, id_profesor_param, id_grado_param);
END;
$$;

-- 6. Procedimiento para Actualizar el Departamento de un Profesor
CREATE OR REPLACE PROCEDURE actualizar_departamento_profesor(
    id_profesor_param INT, id_departamento_nuevo INT)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE profesor
    SET id_departamento = id_departamento_nuevo
    WHERE id_profesor = id_profesor_param;
END;
$$;

-- 7. Procedimiento para Eliminar una Asignatura
CREATE OR REPLACE PROCEDURE eliminar_asignatura(id_asignatura_param INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM asignatura WHERE id = id_asignatura_param;
END;
$$;

-- 8. Procedimiento para Buscar Profesores sin Departamento
CREATE OR REPLACE PROCEDURE buscar_profesores_sin_departamento()
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT * FROM profesor WHERE id_departamento IS NULL;
END;
$$;

-- 9. Procedimiento para Crear un Departamento
CREATE OR REPLACE PROCEDURE crear_departamento(nombre_param VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO departamento (nombre)
    VALUES (nombre_param);
END;
$$;

-- 10. Procedimiento para Actualizar el Nombre de una Asignatura
CREATE OR REPLACE PROCEDURE actualizar_nombre_asignatura(id_asignatura_param INT, nuevo_nombre VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE asignatura
    SET nombre = nuevo_nombre
    WHERE id = id_asignatura_param;
END;
$$;