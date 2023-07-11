USE henry_m3;

-- 1. Obtener un listado del nombre y apellido de cada cliente que haya adquirido algun producto junto al id del producto y su respectivo precio.

SELECT c.Nombre_y_Apellido, v.IdProducto, v.Precio
FROM cliente c
JOIN venta v
ON c.IdCliente = v.IdCliente;

-- 2. Obteber un listado de clientes con la cantidad de productos adquiridos, incluyendo aquellos que nunca compraron algún producto.

SELECT c.Nombre_y_Apellido, count(v.IdProducto)
FROM cliente c
INNER JOIN venta v
ON c.IdCliente = v.IdCliente
GROUP BY c.Nombre_y_Apellido;

-- 3. Obtener un listado de cual fue el volumen de compra (cantidad) por año de cada cliente. 

-- Esto funciona pero esta mal. el parametro deberia ser el id de cliente, y la tabla te deberia dar una lista de los años en los q compro.
DELIMITER $$
DROP PROCEDURE IF EXISTS compraClienteAño;
CREATE PROCEDURE compraClienteAño(IN FECHA DATE)
BEGIN
    SELECT c.IdCliente, c.Nombre_y_Apellido, count(v.IdProducto), YEAR(v.Fecha)
    FROM cliente c
    INNER JOIN venta v
    ON c.IdCliente = v.IdCliente
    WHERE YEAR(v.Fecha) = YEAR(FECHA)
    GROUP BY c.IdCliente, c.Nombre_y_Apellido, YEAR(v.Fecha);
END $$
DELIMITER ;

CALL compraClienteAño('2020-06-07');

-- 4. Obtener un listado del nombre y apellido de cada cliente que haya adquirido algun producto junto al id del producto, la cantidad de productos adquiridos y el precio promedio.

SELECT c.Nombre_y_Apellido, count(v.IdProducto), AVG(v.Precio)
FROM cliente c
JOIN venta v
ON c.IdCliente = v.IdCliente
GROUP BY c.IdCliente, c.Nombre_y_Apellido;

-- 5. Cacular la cantidad de productos vendidos y la suma total de ventas para cada localidad, presentar el análisis en un listado con el nombre de cada localidad.

SELECT s.Localidad, count(v.IdVenta)
FROM sucursal s
JOIN venta v
ON s.IdSucursal = v.IdSucursal
GROUP BY s.IdSucursal;

-- 6. Cacular la cantidad de productos vendidos y la suma total de ventas para cada provincia, presentar el análisis en un listado con el nombre de cada provincia, pero solo en aquellas donde la suma total de las ventas fue superior a $100.000.

SELECT s.Provincia, SUM((v.Precio * v.Cantidad))
FROM sucursal s
JOIN venta v
ON s.IdSucursal = v.IdSucursal
GROUP BY s.Provincia
HAVING SUM((v.Precio * v.Cantidad)) > 100000;

-- 7. Obtener un listado de cantidad de productos vendidos por rango etario y las ventas totales en base a esta misma dimensión.

SELECT c.rango_etario, count(v.IdVenta)
FROM cliente c
JOIN venta v
ON c.IdCliente = v.IdCliente
GROUP BY c.rango_etario;

-- 8. Obtener la cantidad de clientes por provincia.

SELECT Provincia, COUNT(IdCliente)
FROM dim_cliente
GROUP BY Provincia;