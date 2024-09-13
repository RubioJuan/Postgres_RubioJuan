-- #############
-- ### Datos ###
-- #############

INSERT INTO empleado (rol, nombre, apellido, telefono, fecha_contratacion)
VALUES
('Vendedor', 'Juan', 'Pérez', '123456789', '2022-05-10'),
('Gerente', 'Ana', 'Martínez', '987654321', '2021-03-15'),
('Limpiador', 'Carlos', 'Gómez', '564738291', '2020-09-01'),
('Contador', 'Laura', 'Fernández', '432198765', '2019-11-22');


INSERT INTO vehiculo (marca, modelo, anio, precio, estado)
VALUES
('Toyota', 'Corolla', 2021, 22000, 'nuevo'),
('Ford', 'Mustang', 2020, 35000, 'usado'),
('Honda', 'Civic', 2019, 18000, 'usado'),
('Chevrolet', 'Cruze', 2022, 25000, 'nuevo');

INSERT INTO concesionario (direccion, ciudad)
VALUES
('Av. Principal 123', 'Ciudad A'),
('Calle Secundaria 456', 'Ciudad B');

INSERT INTO concesionario_vehiculos (id_concesionario, id_vehiculo, cantidad_vehiculos)
VALUES
(1, 1, 5),
(1, 2, 2),
(2, 3, 3),
(2, 4, 4);

INSERT INTO cliente (numero_documento, nombre, apellido, telefono, edad, direccion)
VALUES
('12345678', 'Luis', 'Rodríguez', '123123123', 35, 'Calle 1'),
('87654321', 'María', 'López', '987987987', 29, 'Calle 2');

INSERT INTO venta (id_cliente, id_vehiculo, tipo_pago)
VALUES
(1, 1, 'Credito'),
(2, 3, 'Contado');

INSERT INTO departamento_ventas (id_empleado, comisiones_generadas, ventas_realizadas)
VALUES
(1, 1500.50, 10),
(2, 2000.75, 15);

INSERT INTO departamento_servicios (id_empleado, servicios_realizados, horarios_trabajo)
VALUES
(3, 50, '9:00-18:00'),
(4, 30, '8:00-17:00');

INSERT INTO historial_servicios (id_vehiculo, id_empleado, fecha)
VALUES
(1, 3, '2023-01-15'),
(2, 4, '2023-02-20');

INSERT INTO proveedor (nombre, telefono)
VALUES
('Proveedor A', '123987654'),
('Proveedor B', '321654987');

INSERT INTO proveedor_piezas (id_proveedor, id_historial_servicio)
VALUES
(1, 1),
(2, 2);