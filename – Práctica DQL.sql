-- ================================
-- Script de practica DQL
-- ================================
-- Crear base

CREATE DATABASE practica_dql_futbol;
USE practica_dql_futbol;

-- Tabla clientes (jugadores de futbol)

CREATE TABLE clientes (
id_cliente INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
apellido VARCHAR(50) NOT NULL,
direccion VARCHAR(100),
email VARCHAR(100)
);

-- Insertar jugadores latinos famosos (sin tildes)

INSERT INTO clientes (nombre, apellido, direccion, email) VALUES
('Lionel', 'Messi', 'Rosario, Argentina', 'messi@example.com'),
('Diego', 'Maradona', 'Buenos Aires, Argentina',
'maradona@example.com'),
('Gabriel', 'Batistuta', 'Reconquista, Argentina',
'batistuta@example.com'),
('Juan', 'Riquelme', 'Don Torcuato, Argentina',
'riquelme@example.com'),
('Carlos', 'Tevez', 'Fuerte Apache, Argentina',
'tevez@example.com'),
('Angel', 'Di Maria', 'Rosario, Argentina', 'dimaria@example.com'),
('Pele', 'Nascimento', 'Minas Gerais, Brasil', 'pele@example.com'),
('Ronaldinho', 'Gaucho', 'Porto Alegre, Brasil',
'ronaldinho@example.com'),
('Neymar', 'Junior', 'Mogi das Cruzes, Brasil',
'neymar@example.com'),
('Luis', 'Suarez', 'Salto, Uruguay', 'suarez@example.com');

-- Tabla libros
CREATE TABLE libros (
id_libro INT AUTO_INCREMENT PRIMARY KEY,
titulo VARCHAR(100) NOT NULL,
precio DECIMAL(10,2) NOT NULL
);

-- Insertar libros
INSERT INTO libros (titulo, precio) VALUES
('Introduccion a SQL', 25.00),
('Bases de Datos Avanzadas', 80.50),
('Programacion en Java', 55.00),
('Fundamentos de Redes', 40.75),
('Estructuras de Datos', 62.30),
('Inteligencia Artificial', 120.00),
('Desarrollo Web', 35.90),
('Big Data y Analitica', 95.00),
('Python para Principiantes', 20.00),
('Machine Learning Practico', 150.00);


-- 1. Listar todos los clientes Mostrar nombre, apellido y dirección de todos los jugadores registrados.
SELECT nombre,apellido,direccion
FROM clientes;
-- 2. Filtro por valor exacto Mostrar los datos del jugador cuyo apellido sea 'Messi'.
SELECT nombre,apellido,direccion,email
FROM clientes
WHERE apellido='Messi';
-- 3. Comparación numérica Listar el título y precio de los libros cuyo precio sea mayor a 50.
SELECT titulo,precio
FROM libros
WHERE (precio) >50.0;
-- 4. Filtro por rango Mostrar el título y precio de los libros cuyo precio esté entre 20 y 60.
SELECT titulo,precio
FROM libros
WHERE precio BETWEEN 20 AND 60;
-- 5. Filtro por patrón Listar nombre y apellido de los jugadores cuyo apellido comience con la letra 'R'.
SELECT nombre,apellido
FROM clientes
WHERE apellido LIKE 'R%';
-- 6. Filtro por conjunto Mostrar los jugadores cuyo apellido sea 'Maradona', 'Pele' o 'Ronaldinho'.
SELECT nombre,apellido,direccion,email
FROM clientes
WHERE apellido IN('Maradona','Pele','Ronaldinho');
-- 7. LIMIT Listar los 3 primeros libros de la tabla libros.
SELECT * FROM libros LIMIT 3;
-- 8. Alias de columnas Listar nombre y apellido de los jugadores, pero mostrando los resultados con alias:
-- ○ NombreJugador
-- ○ ApellidoJugador
SELECT
nombre AS NombreJugador,
apellido AS ApellidoJugador
FROM clientes;


