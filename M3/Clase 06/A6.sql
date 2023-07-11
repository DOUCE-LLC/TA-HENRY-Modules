use henry_m3;

-- 1. Crear un procedimiento que recibe como parametro una fecha y muestre el listado de productos que se vendieron en esa fecha.

DELIMITER $$
DROP PROCEDURE IF EXISTS listaProductos;
CREATE PROCEDURE listaProductos (IN fecha DATE)
BEGIN
    -- SELECT IdProducto, Fecha
    -- FROM venta
    -- WHERE Fecha = fecha;
    SELECT DISTINCT p.Producto, v.Fecha
    FROM producto p JOIN venta v
    ON v.IdProducto = p.IdProducto
    WHERE V.Fecha = fecha;
END $$
DELIMITER ;

CALL listaProductos('2020-01-01');

-- 2. Crear una función que calcule el valor nominal de un margen bruto determinado por el usuario a partir del precio de lista de los productos.

SET GLOBAL log_bin_trust_function_creators = 1;

DELIMITER $$
DROP FUNCTION IF EXISTS margenBruto;
CREATE FUNCTION margenBruto(precio DECIMAL(15,3), margen DECIMAL (9,2)) 
RETURNS DECIMAL (15,3)
BEGIN
	DECLARE margenBruto DECIMAL (15,3);
    SET margenBruto = precio * margen;
    RETURN margenBruto;
END$$
DELIMITER ;
-- select margenBruto(1000, 1.20);

-- 3. Obtner un listado de productos de IMPRESION y utilizarlo para cálcular el valor nominal de un margen bruto del 20% de cada uno de los productos.

DELIMITER $$
DROP PROCEDURE IF EXISTS margenBruto_Impresion;
CREATE PROCEDURE margenBruto_Impresion(IN MARGEN FLOAT)
BEGIN
    SELECT Producto, Tipo, Precio, margenBruto(Precio, MARGEN)
    FROM producto
    WHERE Tipo = 'IMPRESIÓN';
END $$
DELIMITER ;

CALL margenBruto_Impresion(1.20);


-- 4. Crear un procedimiento que permita listar los productos vendidos desde fact_venta a partir de un "Tipo" que determine el usuario.

DELIMITER $$
DROP PROCEDURE IF EXISTS listaCategoria;
CREATE PROCEDURE listaCategoria(IN TIPO VARCHAR(50))
BEGIN
    SELECT p.Producto, p.Tipo
    FROM dim_producto p JOIN fact_venta v
    ON v.IdProducto = p.IdProducto
    WHERE p.Tipo COLLATE utf8mb4_spanish_ci = TIPO COLLATE utf8mb4_spanish_ci;
END $$
DELIMITER ;
 
CALL listaCategoria('INFORMATICA');

-- 5. Crear un procedimiento que permita realizar la insercción de datos en la tabla fact_venta.

-- 6. Crear un procedimiento almacenado que reciba un grupo etario y devuelta el total de ventas para ese grupo.

DELIMITER $$
DROP PROCEDURE IF EXISTS listaCategoria;
CREATE PROCEDURE listaCategoria(IN TIPO VARCHAR(50))
BEGIN
    SELECT p.Producto, p.Tipo
    FROM dim_producto p JOIN fact_venta v
    ON v.IdProducto = p.IdProducto
    WHERE p.Tipo COLLATE utf8mb4_spanish_ci = TIPO COLLATE utf8mb4_spanish_ci;
END $$
DELIMITER ;
 
CALL listaCategoria('INFORMATICA');

-- 7. Crear una variable que se pase como valor para realizar una filtro sobre Rango_etario en una consulta génerica a dim_cliente.
-- 8. Utilizar la funcion provista 'UC_Words' para modificar a letra capital los campos que contengan descripciones para todas las tablas.
-- 9. Utilizar el procedimiento provisto 'Llenar_Calendario' para poblar la tabla de calendario.