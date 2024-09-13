-- ##############
-- ### Tablas ###
-- ##############

-- Crear tipos ENUM
-- CREATE TYPE rol_enum AS ENUM ('Limpiador', 'Contador', 'Gerente', 'Vendedor');

-- create database examen_juan;

CREATE TABLE empleado (
    id SERIAL PRIMARY KEY,
    rol rol_enum NOT NULL, -- Usando ENUM en lugar de VARCHAR con CHECK
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    telefono VARCHAR(20) UNIQUE, -- Agregando restricción UNIQUE
    fecha_contratacion DATE NOT NULL
);

CREATE TABLE vehiculo (
    id SERIAL PRIMARY KEY,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    anio INTEGER CHECK (anio > 1900) NOT NULL,
    precio NUMERIC(10, 2) NOT NULL,
    estado VARCHAR(10) CHECK (estado IN ('nuevo', 'usado')) NOT NULL
);

CREATE TABLE concesionario (
    id SERIAL PRIMARY KEY,
    direccion VARCHAR(100) NOT NULL,
    ciudad VARCHAR(50) NOT NULL
);

CREATE TABLE concesionario_vehiculos (
    id SERIAL PRIMARY KEY,
    id_concesionario INT REFERENCES concesionario(id),
    id_vehiculo INT REFERENCES vehiculo(id),
    cantidad_vehiculos INT CHECK (cantidad_vehiculos >= 0)
);

CREATE TABLE cliente (
    id SERIAL PRIMARY KEY,
    numero_documento VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    telefono VARCHAR(20),
    edad INT CHECK (edad > 0),
    direccion VARCHAR(100)
);

CREATE TABLE cliente_potencial (
    id SERIAL PRIMARY KEY,
    id_cliente INT REFERENCES cliente(id),
    nivel_interes VARCHAR(10) CHECK (nivel_interes IN ('Alto', 'Medio', 'Bajo')) NOT NULL
);

CREATE TABLE venta (
    id SERIAL PRIMARY KEY,
    id_cliente INT REFERENCES cliente(id),
    id_vehiculo INT REFERENCES vehiculo(id),
    tipo_pago VARCHAR(10) CHECK (tipo_pago IN ('Credito', 'Contado')) NOT NULL
);

CREATE TABLE departamento_ventas (
    id SERIAL PRIMARY KEY,
    id_empleado INT REFERENCES empleado(id),
    comisiones_generadas NUMERIC(10, 2),
    ventas_realizadas INT CHECK (ventas_realizadas >= 0)
);

CREATE TABLE departamento_servicios (
    id SERIAL PRIMARY KEY,
    id_empleado INT REFERENCES empleado(id),
    servicios_realizados INT CHECK (servicios_realizados >= 0),
    horarios_trabajo VARCHAR(100)
);

CREATE TABLE historial_servicios (
    id SERIAL PRIMARY KEY,
    id_vehiculo INT REFERENCES vehiculo(id),
    id_empleado INT REFERENCES empleado(id),
    fecha DATE NOT NULL
);

CREATE TABLE proveedor (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL
);

CREATE TABLE proveedor_piezas (
    id SERIAL PRIMARY KEY,
    id_proveedor INT REFERENCES proveedor(id),
    id_historial_servicio INT REFERENCES historial_servicios(id)
);

-- Ver las tablas creadas
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public';