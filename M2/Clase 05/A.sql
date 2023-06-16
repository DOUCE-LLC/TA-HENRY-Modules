DROP DATABASE henry;
CREATE DATABASE HENRY;
USE henry;

CREATE TABLE henry (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(15)
);

INSERT INTO henry (nombre) VALUES ('Carrea');
INSERT INTO henry (nombre) VALUES ('Cohorte');
INSERT INTO henry (nombre) VALUES ('Instructores');
INSERT INTO henry (nombre) VALUES ('Alumnos');

-- Carrea: ID, Nombre.
CREATE TABLE Carrea (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(15) NOT NULL,
    materias VARCHAR(15) NOT NULL,
    PRIMARY KEY (id)
);

-- Cohorte: ID, Código, Carrera, Fecha de Inicio, Fecha de Finalización, Instructor.
CREATE TABLE Cohorte (
    id INT NOT NULL AUTO_INCREMENT,
    codigo VARCHAR(5),
    nombre VARCHAR(10) NOT NULL,
    carrera VARCHAR(15) NOT NULL,
    instructor VARCHAR(20) NOT NULL,
    inicio DATE NOT NULL,
	fin DATE NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES Carrea(id)
);

-- Instructores: ID, Cédula de identidad, Nombre, Apellido, Fecha de Nacimiento, Fecha de Incorporación.
CREATE TABLE Instructores (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(15) NOT NULL,
    nacionalidad VARCHAR(15) NOT NULL,
    dni VARCHAR(9) NOT NULL,
    estudios VARCHAR(15),
    nacimiento DATE NOT NULL,
    primeraClase DATE NOT NULL,
    sueldo INT NOT NULL,
    cohortesTotal VARCHAR(300) NOT NULL,
    cohorteActual VARCHAR(10),
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES Cohorte(id)
);

-- Alumnos: ID, Cédula de identidad, Nombre, Apellido, Fecha de Nacimiento, Fecha de Ingreso, Cohorte.
CREATE TABLE Alumnos (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(15) NOT NULL,
    nacionalidad VARCHAR(15) NOT NULL,
    dni VARCHAR(15) NOT NULL,
    nacimiento DATE NOT NULL,
    ingreso DATE NOT NULL,
    cohorteCode VARCHAR(5) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES Cohorte(id)
);

DESC Carrea;
DESC Cohorte;
DESC Instructores;
DESC Alumnos;