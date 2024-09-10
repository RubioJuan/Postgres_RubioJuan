-- #################
-- ### Consultas ###
-- #################

-- #################################
-- ### Consultas sobre una tabla ###
-- #################################

-- 1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.
SELECT codigo_oficina, ciudad 
FROM oficina;

-- 2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.
SELECT ciudad, telefono 
FROM oficina 
WHERE pais = 'España';

-- 3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo
-- jefe tiene un código de jefe igual a 7.
SELECT nombre, apellido1, apellido2, email 
FROM empleado 
WHERE codigo_jefe = 7;

-- 4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.
SELECT puesto, nombre, apellido1, apellido2, email 
FROM empleado 
WHERE codigo_empleado = codigo_jefe;

-- 5. Devuelve un listado con el nombre, apellidos y puesto de aquellos
-- empleados que no sean representantes de ventas.
SELECT nombre, apellido1, apellido2, puesto 
FROM empleado 
WHERE puesto != 'Representante de ventas';

-- 6. Devuelve un listado con el nombre de los todos los clientes españoles.
SELECT nombre_cliente 
FROM cliente 
WHERE pais = 'España';

-- 7. Devuelve un listado con los distintos estados por los que puede pasar un pedido.
SELECT DISTINCT estado 
FROM pedido;

-- 8. Devuelve un listado con el código de cliente de aquellos clientes que
-- realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar
-- aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:
-- • Utilizando la función YEAR de MySQL.
-- • Utilizando la función DATE_FORMAT de MySQL.
-- • Sin utilizar ninguna de las funciones anteriores.
SELECT DISTINCT codigo_cliente 
FROM pago 
WHERE EXTRACT(YEAR FROM fecha_pago) = 2008;

-- 9. Devuelve un listado con el código de pedido, código de cliente, fecha
-- esperada y fecha de entrega de los pedidos que no han sido entregados a tiempo.
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega 
FROM pedido 
WHERE fecha_entrega > fecha_esperada;

-- 10. Devuelve un listado con el código de pedido, código de cliente, fecha
-- esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al
-- menos dos días antes de la fecha esperada.
-- • Utilizando la función ADDDATE de MySQL.
-- • Utilizando la función DATEDIFF de MySQL.
-- • ¿Sería posible resolver esta consulta utilizando el operador de suma + o resta -?

-- Usando ADDDATE:
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega 
FROM pedido 
WHERE fecha_entrega <= fecha_esperada - INTERVAL '2 days';

-- Usando DATEDIFF:
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega 
FROM pedido 
WHERE (fecha_esperada - fecha_entrega) >= 2;

-- 11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.
SELECT codigo_pedido 
FROM pedido 
WHERE estado = 'Rechazado' AND EXTRACT(YEAR FROM fecha_pedido) = 2009;

-- 12. Devuelve un listado de todos los pedidos que han sido entregados en el
-- mes de enero de cualquier año.
SELECT codigo_pedido, fecha_entrega 
FROM pedido 
WHERE EXTRACT(MONTH FROM fecha_entrega) = 1;

-- 13. Devuelve un listado con todos los pagos que se realizaron en el
-- año 2008 mediante Paypal. Ordene el resultado de mayor a menor.
SELECT codigo_cliente, total 
FROM pago 
WHERE EXTRACT(YEAR FROM fecha_pago) = 2008 AND forma_pago = 'Paypal' 
ORDER BY total DESC;

-- 14. Devuelve un listado con todas las formas de pago que aparecen en la
-- tabla pago. Tenga en cuenta que no deben aparecer formas de pago repetidas.
SELECT DISTINCT forma_pago 
FROM pago;

-- 15. Devuelve un listado con todos los productos que pertenecen a la
-- gama Ornamentales y que tienen más de 100 unidades en stock. El listado
-- deberá estar ordenado por su precio de venta, mostrando en primer lugar los de mayor precio.
SELECT nombre, cantidad_en_stock, precio_venta 
FROM producto 
WHERE gama = 'Ornamentales' AND cantidad_en_stock > 100 
ORDER BY precio_venta DESC;

-- 16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y
-- cuyo representante de ventas tenga el código de empleado 11 o 30.
SELECT nombre_cliente 
FROM cliente 
WHERE ciudad = 'Madrid' AND codigo_empleado_rep_ventas IN (11, 30);

-- ##################################################
-- ### Consultas multitabla (Composición interna) ###
-- ##################################################

-- Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2. Las consultas con
-- sintaxis de SQL2 se deben resolver con INNER JOIN y NATURAL JOIN.

--1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.
-- SQL1:
SELECT c.nombre_cliente, e.nombre, e.apellido1 
FROM cliente c, empleado e 
WHERE c.codigo_empleado_rep_ventas = e.codigo_empleado;

-- SQL2 (INNER JOIN):
SELECT c.nombre_cliente, e.nombre, e.apellido1 
FROM cliente c 
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado;

--SQL2 (NATURAL JOIN):
SELECT nombre_cliente, nombre, apellido1 
FROM cliente NATURAL JOIN empleado;

-- 2. Muestra el nombre de los clientes que hayan realizado pagos junto con el
-- nombre de sus representantes de ventas.
--SQL1:
SELECT c.nombre_cliente, e.nombre, e.apellido1 
FROM cliente c, empleado e, pago p 
WHERE c.codigo_cliente = p.codigo_cliente 
AND c.codigo_empleado_rep_ventas = e.codigo_empleado;

-- SQL2 (INNER JOIN):
SELECT c.nombre_cliente, e.nombre, e.apellido1 
FROM cliente c 
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado 
INNER JOIN pago p ON c.codigo_cliente = p.codigo_cliente;

-- 3. Muestra el nombre de los clientes que no hayan realizado pagos junto con
-- el nombre de sus representantes de ventas.
-- SQL1:
SELECT c.nombre_cliente, e.nombre, e.apellido1 
FROM cliente c, empleado e 
WHERE c.codigo_empleado_rep_ventas = e.codigo_empleado 
AND c.codigo_cliente NOT IN (SELECT p.codigo_cliente FROM pago p);

-- SQL2 (INNER JOIN):
SELECT c.nombre_cliente, e.nombre, e.apellido1 
FROM cliente c 
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado 
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente 
WHERE p.codigo_cliente IS NULL;

-- 4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus
-- representantes junto con la ciudad de la oficina a la que pertenece el representante.
-- SQL1:
SELECT c.nombre_cliente, e.nombre, e.apellido1, o.ciudad 
FROM cliente c, empleado e, oficina o, pago p 
WHERE c.codigo_cliente = p.codigo_cliente 
AND c.codigo_empleado_rep_ventas = e.codigo_empleado 
AND e.codigo_oficina = o.codigo_oficina;

-- SQL2 (INNER JOIN):
SELECT c.nombre_cliente, e.nombre, e.apellido1, o.ciudad 
FROM cliente c 
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado 
INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina 
INNER JOIN pago p ON c.codigo_cliente = p.codigo_cliente;

-- 5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre
-- de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
-- SQL1:
SELECT c.nombre_cliente, e.nombre, e.apellido1, o.ciudad 
FROM cliente c, empleado e, oficina o 
WHERE c.codigo_empleado_rep_ventas = e.codigo_empleado 
AND e.codigo_oficina = o.codigo_oficina 
AND c.codigo_cliente NOT IN (SELECT p.codigo_cliente FROM pago p);

-- SQL2 (INNER JOIN):
SELECT c.nombre_cliente, e.nombre, e.apellido1, o.ciudad 
FROM cliente c 
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado 
INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina 
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente 
WHERE p.codigo_cliente IS NULL;

-- 6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
-- SQL1:
SELECT o.linea_direccion1, o.linea_direccion2 
FROM oficina o, cliente c 
WHERE o.codigo_oficina = c.codigo_empleado_rep_ventas 
AND c.ciudad = 'Fuenlabrada';

-- SQL2 (INNER JOIN):
SELECT o.linea_direccion1, o.linea_direccion2 
FROM oficina o 
INNER JOIN empleado e ON o.codigo_oficina = e.codigo_oficina 
INNER JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas 
WHERE c.ciudad = 'Fuenlabrada';

-- 7. Devuelve el nombre de los clientes y el nombre de sus representantes junto
-- con la ciudad de la oficina a la que pertenece el representante.
-- SQL1:
SELECT c.nombre_cliente, e.nombre, e.apellido1, o.ciudad 
FROM cliente c, empleado e, oficina o 
WHERE c.codigo_empleado_rep_ventas = e.codigo_empleado 
AND e.codigo_oficina = o.codigo_oficina;

-- SQL2 (INNER JOIN):
SELECT c.nombre_cliente, e.nombre, e.apellido1, o.ciudad 
FROM cliente c 
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado 
INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina;

-- 8. Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.
-- SQL1:
SELECT e.nombre, e.apellido1, j.nombre AS nombre_jefe, j.apellido1 AS apellido_jefe 
FROM empleado e, empleado j 
WHERE e.codigo_jefe = j.codigo_empleado;

-- SQL2 (INNER JOIN):
SELECT e.nombre, e.apellido1, j.nombre AS nombre_jefe, j.apellido1 AS apellido_jefe 
FROM empleado e 
INNER JOIN empleado j ON e.codigo_jefe = j.codigo_empleado;

-- 9. Devuelve un listado que muestre el nombre de cada empleados, el nombre
-- de su jefe y el nombre del jefe de sus jefe.
-- SQL1:
SELECT e.nombre, e.apellido1, j.nombre AS nombre_jefe, jj.nombre AS nombre_jefe_jefe 
FROM empleado e, empleado j, empleado jj 
WHERE e.codigo_jefe = j.codigo_empleado 
AND j.codigo_jefe = jj.codigo_empleado;

-- SQL2 (INNER JOIN):
SELECT e.nombre, e.apellido1, j.nombre AS nombre_jefe, jj.nombre AS nombre_jefe_jefe 
FROM empleado e 
INNER JOIN empleado j ON e.codigo_jefe = j.codigo_empleado 
INNER JOIN empleado jj ON j.codigo_jefe = jj.codigo_empleado;

-- 10. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.
-- SQL1:
SELECT c.nombre_cliente 
FROM cliente c, pedido p 
WHERE c.codigo_cliente = p.codigo_cliente 
AND p.fecha_entrega > p.fecha_esperada;

-- SQL2 (INNER JOIN):
SELECT c.nombre_cliente 
FROM cliente c 
INNER JOIN pedido p ON c.codigo_cliente = p.codigo_cliente 
WHERE p.fecha_entrega > p.fecha_esperada;

-- 11. Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.
-- SQL2 (INNER JOIN):
SELECT c.nombre_cliente, gp.gama 
FROM cliente c 
INNER JOIN pedido p ON c.codigo_cliente = p.codigo_cliente 
INNER JOIN detalle_pedido dp ON p.codigo_pedido = dp.codigo_pedido 
INNER JOIN producto pr ON dp.codigo_producto = pr.codigo_producto 
INNER JOIN gama_producto gp ON pr.gama = gp.gama;

-- ##################################################
-- ### Consultas multitabla (Composición externa) ###
-- ##################################################

-- Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, NATURAL
-- LEFT JOIN y NATURAL RIGHT JOIN.

-- 1. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
SELECT c.nombre_cliente 
FROM cliente c 
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente 
WHERE p.codigo_cliente IS NULL;

-- 2. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.
SELECT c.nombre_cliente 
FROM cliente c 
LEFT JOIN pedido p ON c.codigo_cliente = p.codigo_cliente 
WHERE p.codigo_cliente IS NULL;

-- 3. Devuelve un listado que muestre los clientes que no han realizado ningún 
-- pago y los que no han realizado ningún pedido.
SELECT c.nombre_cliente 
FROM cliente c 
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente 
LEFT JOIN pedido d ON c.codigo_cliente = d.codigo_cliente 
WHERE p.codigo_cliente IS NULL OR d.codigo_cliente IS NULL;

-- 4. Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.
SELECT e.nombre, e.apellido1 
FROM empleado e 
LEFT JOIN oficina o ON e.codigo_oficina = o.codigo_oficina 
WHERE o.codigo_oficina IS NULL;

-- 5. Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.
SELECT e.nombre, e.apellido1 
FROM empleado e 
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas 
WHERE c.codigo_empleado_rep_ventas IS NULL;

-- 6. Devuelve un listado que muestre solamente los empleados que no tienen un
-- cliente asociado junto con los datos de la oficina donde trabajan.
SELECT e.nombre, e.apellido1, o.linea_direccion1, o.ciudad 
FROM empleado e 
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas 
LEFT JOIN oficina o ON e.codigo_oficina = o.codigo_oficina 
WHERE c.codigo_empleado_rep_ventas IS NULL;

-- 7. Devuelve un listado que muestre los empleados que no tienen una oficina
-- asociada y los que no tienen un cliente asociado.
SELECT e.nombre, e.apellido1 
FROM empleado e 
LEFT JOIN oficina o ON e.codigo_oficina = o.codigo_oficina 
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas 
WHERE o.codigo_oficina IS NULL OR c.codigo_empleado_rep_ventas IS NULL;

--8. Devuelve un listado de los productos que nunca han aparecido en un pedido.
SELECT p.codigo_producto 
FROM producto p 
LEFT JOIN detalle_pedido dp ON p.codigo_producto = dp.codigo_producto 
WHERE dp.codigo_producto IS NULL;

-- 9. Devuelve un listado de los productos que nunca han aparecido en un
-- pedido. El resultado debe mostrar el nombre, la descripción y la imagen del producto.
SELECT p.nombre, p.descripcion, p.imagen 
FROM producto p 
LEFT JOIN detalle_pedido dp ON p.codigo_producto = dp.codigo_producto 
WHERE dp.codigo_producto IS NULL;

-- 10. Devuelve las oficinas donde no trabajan ninguno de los empleados que
-- hayan sido los representantes de ventas de algún cliente que haya realizado
-- la compra de algún producto de la gama Frutales.
SELECT o.ciudad 
FROM oficina o 
LEFT JOIN empleado e ON o.codigo_oficina = e.codigo_oficina 
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas 
LEFT JOIN pedido p ON c.codigo_cliente = p.codigo_cliente 
LEFT JOIN detalle_pedido dp ON p.codigo_pedido = dp.codigo_pedido 
LEFT JOIN producto pr ON dp.codigo_producto = pr.codigo_producto 
WHERE pr.gama = 'Frutales' AND c.codigo_cliente IS NULL;

-- 11. Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.
SELECT c.nombre_cliente 
FROM cliente c 
LEFT JOIN pedido p ON c.codigo_cliente = p.codigo_cliente 
LEFT JOIN pago pa ON c.codigo_cliente = pa.codigo_cliente 
WHERE p.codigo_cliente IS NOT NULL AND pa.codigo_cliente IS NULL;

-- 12. Devuelve un listado con los datos de los empleados que no tienen clientes 
-- asociados y el nombre de su jefe asociado.
SELECT e.nombre, e.apellido1, j.nombre AS nombre_jefe, j.apellido1 AS apellido_jefe 
FROM empleado e 
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas 
LEFT JOIN empleado j ON e.codigo_jefe = j.codigo_empleado 
WHERE c.codigo_empleado_rep_ventas IS NULL;

-- ######################### 
-- ### Consultas resumen ###
-- #########################
1. ¿Cuántos empleados hay en la compañía?
2. ¿Cuántos clientes tiene cada país?
3. ¿Cuál fue el pago medio en 2009?
4. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma
descendente por el número de pedidos.
5. Calcula el precio de venta del producto más caro y más barato en una
misma consulta.
6. Calcula el número de clientes que tiene la empresa.
7. ¿Cuántos clientes existen con domicilio en la ciudad de Madrid?
8. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan
por M?
9. Devuelve el nombre de los representantes de ventas y el número de clientes
al que atiende cada uno.
10. Calcula el número de clientes que no tiene asignado representante de
ventas.
11. Calcula la fecha del primer y último pago realizado por cada uno de los
clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente.

12. Calcula el número de productos diferentes que hay en cada uno de los
pedidos.
13. Calcula la suma de la cantidad total de todos los productos que aparecen en
cada uno de los pedidos.
14. Devuelve un listado de los 20 productos más vendidos y el número total de
unidades que se han vendido de cada uno. El listado deberá estar ordenado
por el número total de unidades vendidas.
15. La facturación que ha tenido la empresa en toda la historia, indicando la
base imponible, el IVA y el total facturado. La base imponible se calcula
sumando el coste del producto por el número de unidades vendidas de la
tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total la
suma de los dos campos anteriores.
16. La misma información que en la pregunta anterior, pero agrupada por
código de producto.
17. La misma información que en la pregunta anterior, pero agrupada por
código de producto filtrada por los códigos que empiecen por OR.
18. Lista las ventas totales de los productos que hayan facturado más de 3000
euros. Se mostrará el nombre, unidades vendidas, total facturado y total
facturado con impuestos (21% IVA).
19. Muestre la suma total de todos los pagos que se realizaron para cada uno
de los años que aparecen en la tabla pagos.
