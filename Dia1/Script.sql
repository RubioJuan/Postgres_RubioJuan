-- Crear tabla de fabricante
create table fabricante(
	codigo int primary key,
	nombre varchar(100) not null
);

-- Crear tabla de producto
create table producto(
	codigo int primary key,
	nombre varchar(100) not null,
	precio double precision not null,
	codigo_fabricante int not null,
    FOREIGN KEY (codigo_fabricante) REFERENCES fabricante (codigo)
);

-- Ver las tablas creadas
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public';

-- Inserciones
INSERT INTO fabricante (codigo, nombre) VALUES
(1, 'Asus'),
(2, 'Lenovo'),
(3, 'Hewlett-Packard'),
(4, 'Samsung'),
(5, 'Seagate'),
(6, 'Crucial'),
(7, 'Gigabyte'),
(8, 'Huawei'),
(9, 'Xiaomi');

select * from producto;

INSERT INTO producto (codigo, nombre, precio, codigo_fabricante) VALUES
(1, 'Disco duro SATA3 1TB', 86.99, 5),
(2, 'Memoria RAM DDR4 8GB', 120, 6),
(3, 'Disco SSD 1 TB', 150.99, 4),
(4, 'GeForce GTX 1050Ti', 185, 7),
(5, 'GeForce GTX 1080 Xtreme', 755, 6),
(6, 'Monitor 24 LED Full HD', 202, 1),
(7, 'Monitor 27 LED Full HD', 245.99, 1),
(8, 'Portátil Yoga 520', 559, 2),
(9, 'Portátil Ideapad 320', 444, 2),
(10, 'Impresora HP Deskjet 3720', 59.99, 3),
(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

-- 1. Lista el nombre de todos los productos que hay en la tabla producto.

SELECT nombre FROM producto;

-- 2. Lista los nombres y los precios de todos los productos de la tabla producto.

SELECT nombre, precio FROM producto;

-- 3. Lista todas las columnas de la tabla producto.

SELECT * FROM producto;

-- 4.Lista el nombre de los productos, el precio en euros y el precio en dólares (USD).

SELECT nombre, precio, precio * 1.1 AS precio_usd FROM producto;

-- 5. Lista el nombre de los productos, el precio en euros y el precio en dólares (USD) con alias.

SELECT nombre AS "nombre de producto", precio AS "euros", precio * 1.1 AS "dólares" FROM producto;

-- 6. Lista los nombres y los precios de todos los productos, con los nombres en mayúsculas.

SELECT UPPER(nombre), precio FROM producto;

-- 7. Lista los nombres y los precios de todos los productos, con los nombres en minúscula.

SELECT LOWER(nombre), precio FROM producto;

-- 8. Lista el nombre de los fabricantes en una columna, y los dos primeros caracteres en mayúsculas en otra columna.

SELECT nombre, UPPER(LEFT(nombre, 2)) FROM fabricante;

-- 9. Lista los nombres y los precios de todos los productos, redondeando el precio.

SELECT nombre, ROUND(precio) FROM producto;

-- 10. Lista los nombres y los precios de todos los productos, truncando el valor del precio.

SELECT nombre, TRUNC(precio) FROM producto;

-- 11. Lista el identificador de los fabricantes que tienen productos en la tabla producto.

SELECT DISTINCT codigo_fabricante FROM producto;

-- 12.Lista el identificador de los fabricantes eliminando los repetidos.

SELECT DISTINCT codigo_fabricante FROM producto;

-- 13. Lista los nombres de los fabricantes ordenados de forma ascendente.

SELECT nombre FROM fabricante ORDER BY nombre ASC;

-- 14. Lista los nombres de los fabricantes ordenados de forma descendente.

SELECT nombre FROM fabricante ORDER BY nombre DESC;

-- Lista los nombres de los productos ordenados primero por nombre ascendente y luego por precio descendente.

SELECT nombre, precio FROM producto ORDER BY nombre ASC, precio DESC;

-- Devuelve las primeras 5 filas de la tabla fabricante.

SELECT * FROM fabricante LIMIT 5;

-- Devuelve 2 filas a partir de la cuarta fila de la tabla fabricante.

SELECT * FROM fabricante OFFSET 3 LIMIT 2;

-- Lista el nombre y el precio del producto más barato.

SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1;

-- Lista el nombre y el precio del producto más caro.

SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;
-- Lista el nombre de todos los productos del fabricante con código 2.

SELECT nombre FROM producto WHERE codigo_fabricante = 2;

-- Lista el nombre de los productos que tienen un precio menor o igual a 120€.

SELECT nombre FROM producto WHERE precio <= 120;

-- Lista el nombre de los productos que tienen un precio mayor o igual a 400€.

SELECT nombre FROM producto WHERE precio >= 400;

-- Lista los productos que no tienen un precio mayor o igual a 400€.

SELECT nombre FROM producto WHERE precio < 400;

-- Lista todos los productos con un precio entre 80€ y 300€ (sin BETWEEN).

SELECT nombre FROM producto WHERE precio >= 80 AND precio <= 300;

--Lista todos los productos con un precio entre 60€ y 200€ (con BETWEEN).

SELECT nombre FROM producto WHERE precio BETWEEN 60 AND 200;

--Lista los productos con un precio mayor a 200€ y con código de fabricante 6.

SELECT nombre FROM producto WHERE precio > 200 AND codigo_fabricante = 6;

-- Lista los productos donde el código de fabricante sea 1, 3 o 5 (sin IN).

SELECT nombre FROM producto WHERE codigo_fabricante = 1 OR codigo_fabricante = 3 OR codigo_fabricante = 5;

-- Lista los productos donde el código de fabricante sea 1, 3 o 5 (con IN).

SELECT nombre FROM producto WHERE codigo_fabricante IN (1, 3, 5);

-- Lista el nombre y el precio de los productos en céntimos (con alias).

SELECT nombre, precio * 100 AS centimos FROM producto;

-- Lista los fabricantes cuyo nombre empiece por S.

SELECT nombre FROM fabricante WHERE nombre LIKE 'S%';

-- Lista los fabricantes cuyo nombre termine en vocal e.

SELECT nombre FROM fabricante WHERE nombre LIKE '%e';

-- Lista los fabricantes cuyo nombre contenga la letra w.

SELECT nombre FROM fabricante WHERE nombre LIKE '%w%';

-- Lista los fabricantes cuyo nombre tenga 4 caracteres.

SELECT nombre FROM fabricante WHERE LENGTH(nombre) = 4;

-- Lista los productos que contienen la cadena 'Portátil'.

SELECT nombre FROM producto WHERE nombre LIKE '%Portátil%';

-- Lista los productos que contienen 'Monitor' y tengan precio menor a 215€.

SELECT nombre FROM producto WHERE nombre LIKE '%Monitor%' AND precio < 215;

-- Lista el nombre y el precio de productos con precio mayor o igual a 180€, ordenado por precio (descendente) y nombre (ascendente).
SELECT nombre, precio FROM producto WHERE precio >= 180 ORDER BY precio DESC, nombre ASC;

--------------------------------------------------
----------- Consultas multitabla: ----------------
--------------------------------------------------
-- Devuelve el nombre del producto, precio y nombre de fabricante de todos los productos.

SELECT producto.nombre, producto.precio, fabricante.nombre AS nombre_fabricante
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;

-- Devuelve el nombre del producto, precio y nombre de fabricante de todos los productos, ordenados por nombre de fabricante.

SELECT producto.nombre, producto.precio, fabricante.nombre AS nombre_fabricante
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
ORDER BY fabricante.nombre;

-- Devuelve el ID del producto, nombre del producto, ID del fabricante y nombre del fabricante.

SELECT producto.codigo AS id_producto, producto.nombre, fabricante.codigo AS id_fabricante, fabricante.nombre AS nombre_fabricante
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;

-- Devuelve el nombre, precio y fabricante del producto más barato.

SELECT producto.nombre, producto.precio, fabricante.nombre AS nombre_fabricante
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
ORDER BY producto.precio ASC LIMIT 1;

-- Devuelve el nombre, precio y fabricante del producto más caro.

SELECT producto.nombre, producto.precio, fabricante.nombre AS nombre_fabricante
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
ORDER BY producto.precio DESC LIMIT 1;

-- Devuelve una lista de todos los productos del fabricante Lenovo.

SELECT producto.nombre, producto.precio 
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Lenovo';

-- Devuelve una lista de todos los productos del fabricante Crucial con un precio mayor a 200€.

SELECT producto.nombre, producto.precio 
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Crucial' AND producto.precio > 200;

-- Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard y Seagate (sin IN).

SELECT producto.nombre, producto.precio
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Asus' OR fabricante.nombre = 'Hewlett-Packard' OR fabricante.nombre = 'Seagate';

-- Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard y Seagate (con IN).

SELECT producto.nombre, producto.precio
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate');

-- Devuelve un listado con el nombre y precio de productos cuyos fabricantes terminan en vocal e.

SELECT producto.nombre, producto.precio
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre LIKE '%e';

-- Devuelve un listado con el nombre y precio de productos cuyos fabricantes contienen la letra w.

SELECT producto.nombre, producto.precio
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre LIKE '%w%';

-- Devuelve un listado con el nombre de producto, precio y fabricante de productos con precio mayor o igual a 180€, ordenado por precio (descendente) y nombre (ascendente).

SELECT producto.nombre, producto.precio, fabricante.nombre AS nombre_fabricante
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE producto.precio >= 180
ORDER BY producto.precio DESC, producto.nombre ASC;

-- Devuelve un listado con el ID y nombre de los fabricantes que tienen productos en la base de datos.

SELECT DISTINCT fabricante.codigo, fabricante.nombre
FROM fabricante
JOIN producto ON fabricante.codigo = producto.codigo_fabricante;











