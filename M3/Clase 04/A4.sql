USE henry_m3;

-- 1. Genere 5 consultas simples con alguna función de agregación y filtrado sobre las tablas. Anote los resultados del la ficha de estadísticas.


-- 0.437 segundos   0.344
SELECT
    producto.Producto AS producto,
    COUNT(*) AS cantidad_vendida,
    SUM(venta.Cantidad) AS cantidad_total_vendida
FROM venta
JOIN producto ON venta.IdProducto = producto.IdProducto
WHERE
  venta.Fecha BETWEEN '2019-01-01' AND '2020-01-01'
GROUP BY 
  producto.Producto;

-- cantidad_vendida es la cantidad de veces que un cliente fue y compro algo sin tener en cuenta cuantas unidades compro en esa venta.
-- cantidad_total_vendida lo toma en cuenta
-- Si juan va a la ferreteria y compra 50 tornillos  =>  cantidad_vendida=1, cantidad_total_vendida=50


-- 2. A partir del conjunto de datos elaborado en clases anteriores, genere las PK de cada una de las tablas a partir del campo que cumpla con los requisitos correspondientes.


-- borramos las PRIMARY KEY
-- ALTER TABLE venta DROP PRIMARY KEY;
-- ALTER TABLE producto DROP PRIMARY KEY;
-- ALTER TABLE canal_venta DROP PRIMARY KEY;
-- ALTER TABLE cliente DROP PRIMARY KEY;
-- ALTER TABLE compra DROP PRIMARY KEY;
-- ALTER TABLE empleado DROP PRIMARY KEY;
-- ALTER TABLE gasto DROP PRIMARY KEY;
-- ALTER TABLE proveedor DROP PRIMARY KEY;
-- ALTER TABLE sucursal DROP PRIMARY KEY;
-- ALTER TABLE tipo_gasto DROP PRIMARY KEY;

-- agragamos las PRIMARY KEY
-- ALTER TABLE venta ADD PRIMARY KEY (IdVenta);
-- ALTER TABLE producto ADD PRIMARY KEY (IdProducto);
-- ALTER TABLE canal_venta ADD PRIMARY KEY (IdCanal);
-- ALTER TABLE cliente ADD PRIMARY KEY (IdCliente);
-- ALTER TABLE compra ADD PRIMARY KEY (IdCompra);
-- ALTER TABLE empleado ADD PRIMARY KEY (IdEmpleado);
-- ALTER TABLE gasto ADD PRIMARY KEY (IdGasto);
-- ALTER TABLE proveedor ADD PRIMARY KEY (IdProveedor);
-- ALTER TABLE sucursal ADD PRIMARY KEY (IdSucursal);
-- ALTER TABLE tipo_gasto ADD PRIMARY KEY (IdTipoGasto);


-- 3. Genere la indexación de los campos que representen fechas o ID en las tablas:

-- ALTER TABLE venta DROP INDEX IdProducto, DROP INDEX Fecha, DROP INDEX IdProducto_2, DROP INDEX Fecha_2, DROP INDEX IdProducto_3, DROP INDEX Fecha_3, DROP INDEX Fecha_4;

-- - venta.
-- ALTER TABLE venta ADD INDEX(Fecha);
-- ALTER TABLE venta ADD INDEX(Fecha_Entrega);
-- ALTER TABLE venta ADD INDEX(IdCanal);
-- ALTER TABLE venta ADD INDEX(IdCliente);
-- ALTER TABLE venta ADD INDEX(IdSucursal);
-- ALTER TABLE venta ADD INDEX(IdEmpleado);
-- ALTER TABLE venta ADD INDEX(IdProducto);

-- -- - empleado.
-- ALTER TABLE empleado ADD INDEX(IdSucursal);

-- -- - localidad.
-- ALTER TABLE localidad ADD INDEX(IdProvincia);

-- -- - gasto.
-- ALTER TABLE gasto ADD INDEX(IdSucursal);
-- ALTER TABLE gasto ADD INDEX(IdTipoGasto);
-- ALTER TABLE gasto ADD INDEX(Fecha);

-- -- - cliente.
-- ALTER TABLE cliente ADD INDEX(Fecha_Alta);

-- -- - compra.
-- ALTER TABLE compra ADD INDEX(Fecha);
-- ALTER TABLE compra ADD INDEX(IdProducto);
-- ALTER TABLE compra ADD INDEX(IdProveedor);

-- - canal_venta.       NO TIENEN.  
-- - producto.          NO TIENEN.
-- - tipo_producto.     NO TIENEN.    
-- - sucursal.          NO TIENEN.
-- - proveedor.         NO TIENEN.

-- AHORA TODA LA DB ESTA INDEXADA


-- 4. Ahora que las tablas están indexadas, vuelva a ejecutar las consultas del punto 1 y evalue las estadístias. ¿Nota alguna diferencia?.

-- 0.234 segundos   vs    0.343 segundos
SELECT
    producto.Producto AS producto,
    COUNT(*) AS cantidad_vendida,
    SUM(venta.Cantidad) AS cantidad_total_vendida
FROM venta
JOIN producto ON venta.IdProducto = producto.IdProducto
WHERE
  venta.Fecha BETWEEN '2019-01-01' AND '2020-01-01'
GROUP BY 
  producto.Producto;


-- 5. Genere una nueva tabla que lleve el nombre fact_venta (modelo estrella) que pueda agrupar los hechos relevantes de la tabla venta, los campos a considerar deben ser los siguientes:

-- IdVenta, Fecha, Fecha_Entrega, IdCanal, IdCliente, IdEmpleado, IdProducto, Precio, Cantidad.

DROP TABLE IF EXISTS `fact_venta`;
CREATE TABLE IF NOT EXISTS `fact_venta` (
  `IdVenta`       int(11) NOT NULL,
  `Fecha`         date NOT NULL,
  `Fecha_Entrega` date NOT NULL,
  `IdCanal`       varchar(80) NOT NULL,
  `IdCliente`     varchar(80) NOT NULL,
  `IdEmpleado`    int(11) NOT NULL,
  `IdProducto`    varchar(80) NOT NULL,
  `Precio`        varchar(80) NOT NULL,
  `Cantidad`      varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
INSERT INTO fact_venta
SELECT IdVenta, Fecha, Fecha_Entrega, IdCanal, IdCliente, IdEmpleado, IdProducto, Precio, Cantidad
FROM venta
WHERE YEAR(Fecha) = 2020;
-- ALTER TABLE `fact_venta` ADD PRIMARY KEY(`IdVenta`);
-- ALTER TABLE `fact_venta` ADD INDEX(`IdProducto`);
-- ALTER TABLE `fact_venta` ADD INDEX(`IdEmpleado`);
-- ALTER TABLE `fact_venta` ADD INDEX(`Fecha`);
-- ALTER TABLE `fact_venta` ADD INDEX(`Fecha_Entrega`);
-- ALTER TABLE `fact_venta` ADD INDEX(`IdCliente`);
-- ALTER TABLE `fact_venta` ADD INDEX(`IdCanal`);


-- Empleado:
DROP TABLE IF EXISTS `dim_empleado`;
CREATE TABLE IF NOT EXISTS `dim_empleado` (
  `IdEmpleado`       int(9) NOT NULL,
  `CodigoEmpleado`  int(6) NOT NULL,
  `Apellido`        varchar(50) NOT NULL,
  `Nombre`          varchar(50) NOT NULL,
  `IdSucursal`      int(11) NOT NULL,
  `Sector`          varchar(80) NOT NULL,
  `Cargo`           varchar(80) NOT NULL,
  `Salario2`        int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
INSERT INTO dim_empleado
SELECT IdEmpleado, CodigoEmpleado, Apellido, Nombre, IdSucursal, Sector, Cargo, Salario2
FROM empleado;
-- ALTER TABLE `dim_empleado` ADD PRIMARY KEY(`IdEmpleado`);
-- ALTER TABLE `dim_empleado` ADD INDEX(`IdSucursal`);
-- ALTER TABLE `dim_empleado` ADD INDEX(`Salario2`);
-- ALTER TABLE `dim_empleado` ADD INDEX(`Sector`);


-- Sucursal:
DROP TABLE IF EXISTS `dim_sucursal`;
CREATE TABLE IF NOT EXISTS `dim_sucursal` (
  `IdSucursal`      int(9) NOT NULL,
  `Sucursal`        varchar(50) NOT NULL,
  `Domicilio`       varchar(50) NOT NULL,
  `Localidad`       varchar(50) NOT NULL,
  `Provincia`       varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
INSERT INTO dim_sucursal
SELECT IdSucursal, Sucursal, Domicilio, Localidad, Provincia
FROM sucursal;
-- ALTER TABLE `dim_sucursal` ADD PRIMARY KEY(`IdSucursal`);
-- ALTER TABLE `dim_sucursal` ADD INDEX(`Sucursal`);
-- ALTER TABLE `dim_sucursal` ADD INDEX(`Domicilio`);
-- ALTER TABLE `dim_sucursal` ADD INDEX(`Localidad`);
-- ALTER TABLE `dim_sucursal` ADD INDEX(`Provincia`);



-- Cliente:
DROP TABLE IF EXISTS `dim_cliente`;
CREATE TABLE IF NOT EXISTS `dim_cliente` (
  `IdCliente`           int(9) NOT NULL,
  `Provincia`           varchar(50) NOT NULL,
  `Nombre_y_Apellido`   varchar(100) NOT NULL,
  `Domicilio`           varchar(150) NOT NULL,
  `Telefono`            varchar(50) NOT NULL,
  `Edad`                int(3) NOT NULL,
  `Localidad`           varchar(100) NOT NULL,
  `Fecha_Alta`          DATE NOT NULL,
  `rango_etario`        varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO dim_cliente
SELECT IdCliente, Provincia, Nombre_y_Apellido, Domicilio, Telefono, Edad, Localidad, Fecha_Alta, rango_etario
FROM cliente;

-- ALTER TABLE `dim_cliente` ADD PRIMARY KEY(`IdCliente`);
-- ALTER TABLE `dim_cliente` ADD INDEX(`Provincia`);
-- ALTER TABLE `dim_cliente` ADD INDEX(`Nombre_y_Apellido`);
-- ALTER TABLE `dim_cliente` ADD INDEX(`Domicilio`);
-- ALTER TABLE `dim_cliente` ADD INDEX(`Telefono`);
-- ALTER TABLE `dim_cliente` ADD INDEX(`Edad`);
-- ALTER TABLE `dim_cliente` ADD INDEX(`Localidad`);
-- ALTER TABLE `dim_cliente` ADD INDEX(`Fecha_Alta`);
-- ALTER TABLE `dim_cliente` ADD INDEX(`rango_etario`);



-- Producto:
DROP TABLE IF EXISTS `dim_producto`;
CREATE TABLE IF NOT EXISTS `dim_producto` (
  `IdProducto`  int(9) NOT NULL,
  `Producto`    varchar(100) NOT NULL,
  `Tipo`        varchar(50) NOT NULL,
  `Precio`      float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
INSERT INTO dim_producto
SELECT IdProducto, Producto, Tipo, Precio
FROM producto;
ALTER TABLE `dim_producto` ADD PRIMARY KEY(`IdProducto`);
ALTER TABLE `dim_producto` ADD INDEX(`Producto`);
ALTER TABLE `dim_producto` ADD INDEX(`Tipo`);
ALTER TABLE `dim_producto` ADD INDEX(`Precio`)

-- 6. A partir de la tabla creada en el punto anterior, deberá poblarla con los datos de la tabla ventas.

-- fact_venta: venta, canal_venta, cliente, empleado, producto.




