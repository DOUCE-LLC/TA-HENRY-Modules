-- 10) Generar dos nuevas tablas a partir de la tabla 'empelado' que contengan las entidades Cargo y Sector.
-- 11) Generar una nueva tabla a partir de la tabla 'producto' que contenga la entidad Tipo de Producto.


use henry_m3;
SET SQL_SAFE_UPDATES=0;

-- cliente
-- elimino columnas innesecarias
ALTER TABLE cliente DROP COLUMN Usuario_Alta;
ALTER TABLE cliente DROP COLUMN col10;
ALTER TABLE cliente DROP COLUMN Fecha_Ultima_Modificacion;
ALTER TABLE cliente DROP COLUMN Usuario_Ultima_Modificacion;
ALTER TABLE cliente DROP COLUMN marca_baja;
ALTER TABLE cliente DROP COLUMN X;
ALTER TABLE cliente DROP COLUMN Y;
-- le damos valor 'Sin Dato' a los nulos.
UPDATE `cliente` SET Provincia = 'Sin Dato' WHERE TRIM(Provincia) = "" OR ISNULL(Provincia);
UPDATE `cliente` SET Nombre_y_Apellido = 'Sin Dato' WHERE TRIM(Nombre_y_Apellido) = "" OR ISNULL(Nombre_y_Apellido);
UPDATE `cliente` SET Domicilio = 'Sin Dato' WHERE TRIM(Domicilio) = "" OR ISNULL(Domicilio);
UPDATE `cliente` SET Telefono = 'Sin Dato' WHERE TRIM(Telefono) = "" OR ISNULL(Telefono);
UPDATE `cliente` SET Edad = 'Sin Dato' WHERE TRIM(Edad) = "" OR ISNULL(Edad);
UPDATE `cliente` SET Localidad = 'Sin Dato' WHERE TRIM(Localidad) = "" OR ISNULL(Localidad);
UPDATE `cliente` SET Fecha_Alta = 'Sin Dato' WHERE TRIM(Fecha_Alta) = "" OR ISNULL(Fecha_Alta);

-- compra OK
-- empleado OK
-- gasto OK
-- canal_venta OK

-- producto
-- le doy valor 'Sin Dato' a los nulos.
UPDATE `producto` SET Tipo = 'Sin Dato' WHERE TRIM(Tipo) = "" OR ISNULL(Tipo);
UPDATE `producto` SET Precio = 'Sin Dato' WHERE TRIM(Precio) = "" OR ISNULL(Precio);

-- proveedor
-- le doy valor 'Sin Dato' a los nulos.
UPDATE `proveedor` SET Nombre = 'Sin Dato' WHERE TRIM(Nombre) = "" OR ISNULL(Nombre);

-- sucursal
-- elimino columnas innesecarias
ALTER TABLE sucursal DROP COLUMN Latitud2;
ALTER TABLE sucursal DROP COLUMN Longitud2;

-- venta
-- le doy valor 'Sin Dato' a los nulos.
UPDATE `venta` SET Precio = 'Sin Dato' WHERE TRIM(Precio) = "" OR ISNULL(Precio);
UPDATE `venta` SET Cantidad = 'Sin Dato' WHERE TRIM(Cantidad) = "" OR ISNULL(Cantidad);



-- Renombramos los IDs
ALTER TABLE cliente RENAME COLUMN ID TO IdCliente;
ALTER TABLE proveedor RENAME COLUMN IDProveedor TO IdProveedor;
ALTER TABLE sucursal RENAME COLUMN ID TO IdSucursal;
ALTER TABLE tipo_gasto RENAME COLUMN Descripcion TO Tipo_Gasto;
ALTER TABLE producto RENAME COLUMN IDProducto TO IdProducto;
ALTER TABLE producto RENAME COLUMN Concepto TO Producto;



/*Chequeo de claves duplicadas*/
-- SELECT IdSucursal, COUNT(*) FROM sucursal GROUP BY IdSucursal HAVING COUNT(*) > 1;
SELECT IdEmpleado, COUNT(*) FROM empleado GROUP BY IdEmpleado HAVING COUNT(*) > 1;

-- empleado tiene un campo sucursal
-- sucursal no se relaciona con empleado
-- sucursal tiene valores duplicados pero =, tengo q eliminarlos

CREATE TABLE sucursal2 AS
SELECT DISTINCT *
FROM sucursal;
DROP TABLE sucursal;
ALTER TABLE sucursal2 RENAME TO sucursal;

-- SELECT IdSucursal, COUNT(*) FROM sucursal GROUP BY IdSucursal HAVING COUNT(*) > 1;
-- YA NO HAY DUPLICADOS EN SUCURSAL

-- EMPLEADO...

-- multiplicamos y luego incrementamos, para que no haya repetidos
-- UPDATE empleado SET IdEmpleado = IdEmpleado * 10;
-- ALTER TABLE empleado MODIFY COLUMN IdEmpleado INT AUTO_INCREMENT PRIMARY KEY;
-- ALTER TABLE empleado
-- ADD PRIMARY KEY (IdEmpleado);


-- agregamos el idSucursal a la tabla empleado
ALTER TABLE empleado ADD IdSucursal INT NULL DEFAULT 0 AFTER Sucursal;

-- le agregamos los valores idsucursal a empleado
UPDATE empleado e JOIN sucursal s
	ON (e.Sucursal = s.Sucursal)
SET e.IdSucursal = s.IdSucursal;

-- eliminamos la sucursal porque ya tenemos el id
ALTER TABLE empleado DROP Sucursal;

-- creamos la columna CodigoEmpleado en 0
ALTER TABLE empleado ADD CodigoEmpleado INT NULL DEFAULT 0 AFTER IdEmpleado;

-- hacemos q valga lo mismo que el id
UPDATE empleado SET CodigoEmpleado = IdEmpleado;
-- transformamos IdEmpleado en (IdSucursal * 1000000) + CodigoEmpleado
UPDATE empleado SET IdEmpleado = (IdSucursal * 1000000) + CodigoEmpleado;

-- se multiplica por un numero grande como 1000000
-- para que se aprecien ambos IDs
-- IdSucursal = 13      se transforma en 1300
-- IdEmpleado = 1516
-- final = 13001516

-- verificamos si hay duplicados
SELECT IdEmpleado, COUNT(*) FROM empleado GROUP BY IdEmpleado HAVING COUNT(*) > 1;


