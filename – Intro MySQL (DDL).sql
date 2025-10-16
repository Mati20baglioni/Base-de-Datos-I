-- Crear Base de Datos.

CREATE DATABASE ventas_practica;
USE ventas_practica;

-- Crear tablas

CREATE TABLE productos (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL
);

CREATE TABLE clientes(
	id INT PRIMARY KEY AUTO_INCREMENT,
    dni VARCHAR (15) UNIQUE,
    nombre VARCHAR (80) NOT NULL,
    apellido VARCHAR (80) NOT NULL
);

CREATE TABLE ventas(
	id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT NOT NULL,
    producto_id INT NOT NULL,
    fecha_venta DATE,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    FOREIGN KEY (producto_id) REFERENCES productos(id)

);

-- Modificación de estructura

-- Agregar la columna email en la tabla clientes (único).

ALTER TABLE clientes ADD email VARCHAR (25) UNIQUE;
DESCRIBE clientes; 

-- Cambiar el nombre de la columna apellido de clientes a apellido_cliente.

ALTER TABLE clientes 
RENAME COLUMN apellido TO apellido_cliente;
DESCRIBE clientes; 

-- Agregar una restricción CHECK en productos para que el precio sea mayor a 0.

ALTER TABLE productos
ADD CONSTRAINT precio CHECK (precio > 0); 
DESCRIBE productos;

-- Limpieza de datos.

-- Insertar al menos 2 clientes y 2 productos de prueba.
INSERT INTO clientes(dni,nombre,apellido_cliente)
VALUES
(42653790,'Matias','Baglioni'),
(41652732,'Camila','Baglioni');

INSERT INTO productos (nombre,precio,stock)
VALUES
('Arroz',1700,50),
('Fideos',1500,25);

SELECT * FROM clientes;
SELECT * FROM productos;

-- Vaciar la tabla ventas con TRUNCATE.

TRUNCATE TABLE ventas;
DESCRIBE ventas;

-- Eliminar la tabla ventas con DROP.

DROP TABLE ventas;
DESCRIBE ventas;

-- Cambiar el nombre de la tabla clientes a compradores.

ALTER TABLE clientes 
RENAME TO compradores;
DESCRIBE compradores;

