-- #################
-- ### Consultas ###
-- #################

-- 1. Listar Vehículos Disponibles: Obtener una lista de todos los vehículos disponibles para la 
-- venta, incluyendo detalles como marca, modelo, y precio.
SELECT marca, modelo, anio, precio, estado
FROM vehiculo
WHERE estado = 'nuevo' OR estado = 'usado';

-- 2. Clientes con Compras Recientes: Mostrar los clientes que han realizado compras recientemente,
--  junto con la información de los vehículos adquiridos.
SELECT c.nombre AS cliente_nombre, c.apellido AS cliente_apellido, v.marca, v.modelo, v.anio, v.precio, ven.tipo_pago
FROM cliente c
JOIN venta ven ON c.id = ven.id_cliente
JOIN vehiculo v ON ven.id_vehiculo = v.id
WHERE ven.id IN (
    SELECT id FROM venta
    WHERE CURRENT_DATE - INTERVAL '1 year' <= CURRENT_DATE
);

-- 3. Historial de Servicios por Vehículo: Obtener el historial completo de servicios realizados para un 
-- vehículo específico, incluyendo detalles sobre los empleados involucrados y las fechas de servicio.
SELECT v.marca, v.modelo, hs.fecha, e.nombre AS empleado_nombre, e.apellido AS empleado_apellido
FROM historial_servicios hs
JOIN vehiculo v ON hs.id_vehiculo = v.id
JOIN empleado e ON hs.id_empleado = e.id
WHERE v.id = <id_del_vehiculo>;

-- 4. Proveedores de Piezas Utilizados: Listar los proveedores de piezas que han suministrado componentes utilizados en los servicios de mantenimiento.
SELECT p.nombre AS proveedor_nombre, p.telefono, hs.fecha
FROM proveedor p
JOIN proveedor_piezas pp ON p.id = pp.id_proveedor
JOIN historial_servicios hs ON pp.id_historial_servicio = hs.id;

-- 5. Rendimiento del Personal de Ventas: Calcular las comisiones generadas por cada empleado del departamento de ventas en un período específico.
SELECT e.nombre AS empleado_nombre, e.apellido AS empleado_apellido, dv.comisiones_generadas, dv.ventas_realizadas
FROM departamento_ventas dv
JOIN empleado e ON dv.id_empleado = e.id
WHERE dv.comisiones_generadas IS NOT NULL
  AND dv.ventas_realizadas IS NOT NULL
  AND e.fecha_contratacion BETWEEN '2023-01-01' AND '2023-12-31';

-- 6. Servicios Realizados por un Empleado: Identificar todos los servicios de mantenimiento realizados por un empleado específico, incluyendo detalles sobre los vehículos atendidos.
SELECT v.marca, v.modelo, hs.fecha
FROM historial_servicios hs
JOIN vehiculo v ON hs.id_vehiculo = v.id
WHERE hs.id_empleado = <id_del_empleado>;

-- 7. Clientes Potenciales y Vehículos de Interés: Mostrar información sobre los clientes potenciales y los vehículos de su interés, proporcionando pistas valiosas para estrategias de marketing.
SELECT cp.nivel_interes, c.nombre AS cliente_nombre, c.apellido AS cliente_apellido, v.marca, v.modelo
FROM cliente_potencial cp
JOIN cliente c ON cp.id_cliente = c.id
JOIN venta ven ON ven.id_cliente = c.id
JOIN vehiculo v ON ven.id_vehiculo = v.id;

-- 8. Empleados del Departamento de Servicio: Listar todos los empleados que pertenecen al departamento de servicio, junto con sus horarios de trabajo.
SELECT e.nombre AS empleado_nombre, e.apellido AS empleado_apellido, ds.horarios_trabajo
FROM departamento_servicios ds
JOIN empleado e ON ds.id_empleado = e.id;

-- 9. Vehículos Vendidos en un Rango de Precios: Encontrar los vehículos vendidos en un rango de precios específico, proporcionando datos útiles para análisis de ventas.
SELECT v.marca, v.modelo, v.precio, ven.tipo_pago
FROM venta ven
JOIN vehiculo v ON ven.id_vehiculo = v.id
WHERE v.precio BETWEEN 20000 AND 30000;

-- 10. Clientes con Múltiples Compras: Identificar a aquellos clientes que han realizado más de una compra en el concesionario, destacando la lealtad del cliente.
SELECT c.nombre AS cliente_nombre, c.apellido AS cliente_apellido, COUNT(ven.id) AS total_compras
FROM cliente c
JOIN venta ven ON c.id = ven.id_cliente
GROUP BY c.id
HAVING COUNT(ven.id) > 1;