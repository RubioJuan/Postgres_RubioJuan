-- ##############
-- ### Tablas ###
-- ##############

create database dia2_postgres;

-- Creación de la tabla municipios
CREATE TABLE municipios (
    region VARCHAR(100),
    departamento VARCHAR(100),
    codigo_departamento INT,
    municipio VARCHAR(100),
    codigo_municipio INT
);

-- Creación de la tabla de personas
CREATE TABLE personas (
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    municipio_nacimiento VARCHAR(100),
    municipio_domicilio VARCHAR(100)
);

-- Ver las tablas creadas
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public';

-- Ver la información de la tabla municipios
select * from municipios;

-- Ver la información de la tabla personas
select * from personas;

-- inserciones de la tabla de municipios
-- \COPY municipios (region, departamento, codigo_departamento, municipio,codigo_municipio)  from '/home/p4student/lab_regiones_municipios_departamentos.txt' delimiter ';' csv header;

-- inserciones de la tabla personas
-- \COPY Personas (nombre, apellido, municipio_nacimiento, municipio_domicilio) from '/home/p4student/lab_personas.txt' delimiter ';' csv header;



-- #################
-- ### Consultas ###
-- #################

-- 1- Crear una vista que muestre las regiones con sus respectivos departamentos.
-- En esta vista generar una columna que muestre la cantidad de municipios por cada departamento.
CREATE VIEW vista_regiones_departamentos AS
SELECT 
    region,
    departamento,
    codigo_departamento,
    COUNT(municipio) AS cantidad_municipios
FROM 
    municipios
GROUP BY 
    region, departamento, codigo_departamento;

-- 2- Crear una vista que muestre los departamentos con sus respectivos municipios. En esta vista generar la columna de código de municipio completo, esto es, código de departamento concatenado con el código de municipio, ejemplo:
-- - Código Santander = 68
-- - Código Girón = 307
-- - Código de municipio completo = 68307
 CREATE VIEW vista_departamentos_municipios AS
SELECT 
    departamento,
    municipio,
    CONCAT(LPAD(codigo_departamento::TEXT, 2, '0'), LPAD(codigo_municipio::TEXT, 3, '0')) AS codigo_municipio_completo
FROM 
    municipios;

-- 3- Agregar dos columnas a la tabla de municipios que permitan llevar el conteo de personas que viven 
-- y trabajan en cada municipio, y con base en esas columnas, implementar un disparador 
-- que actualice esos conteos toda vez que se agregue,
-- modifique o elimine un dato de municipio de nacimiento y/o de domicilio.
ALTER TABLE municipios
ADD COLUMN conteo_viven INT DEFAULT 0,
ADD COLUMN conteo_trabajan INT DEFAULT 0;

-- Trigger para actualización tras una inserción
CREATE OR REPLACE FUNCTION actualizar_conteo_insert() RETURNS TRIGGER AS $$
BEGIN
    -- Incrementar el conteo de personas que viven en el municipio de domicilio
    UPDATE municipios
    SET conteo_viven = conteo_viven + 1
    WHERE municipio = NEW.municipio_domicilio;

    -- Incrementar el conteo de personas que trabajan en el municipio (asumido el domicilio como lugar de trabajo)
    UPDATE municipios
    SET conteo_trabajan = conteo_trabajan + 1
    WHERE municipio = NEW.municipio_domicilio;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_insertar_persona
AFTER INSERT ON personas
FOR EACH ROW
EXECUTE FUNCTION actualizar_conteo_insert();

-- Trigger para actualización tras una eliminación
CREATE OR REPLACE FUNCTION actualizar_conteo_delete() RETURNS TRIGGER AS $$
BEGIN
    -- Decrementar el conteo de personas que viven en el municipio de domicilio
    UPDATE municipios
    SET conteo_viven = conteo_viven - 1
    WHERE municipio = OLD.municipio_domicilio;

    -- Decrementar el conteo de personas que trabajan en el municipio
    UPDATE municipios
    SET conteo_trabajan = conteo_trabajan - 1
    WHERE municipio = OLD.municipio_domicilio;

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_eliminar_persona
AFTER DELETE ON personas
FOR EACH ROW
EXECUTE FUNCTION actualizar_conteo_delete();

-- Trigger para actualización tras una modificación
CREATE OR REPLACE FUNCTION actualizar_conteo_update() RETURNS TRIGGER AS $$
BEGIN
    -- Si el domicilio cambia, ajustar los conteos
    IF NEW.municipio_domicilio <> OLD.municipio_domicilio THEN
        -- Decrementar el conteo en el municipio antiguo
        UPDATE municipios
        SET conteo_viven = conteo_viven - 1,
            conteo_trabajan = conteo_trabajan - 1
        WHERE municipio = OLD.municipio_domicilio;

        -- Incrementar el conteo en el nuevo municipio
        UPDATE municipios
        SET conteo_viven = conteo_viven + 1,
            conteo_trabajan = conteo_trabajan + 1
        WHERE municipio = NEW.municipio_domicilio;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_modificar_persona
AFTER UPDATE ON personas
FOR EACH ROW
EXECUTE FUNCTION actualizar_conteo_update();

-- 4- Agregar las columnas de conteos a la vista que muestre la lista de departamentos y municipios
CREATE OR REPLACE VIEW vista_departamentos_municipios_con_conteo AS
SELECT 
    departamento,
    municipio,
    CONCAT(LPAD(codigo_departamento::TEXT, 2, '0'), LPAD(codigo_municipio::TEXT, 3, '0')) AS codigo_municipio_completo,
    conteo_viven,
    conteo_trabajan
FROM 
    municipios;