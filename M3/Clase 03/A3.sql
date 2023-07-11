-- tabla de outliers HECHA
-- falta: algo q vea si el producto es un oulier, KPI de ganancias

USE henry_m3;
SET SQL_SAFE_UPDATES=0;

-- 1. Es necesario contar con una tabla de localidades del país con el fin de evaluar la apertura de una nueva sucursal y mejorar nuestros datos. 
-- A partir de los datos en las tablas: cliente, sucursal y proveedor hay que generar una tabla definitiva de Localidades y Provincias. Utilizando la nueva tabla de Localidades controlar y corregir (Normalizar) los campos Localidad y Provincia de las tab vlas cliente, sucursal y proveedor.

-- creamos una tabla con un valores duplicados. uno que actualizaremos, luego el otro borraremos.
DROP TABLE IF EXISTS aux_localidad;
CREATE TABLE IF NOT EXISTS aux_localidad (
  Localidad_Original      VARCHAR(80),
	Provincia_Original      VARCHAR(50),
	Localidad_Normalizada	  VARCHAR(80),
	Provincia_Normalizada	  VARCHAR(50),
	IdLocalidad             INTEGER
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- insertamos y unimos todos los datos de las 3 tablas (cliente, sucursal, proveedor) en una.
INSERT INTO aux_localidad (Localidad_Original, Provincia_Original, Localidad_Normalizada, Provincia_Normalizada, IdLocalidad)
SELECT DISTINCT Localidad, Provincia, Localidad, Provincia, 0 FROM cliente
UNION
SELECT DISTINCT Localidad, Provincia, Localidad, Provincia, 0 FROM sucursal
UNION
SELECT DISTINCT Ciudad, Provincia, Ciudad, Provincia, 0 FROM proveedor
ORDER BY 2, 1;

-- verifico si hay duplicados
-- select Localidad_Original, count(*) from aux_localidad as loc1 group by Localidad_Original;
-- veo que provincias hay 
-- SELECT Provincia_Original, count(*) FROM aux_localidad GROUP BY Provincia_Original;

-- des-duplicamos datos en p. bs as
UPDATE `aux_localidad` SET Provincia_Normalizada = 'Buenos Aires'
WHERE Provincia_Original IN ('B. Aires',
                            'B.Aires',
                            'Bs As',
                            'Bs.As.',
                            'Buenos Aires',
                            'C Debuenos Aires',
                            'Caba',
                            'Ciudad De Buenos Aires',
                            'Pcia Bs As',
                            'Prov De Bs As.',
                            'Provincia De Buenos Aires');

-- des-duplicamos datos en p. cordoba
UPDATE `aux_localidad` SET Provincia_Normalizada = 'Córdoba'
WHERE Provincia_Original IN ('Córdoba',
                            'CÃ³rdoba');

UPDATE `aux_localidad` SET Provincia_Normalizada = 'Entre Rios'
WHERE Provincia_Original IN ('Entre Rios',
                            'Entre RÃ­os');

UPDATE `aux_localidad` SET Provincia_Normalizada = 'Neuquén'
WHERE Provincia_Original IN ('Neuquén',
                            'NeuquÃ©n');

UPDATE `aux_localidad` SET Provincia_Normalizada = 'Tucuman'
WHERE Provincia_Original IN ('TUCUMAN',
                            'Tucuman',
                            'TucumÃ¡n');

-- des-duplicamos datos en l. caba
UPDATE `aux_localidad` SET Localidad_Normalizada = 'Capital Federal'
WHERE Localidad_Original IN ('Boca De Atencion Monte Castro',
                            'Caba',
                            'Cap.   Federal',
                            'Cap. Fed.',
                            'Capfed',
                            'Capital',
                            'Capital Federal',
                            'Cdad De Buenos Aires',
                            'Ciudad De Buenos Aires')
AND Provincia_Normalizada = 'Buenos Aires';

-- des-duplicamos datos en l. cordoba
UPDATE `aux_localidad` SET Localidad_Normalizada = 'Córdoba'
WHERE Localidad_Original IN ('Coroba',
                            'Cordoba',
							'Cã³rdoba')
AND Provincia_Normalizada = 'Cordoba';

-- verifico si hay duplicados
-- select Localidad_Normalizada, count(*) from aux_localidad GROUP BY Localidad_Normalizada;
-- SELECT Provincia_Normalizada, count(*) FROM aux_localidad GROUP BY Provincia_Normalizada;
-- NO HAY ERRORES :)



-- creamos la tabla localidad.
DROP TABLE IF EXISTS `localidad`;
CREATE TABLE IF NOT EXISTS `localidad` (
  `IdLocalidad` int(11) NOT NULL AUTO_INCREMENT,
  `Localidad` varchar(80) NOT NULL,
  `IdProvincia` int(11) NOT NULL,
  `Provincia` varchar(80) NOT NULL,
  PRIMARY KEY (`IdLocalidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- insertamos en localidad, los datos
INSERT INTO Localidad (Localidad, Provincia, IdProvincia)
SELECT DISTINCT Localidad_Normalizada, Provincia_Normalizada, 0
FROM aux_localidad
ORDER BY Provincia_Normalizada, Localidad_Normalizada;



-- creamos la tabla de provincias
DROP TABLE IF EXISTS `provincia`;
CREATE TABLE IF NOT EXISTS `provincia` (
  `IdProvincia` int(11) NOT NULL AUTO_INCREMENT,
  `Provincia` varchar(50) NOT NULL,
  PRIMARY KEY (`IdProvincia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- insertamos datos en provincia
INSERT INTO provincia (Provincia)
SELECT DISTINCT Provincia_Normalizada
FROM aux_localidad
ORDER BY Provincia_Normalizada;



-- transforma los id de localidad, de 0 a uno unico.
UPDATE localidad l JOIN provincia p
  ON (l.Provincia = p.Provincia)
SET l.IdProvincia = p.IdProvincia;


-- select * from provincia;
-- select * from localidad;


-- 2) Es necesario discretizar el campo edad en la tabla cliente.
ALTER TABLE cliente DROP rango_etario;

ALTER TABLE cliente ADD rango_etario VARCHAR(10);
UPDATE cliente SET rango_etario =
  CASE
    WHEN Edad < 18 THEN '0-18'
    WHEN Edad >= 18 AND Edad < 25 THEN '18-24'
    WHEN Edad >= 25 AND Edad < 35 THEN '25-34'
    WHEN Edad >= 35 AND Edad < 45 THEN '35-44'
    WHEN Edad >= 45 AND Edad < 55 THEN '45-54'
    WHEN Edad >= 55 AND Edad < 65 THEN '55-64'
    WHEN Edad >= 65 THEN '65+'
  END;


-- 1) Aplicar alguna técnica de detección de Outliers en la tabla ventas, sobre los campos Precio y Cantidad.

-- 3 Sigma
SELECT IdProducto, avg(Precio) as promedio, avg(Precio) + (3 * stddev(Precio)) as maximo, avg(Precio) - (3 * stddev(Precio)) as minimo
from venta
GROUP BY IdProducto;