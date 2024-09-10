-- ############
-- ### View ###
-- ############

-- 1. Vista: Listado de Oficinas y Ciudades
CREATE VIEW vista_oficinas_ciudades AS
SELECT codigo_oficina, ciudad
FROM oficina;

-- 2. Vista: Oficinas en España
CREATE VIEW vista_oficinas_espana AS
SELECT ciudad, telefono
FROM oficina
WHERE pais = 'España';

-- 3. Vista: Empleados con jefe específico
CREATE VIEW vista_empleados_jefe7 AS
SELECT nombre, apellido1, apellido2, email
FROM empleado
WHERE codigo_jefe = 7;

-- 4. Vista: Jefe de la empresa
CREATE VIEW vista_jefe_empresa AS
SELECT nombre, apellido1, apellido2, email, puesto
FROM empleado
WHERE codigo_jefe IS NULL;

-- 5. Vista: Clientes Españoles
CREATE VIEW vista_clientes_espanoles AS
SELECT nombre_cliente
FROM cliente
WHERE pais = 'España';

-- 6. Vista: Estados de Pedidos
CREATE VIEW vista_estados_pedidos AS
SELECT DISTINCT estado
FROM pedido;

-- 7. Vista: Pagos en 2008
CREATE VIEW vista_pagos_2008 AS
SELECT DISTINCT codigo_cliente
FROM pago
WHERE EXTRACT(YEAR FROM fecha_pago) = 2008;

-- 8. Vista: Pedidos no entregados a tiempo
CREATE VIEW vista_pedidos_no_a_tiempo AS
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE fecha_entrega > fecha_esperada;

-- 9. Vista: Pedidos entregados antes de lo esperado
CREATE VIEW vista_pedidos_entregados_antes AS
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE fecha_entrega <= fecha_esperada - INTERVAL '2 day';

-- 10. Vista: Clientes sin pagos
CREATE VIEW vista_clientes_sin_pagos AS
SELECT nombre_cliente
FROM cliente
WHERE codigo_cliente NOT IN (SELECT codigo_cliente FROM pago);







