USE henry_m3;

-- 1. Crear una tabla que permita realizar el seguimiento de los usuarios que ingresan nuevos registros en fact_venta.

DROP TABLE IF EXISTS `fact_venta_auditoria`;
CREATE TABLE IF NOT EXISTS `fact_venta_auditoria` (
	`Fecha`				    DATE,
	`Fecha_Entrega`		    DATE,
  	`IdCanal` 			    INTEGER,
  	`IdCliente` 		    INTEGER,
  	`IdEmpleado` 		    INTEGER,
  	`IdProducto` 		    INTEGER,
    `usuario` 			    VARCHAR(20),
    `fechaModificacion` 	DATETIME
);

-- 2. Crear una acción que permita la carga de datos en la tabla anterior.

-- Creamos es triger q va a guardar en nuestra tabla los nuevos clientes que se registren.
DROP TRIGGER IF EXISTS fact_venta_audit;
CREATE TRIGGER fact_venta_audit
AFTER INSERT ON fact_venta
FOR EACH ROW
INSERT INTO fact_venta_auditoria
VALUES (NEW.Fecha, NEW.Fecha_Entrega, NEW.IdCanal, NEW.IdCliente, NEW.IdEmpleado, NEW.IdProducto, CURRENT_USER, NOW());

-- aca borramos todos los registros, esto es para verificar en la practica fictisia que todo funcione correctamente.
-- al insertar los datos en fact_venta, tambien deberian insertarse en fact_venta_auditoria
truncate table fact_venta_auditoria;
truncate table fact_venta;

-- Volvemos a insertar los datos a fact_venta
INSERT INTO fact_venta
SELECT IdVenta, Fecha, Fecha_Entrega, IdCanal, IdCliente, IdEmpleado, IdProducto, Precio, Cantidad
FROM venta
WHERE YEAR(Fecha) = 2020;

-- verificamos que este bien el codigo:
select count(*) from fact_venta_auditoria;
select count(*) from fact_venta;
-- -- TODO EN ORDEN.

-- 3. Crear una tabla que permita registrar la cantidad total registros, luego de cada ingreso la tabla fact_venta.

DROP TABLE IF EXISTS `fact_venta_registros`;
CREATE TABLE IF NOT EXISTS `fact_venta_registros` (
    `IdRegistro`        int NOT NULL AUTO_INCREMENT,
    `cantidadRegistros` int NOT NULL,
    `usuario`           varchar(50) NOT NULL,
    `fecha_hora`        DATETIME,
    PRIMARY KEY (IdRegistro)
);

-- 4. Crear una acción que permita la carga de datos en la tabla anterior.

-- creamos el triger
DROP TRIGGER IF EXISTS fact_venta_reg;
CREATE TRIGGER fact_venta_reg
AFTER INSERT ON fact_venta
FOR EACH ROW
INSERT INTO fact_venta_registros (cantidadRegistros, usuario, fecha_hora)
VALUES ((SELECT COUNT(*) FROM fact_venta),CURRENT_USER,NOW());

-- borramos todos los registros
truncate table fact_venta_auditoria;
truncate table fact_venta;
TRUNCATE TABLE fact_venta_registros;

-- Volvemos a insertar los datos a fact_venta
INSERT INTO fact_venta
SELECT IdVenta, Fecha, Fecha_Entrega, IdCanal, IdCliente, IdEmpleado, IdProducto, Precio, Cantidad
FROM venta
WHERE YEAR(Fecha) = 2020;






-- 5. Crear una tabla que agrupe los datos de la tabla del item 3, a su vez crear un proceso de carga de los datos agrupados.

-- 6. Crear una tabla que permita realizar el seguimiento de la actualización de registros de la tabla fact_venta.

-- 7. Crear una acción que permita la carga de datos en la tabla anterior, para su actualización.

