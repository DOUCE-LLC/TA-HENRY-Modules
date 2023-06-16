use henry;

-- 1. ¿Cuantas carreas tiene Henry?     tengo q entrar y contar

select count(idCarrera) from carrera;

-- 2. ¿Cuantos alumnos hay en total?

select count(idAlumno) from alumno;

-- 3. ¿Cuantos alumnos tiene cada cohorte?

select idCohorte, count(*) from alumno
GROUP BY idCohorte;

-- 4. Confecciona un listado de los alumnos ordenado por los últimos alumnos que ingresaron, con nombre y apellido en un solo campo.

select fechaIngreso, concat(nombre, ' ', apellido) as nombreCompleto
from alumno
order by fechaIngreso DESC;

-- 5. ¿Cual es el nombre del primer alumno que ingreso a Henry?
-- 6. ¿En que fecha ingreso?

select nombre, apellido, fechaIngreso from alumno
order by fechaIngreso ASC
limit 1;

-- 7. ¿Cual es el nombre del ultimo alumno que ingreso a Henry?

select nombre, apellido, fechaIngreso from alumno
order by fechaIngreso DESC
limit 1;

-- 8. La función YEAR le permite extraer el año de un campo date,
-- utilice esta función y especifique cuantos alumnos ingresarona a Henry por año.

select year(fechaIngreso), count(idAlumno) from alumno
group by year(fechaIngreso);

-- 9. ¿Cuantos alumnos ingresaron por semana a henry?, indique también el año. WEEKOFYEAR()

select year(fechaIngreso), WEEKOFYEAR(fechaIngreso), count(idAlumno) from alumno
group by WEEKOFYEAR(fechaIngreso), year(fechaIngreso);

-- 10. ¿En que años ingresaron más de 20 alumnos?

select year(fechaIngreso), count(idAlumno) from alumno
group by year(fechaIngreso)
having count(idAlumno) > 20;

-- 11. Investigue las funciones TIMESTAMPDIFF() y CURDATE(). 
-- ¿Podría utilizarlas para saber cual es la edad de los instructores?.
-- ¿Como podrías verificar si la función cálcula años completos? Utiliza DATE_ADD().

select nombre, apellido, timestampdiff(year, fechaNacimiento, curdate())
from instructor;

SELECT TIMESTAMPDIFF(DAY, fechaNacimiento, DATE_ADD(fechaNacimiento, INTERVAL 1 DAY)) AS edad_instructor 
FROM instructor;

-- 12. Cálcula:
--            - La edad de cada alumno.
--            - La edad promedio de los alumnos de henry.
--            - La edad promedio de los alumnos de cada cohorte.

select nombre, apellido, timestampdiff(year, fechaNacimiento, curdate()) from alumno

select 

-- 13. Elabora un listado de los alumnos que superan la edad promedio de Henry.

