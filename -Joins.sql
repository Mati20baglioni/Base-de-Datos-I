CREATE DATABASE Facultad;
USE Facultad;

CREATE TABLE alumnos ( 
	id_alumno INT AUTO_INCREMENT PRIMARY KEY, 
	nombre    VARCHAR(50) NOT NULL, 
	apellido  VARCHAR(50) NOT NULL, 
	dni  VARCHAR(12), 
	ciudad    VARCHAR(60), 
	pais    VARCHAR(40) DEFAULT 'Argentina' 
); 

CREATE TABLE materias ( 
	id_materia INT AUTO_INCREMENT PRIMARY KEY, 
	nombre VARCHAR(100) NOT NULL, 
	cuatrimestre TINYINT, 
	area VARCHAR(50) 
); 

CREATE TABLE inscripciones ( 
	id_inscripcion INT AUTO_INCREMENT PRIMARY KEY, 
	id_alumno  INT NOT NULL, 
	id_materia INT NOT NULL, 
    nota DECIMAL(4,1) NULL, 
	estado ENUM('regular','libre','promocion','cursando') NOT NULL DEFAULT 'cursando', 
	FOREIGN KEY (id_alumno)  REFERENCES alumnos(id_alumno), 
	FOREIGN KEY (id_materia) REFERENCES materias(id_materia) 
);
 
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
  
INSERT INTO inscripciones (id_alumno, id_materia, estado, nota) VALUES 
(21, 1, 'promocion', 9.5),   
(20, 1, 'promocion', 8.5),   
(1,  1, 'regular',   7.0), 
(2,  1, 'regular',   6.0), 
(3,  1, 'cursando',  NULL), 
(4,  3, 'cursando',  NULL), 
(5,  3, 'regular',   6.5), 
(6,  8, 'regular',   7.5),  
(7,  8, 'cursando',  NULL), 
(8,  8, 'cursando',  NULL), 
 
(9, 11, 'regular',   8.0),   
(10,11, 'regular',   7.0), 
(11,11, 'cursando',  NULL), 
 
(12, 2, 'cursando',  NULL),  
(13, 7, 'regular',   7.0),   
(14,10, 'regular',   6.0),   
(15,14, 'cursando',  NULL),  
(16,15, 'cursando',  NULL),  
(17,16, 'cursando',  NULL),  
(18, 9, 'regular',   8.0),    
(19, 6, 'regular',   7.0),   
(22, 6, 'regular',   6.0), 
(23, 8, 'regular',   8.5),   
(24,13, 'cursando',  NULL), 
(25, 1, 'regular',   6.5), 
(26, 1, 'cursando',  NULL); 

-- 1) Listado de inscripciones Mostrar nombre y apellido del alumno, nombre de la materia y estado de cada inscripción.
SELECT 
alumnos.nombre,alumnos.apellido,materias.nombre,inscripciones.estado
FROM inscripciones
INNER JOIN alumnos ON inscripciones.id_alumno =alumnos.id_alumno
INNER JOIN materias ON inscripciones.id_materia =materias.id_materia;

-- 2) Promocionados Listar alumnos que estén en estado = 'promocion', mostrando materia y nota, ordenados por nota descendente.
SELECT 
alumnos.nombre,
alumnos.apellido,
materias.nombre AS nombre_materia,
inscripciones.nota
FROM inscripciones
INNER JOIN alumnos ON inscripciones.id_alumno = alumnos.id_alumno
INNER JOIN materias ON inscripciones.id_materia = materias.id_materia
WHERE inscripciones.estado = 'promocion'
ORDER BY inscripciones.nota DESC;
-- 3) Cursando en 2° cuatrimestre Mostrar los alumnos que estén cursando materias del 2° cuatrimestre. Incluir alumno, materia, cuatrimestre y estado.
SELECT 
  alumnos.nombre,
  alumnos.apellido,
  materias.nombre AS nombre_materia,
  materias.cuatrimestre,
  inscripciones.estado
FROM inscripciones
INNER JOIN alumnos ON inscripciones.id_alumno = alumnos.id_alumno
INNER JOIN materias ON inscripciones.id_materia = materias.id_materia
WHERE materias.cuatrimestre = 2;
-- 4) Área específica Listar alumno, materia y estado de inscripciones donde el área de la materia sea 'Bases de Datos'.
SELECT 
alumnos.nombre,
alumnos.apellido,
materias.nombre,
materias.area,
inscripciones.estado
FROM inscripciones
INNER JOIN materias ON inscripciones.id_materia=materias.id_materia
INNER JOIN alumnos ON inscripciones.id_alumno=alumnos.id_alumno
WHERE materias.area='Bases de Datos';
-- 5) Materias sin inscriptos Mostrar id_materia y nombre de las materias que no tienen inscripciones.
SELECT 
materias.id_materia,
materias.nombre
FROM materias
LEFT JOIN inscripciones ON materias.id_materia = inscripciones.id_materia
WHERE inscripciones.id_inscripcion IS NULL;

-- 6) Cantidad de inscriptos por materia Mostrar id_materia, nombre y cantidad de inscriptos por materia (si no tiene, mostrar 0). Ordenar por cantidad descendente.
SELECT 
  materias.id_materia,
  materias.nombre,
  COUNT(inscripciones.id_inscripcion) AS cantidad_inscriptos
FROM materias
LEFT JOIN inscripciones ON materias.id_materia = inscripciones.id_materia
GROUP BY materias.id_materia, materias.nombre
ORDER BY cantidad_inscriptos DESC;
-- 7) Alumnos sin inscripciones Listar id_alumno, nombre y apellido de los alumnos que no estén inscriptos en ninguna materia.
SELECT 
  alumnos.id_alumno,
  alumnos.nombre,
  alumnos.apellido
FROM alumnos
LEFT JOIN inscripciones ON alumnos.id_alumno = inscripciones.id_alumno
WHERE inscripciones.id_inscripcion IS NULL;
-- 8) Promedio de notas por materia Mostrar id_materia, nombre de la materia y el promedio de nota (considerar solo inscripciones con nota). Incluir materias sin notas (mostrar NULL en promedio).
SELECT 
  materias.id_materia,
  materias.nombre,
  AVG(inscripciones.nota) AS promedio_nota
FROM materias
LEFT JOIN inscripciones ON materias.id_materia = inscripciones.id_materia
GROUP BY materias.id_materia, materias.nombre;
-- 9) Notas en rango Listar alumno, materia y nota de inscripciones con nota entre 7.0 y 9.0, ordenado por apellido, nombre y luego nota desc.
SELECT 
  alumnos.nombre,
  alumnos.apellido,
  materias.nombre AS nombre_materia,
  inscripciones.nota
FROM inscripciones
INNER JOIN alumnos ON inscripciones.id_alumno = alumnos.id_alumno
INNER JOIN materias ON inscripciones.id_materia = materias.id_materia
WHERE inscripciones.nota BETWEEN 7.0 AND 9.0
ORDER BY alumnos.apellido ASC, alumnos.nombre ASC, inscripciones.nota DESC;
-- 10) Desempeño por área Para cada área de materias, mostrar la cantidad de inscripciones y el promedio de notas (ignorar inscripciones sin nota).
SELECT 
  materias.area,
  COUNT(inscripciones.id_inscripcion) AS cantidad_inscripciones,
  AVG(inscripciones.nota) AS promedio_nota
FROM inscripciones
INNER JOIN materias ON inscripciones.id_materia = materias.id_materia
WHERE inscripciones.nota IS NOT NULL
GROUP BY materias.area;
