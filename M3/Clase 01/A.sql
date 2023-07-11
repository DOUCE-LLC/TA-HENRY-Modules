-- La Dirección de Ventas ha solicitado las siguientes tablas a Marketing con el fin de que sean integradas:
    -- La tabla de puntos de venta propios, un Excel frecuentemente utilizado para contactar a cada sucursal, actualizada en 2021.
    -- La tabla de empleados, un Excel mantenido por el personal administrativo de RRHH.
    -- La tabla de proveedores, un Excel mantenido por un analista de otra dirección que ya no esta en la empresa. 
    -- La tabla de clientes, alojada en el CRM de la empresa.
    -- La tabla de productos, un Excel mantenido por otro analista.
    -- Las tablas de ventas, gastos y compras, tres archivos CSV generados a partir del sistema transaccional de la empresa.

DROP DATABASE IF EXISTS henry_m3;
CREATE DATABASE IF NOT EXISTS henry_m3;

USE henry_m3;

-- CanalDeVenta
DROP TABLE IF EXISTS canal_venta;
CREATE TABLE IF NOT EXISTS canal_venta (
IdCanal INTEGER,
Canal VARCHAR(25)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\CanalDeVenta.csv'
INTO TABLE canal_venta
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
(IdCanal, Canal);