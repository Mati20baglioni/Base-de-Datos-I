CREATE DATABASE bd1_com9_universidad;
USE bd1_com9_universidad;
-- Alumnos
CREATE TABLE alumnos (
id_alumno INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
apellido VARCHAR(50) NOT NULL,
dni VARCHAR(12),
ciudad VARCHAR(60),
pais VARCHAR(40) DEFAULT 'Argentina'
);
CREATE TABLE materias (
id_materia INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
cuatrimestre TINYINT,
area VARCHAR(50)
);
CREATE TABLE inscripciones (
id_inscripcion INT AUTO_INCREMENT PRIMARY KEY,
id_alumno INT NOT NULL,
id_materia INT NOT NULL,
estado ENUM('regular','libre','promocion','cursando') NOT NULL DEFAULT 'cursando',
nota DECIMAL(4,1) NULL,
CONSTRAINT fk_i_alumno FOREIGN KEY (id_alumno) REFERENCES
alumnos(id_alumno),
CONSTRAINT fk_i_materia FOREIGN KEY (id_materia) REFERENCES
materias(id_materia)
);
-- Datos alumnos (26)
INSERT INTO alumnos (nombre, apellido, dni, ciudad) VALUES
('Emiliano','Martinez','30000001','Mar del Plata'),
('Franco','Armani','30000002','Casilda'),
('Geronimo','Rulli','30000003','La Plata'),
('Nahuel','Molina','30000004','Embalse'),
('Gonzalo','Montiel','30000005','Gonzalez Catan'),
('Cristian','Romero','30000006','Cordoba'),
('German','Pezzella','30000007','Bahia Blanca'),
('Nicolas','Otamendi','30000008','El Talar'),
('Lisandro','Martinez','30000009','Gualeguay'),
('Nicolas','Tagliafico','30000010','Rafael Calzada'),
('Marcos','Acuna','30000011','Zapala'),
('Juan','Foyth','30000012','La Plata'),
('Enzo','Fernandez','30000013','San Martin'),
('Rodrigo','De Paul','30000014','Sarandi'),
('Leandro','Paredes','30000015','San Justo'),
('Exequiel','Palacios','30000016','Famailla'),
('Alexis','Mac Allister','30000017','Santa Rosa'),
('Guido','Rodriguez','30000018','Saavedra'),
('Thiago','Almada','30000019','Ciudad Evita'),
('Angel','Di Maria','30000020','Rosario'),
('Lionel','Messi','30000021','Rosario'),
('Lautaro','Martinez','30000022','Bahia Blanca'),
('Julian','Alvarez','30000023','Calchin'),
('Paulo','Dybala','30000024','Laguna Larga'),
('Angel','Correa','30000025','Rosario'),
('Nicolas','Gonzalez','30000026','Belgrano');
-- Materias (TUP)
INSERT INTO materias (nombre, cuatrimestre, area) VALUES
('Programacion I', 1, 'Programacion'),
('Arquitectura y Sistemas Operativos', 1, 'Sistemas'),
('Matematica', 1, 'Matematica'),
('Organizacion Empresarial', 1, 'Gestion'),
('Ingles I', 1, 'Idiomas'),
('Programacion II', 2, 'Programacion'),
('Probabilidad y Estadistica', 2, 'Matematica'),
('Base de Datos I', 2, 'Bases de Datos'),
('Ingles II', 2, 'Idiomas'),
('Programacion III', 3, 'Programacion'),
('Base de Datos II', 3, 'Bases de Datos'),
('Metodologia de Sistemas I', 3, 'Sistemas'),
('Programacion IV', 4, 'Programacion'),
('Metodologia de Sistemas II', 4, 'Sistemas'),
('Gestion de Desarrollo de Software', 4, 'Gestion'),
('Legislacion', 4, 'Gestion');
-- Inscripciones
INSERT INTO inscripciones (id_alumno, id_materia, estado, nota) VALUES
(21, 1, 'promocion', 9.5), -- Messi
(20, 1, 'promocion', 8.5), -- Di Maria
(1, 1, 'regular', 7.0),
(2, 1, 'regular', 6.0),
(3, 1, 'cursando', NULL),
(4, 3, 'cursando', NULL),
(5, 3, 'regular', 6.5),
(6, 8, 'regular', 7.5), -- BD I
(7, 8, 'cursando', NULL),
(8, 8, 'cursando', NULL),
(9, 11, 'regular', 8.0), -- BD II
(10,11, 'regular', 7.0),
(11,11, 'cursando', NULL),
(12, 2, 'cursando', NULL), -- Arq y SO
(13, 7, 'regular', 7.0), -- Prob y Estadistica
(14,10, 'regular', 6.0), -- Prog III
(15,14, 'cursando', NULL), -- Prog IV
(16,15, 'cursando', NULL), -- Metod II
(17,16, 'cursando', NULL), -- Legislacion
(18, 9, 'regular', 8.0), -- Ingles II
(19, 6, 'regular', 7.0), -- Prog II
(22, 6, 'regular', 6.0),
(23, 8, 'regular', 8.5), -- BD I
(24,13, 'cursando', NULL), -- Prog IV
(25, 1, 'regular', 6.5),
(26, 1, 'cursando', NULL);


-- EJERCICIOS:
-- =====================================================
-- ORDER BY
-- =====================================================
-- 1) Listar alumnos ordenados por apellido y, a igualdad, por nombre.
SELECT apellido,nombre
FROM alumnos
ORDER BY apellido ASC ,nombre ASC;
-- 2) Listar alumnos ordenados por ciudad (asc) y apellido (desc).
SELECT ciudad,apellido
FROM alumnos
ORDER BY ciudad ASC, apellido DESC;
-- 3) Listar alumnos mostrando primero los de "Rosario" y luego el resto.
SELECT ciudad 
FROM alumnos 
ORDER BY ciudad IN ('Rosario') DESC,
ciudad ASC;
-- 4) Listar materias ordenadas por cuatrimestre y luego por nombre.
SELECT cuatrimestre,nombre
FROM materias
ORDER BY cuatrimestre ASC,
nombre ASC;
-- 5) Listar materias ordenadas por area (asc) y, dentro de cada area, por nombre (asc).
SELECT area,nombre
FROM materias
ORDER BY area ASC,
nombre ASC;
-- 6) Listar materias ordenadas por area (asc) y cuatrimestre (desc).
SELECT area,cuatrimestre
FROM materias
ORDER BY area ASC,
cuatrimestre DESC;
-- 7) Listar inscripciones ordenadas por estado y, a igualdad, por nota (desc).
SELECT estado,nota
FROM inscripciones
ORDER BY estado ASC,
nota DESC;
-- 8) Listar inscripciones ordenadas por nota (desc).
SELECT nota
FROM inscripciones
ORDER BY nota DESC;
-- 9) Mostrar los primeros 10 alumnos por orden alfabetico de apellido.
SELECT * FROM alumnos
ORDER BY apellido ASC
LIMIT 10;
-- 10) Listar alumnos ordenados por apellido y, a igualdad, por dni (asc).
SELECT apellido,dni
FROM alumnos
ORDER BY apellido ASC,
dni ASC;
-- =====================================================
-- FUNCIONES DE AGREGACION (10) —
-- =====================================================
-- 1) Cantidad total de alumnos 
SELECT COUNT(*) AS total_alumnos
FROM alumnos;
-- 2) Cantidad total de materias.
SELECT COUNT(*) AS total_materias
FROM materias;
-- 3) Cantidad total de inscripciones.
SELECT COUNT(*) AS total_inscripciones
FROM inscripciones;
-- 4) Promedio general de nota.
SELECT AVG (nota) AS promedio_notas
FROM inscripciones;
-- 5) Nota minima y nota maxima registradas.
SELECT 
MIN(nota) AS nota_minima, 
MAX(nota) AS nota_max
FROM inscripciones;
-- 6) Cantidad de alumnos cuya ciudad sea "Rosario".
SELECT COUNT(*) AS contador_Rosario
FROM alumnos
WHERE ciudad IN ('Rosario');
-- 7) Cantidad de alumnos por pais usando filtro por pais = "Argentina".
SELECT COUNT(*) AS Contador_Argentinos
FROM alumnos
WHERE pais IN ('Argentina');
-- 8) Promedio de nota para inscripciones con estado = "regular".
SELECT AVG(nota) AS promedioNota_Inscripciones
FROM inscripciones
WHERE estado='regular';
-- 9) Cantidad de ciudades distintas presentes en la tabla alumnos.
SELECT COUNT(DISTINCT ciudad) AS Ciudades_Distintas
FROM alumnos;
-- 10) Cantidad de areas distintas presentes en la tabla materias.
SELECT COUNT(DISTINCT area) AS cantidad_Areas
FROM materias;
-- =====================================================
-- GROUP BY (10) — una sola tabla por consulta
-- =====================================================
-- 1) Alumnos por ciudad (mostrar ciudad y cantidad).
SELECT ciudad, COUNT(*) AS Contador_Ciudad
FROM alumnos
GROUP BY ciudad;
-- 2) Alumnos por apellido (mostrar apellido y cantidad).
SELECT apellido, COUNT(*) AS Contador_Apellidos
FROM alumnos
GROUP BY apellido;
-- 3) Alumnos por pais (mostrar pais y cantidad).
SELECT pais, COUNT(*) AS Contador_Pais
FROM alumnos
GROUP BY pais;
-- 4) Materias por area (mostrar area y cantidad).
SELECT area, COUNT(*) AS Contador_Area
FROM materias 
GROUP BY area;
-- 5) Materias por cuatrimestre (mostrar cuatrimestre y cantidad).
SELECT cuatrimestre, COUNT(*) AS Contador_Cuatrimestre
FROM materias
GROUP BY cuatrimestre;
-- 6) En inscripciones: por estado, mostrar el PROMEDIO de nota (excluir NULL) y la CANTIDAD de inscripciones con nota cargada.
SELECT 
estado, 
AVG(nota) AS Estado_Promedio,
COUNT(nota) AS Cantidad_Con_Nota
FROM inscripciones
WHERE nota IS NOT NULL
GROUP BY estado;
-- 7) En inscripciones: por id_materia, mostrar PROMEDIO, NOTA_MINIMA y NOTA_MAXIMA (excluir NULL en los calculos).
SELECT 
id_materia,
AVG(nota) AS Promedio,
MAX(nota) AS NotaMax,
MIN(nota) AS NotaMin
FROM inscripciones 
WHERE nota IS NOT NULL
GROUP BY id_materia;
-- 8) En inscripciones: por id_alumno, mostrar NOTA_MINIMA, NOTA_MAXIMA y PROMEDIO (excluir NULL en los calculos).
SELECT 
id_alumno,
MIN(nota) AS NotaMinima,
MAX(nota) AS NotaMax,
AVG(nota) AS Promedio
FROM inscripciones
WHERE nota IS NOT NULL
GROUP BY id_alumno;

-- 9) En inscripciones: por estado, mostrar PROMEDIO de nota (excluir NULL) y ordenar el resultado por ese promedio de mayor a menor.
SELECT 
estado,
AVG(nota) AS Promedio
FROM inscripciones
WHERE nota IS NOT NULL
GROUP BY estado
ORDER BY Promedio DESC;
-- =====================================================
-- HAVING (10) — filtros sobre agregados
-- =====================================================
-- 1) Ciudades con al menos 2 alumnos.
SELECT ciudad, COUNT(*) AS contador_CiudAlumn
FROM alumnos
GROUP BY ciudad
HAVING  COUNT(*) >= 2;
-- 2) Apellidos que aparezcan mas de 1 vez entre los alumnos.
SELECT apellido, COUNT(*) AS ContApellidosRep
FROM alumnos
GROUP BY apellido
HAVING COUNT(*)>1;
-- 3) Paises con 5 o mas alumnos.
SELECT pais, COUNT(*) AS ContPaisesAlumnos
FROM alumnos
GROUP BY pais
HAVING COUNT(*)>=5;
-- 4) Areas con 2 o mas materias.
SELECT area, COUNT(*) AS Cont_MateriaArea
FROM materias
GROUP BY area
HAVING COUNT(*)>=2;
-- 5) Cuatrimestres con mas de 3 materias.
SELECT cuatrimestre, COUNT(*) AS Cont_CuatriMateria
FROM materias
GROUP BY cuatrimestre
HAVING COUNT(*)>3;
-- 6) Estados con al menos 3 inscripciones.
SELECT estado,COUNT(*) AS Estados
FROM inscripciones
GROUP BY estado
HAVING COUNT(*)>=3;
-- 7) id_alumno con 2 o mas inscripciones.
SELECT id_alumno ,COUNT(*) AS Alumno_Inscripciones
FROM inscripciones
GROUP BY id_alumno
HAVING COUNT(*)>=2;
-- 8) id_materia cuyo promedio de nota sea >= 7.0 (excluir NULL).
SELECT 
id_materia,
AVG(nota) AS PromedioNota 
FROM inscripciones
WHERE nota IS NOT NULL
GROUP BY id_materia
HAVING PromedioNota >=7.0;
-- 9) Estados cuyo promedio de nota sea > 7.0 (excluir NULL).
SELECT 
estado,
AVG(nota) AS PromedioNota
FROM inscripciones
WHERE nota IS NOT NULL
GROUP BY estado
HAVING PromedioNota >7.0;
-- 10) Ciudades con al menos 2 alumnos y ordenar el resultado por la cantidad (desc).
SELECT 
ciudad ,COUNT(*) AS Ciudad_Alumno
FROM alumnos
GROUP BY ciudad
HAVING COUNT(*)>=2
ORDER BY Ciudad_Alumno DESC;


