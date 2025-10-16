
CREATE DATABASE guia_fechas;
USE guia_fechas;

-- =====================
-- TABLAS
-- =====================

CREATE TABLE clientes (
  id_cliente INT AUTO_INCREMENT PRIMARY KEY,
  nombre      VARCHAR(80) NOT NULL,
  email       VARCHAR(120) NOT NULL UNIQUE,
  ciudad      VARCHAR(60),
  pais        VARCHAR(60) DEFAULT 'Argentina',
  fecha_alta  DATE NOT NULL DEFAULT (CURDATE())       
);

CREATE TABLE productos (
  id_producto INT AUTO_INCREMENT PRIMARY KEY,
  nombre       VARCHAR(100) NOT NULL,
  categoria    VARCHAR(50)  NOT NULL,
  precio       DECIMAL(10,2) NOT NULL,
  activo       TINYINT(1) NOT NULL DEFAULT 1
);

CREATE TABLE pedidos (
  id_pedido   INT AUTO_INCREMENT PRIMARY KEY,
  id_cliente  INT NOT NULL,
  estado      ENUM('creado','pagado','enviado','entregado','cancelado') NOT NULL DEFAULT 'creado',
  creado_en   DATETIME NOT NULL,               
  pagado_en   DATETIME NULL,                  
  enviado_en  DATETIME NULL,                  
  entregado_en DATE NULL,                      
  FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE items_pedido (
  id_item     INT AUTO_INCREMENT PRIMARY KEY,
  id_pedido   INT NOT NULL,
  id_producto INT NOT NULL,
  cantidad    INT NOT NULL,
  precio_unit DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
  FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

CREATE TABLE pagos (
  id_pago     INT AUTO_INCREMENT PRIMARY KEY,
  id_pedido   INT NOT NULL,
  metodo      ENUM('tarjeta','transferencia','efectivo','wallet') NOT NULL,
  importe     DECIMAL(10,2) NOT NULL,
  creado_en   DATETIME NOT NULL,               
  acreditado_en DATETIME NULL,                
  FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
);

-- =====================
-- DATOS DE PRUEBA
-- =====================
INSERT INTO clientes (nombre, email, ciudad, pais, fecha_alta) VALUES
('Ana Pérez',     'ana.perez@example.com',     'Mar del Plata', 'Argentina', '2024-12-20'),
('Bruno Díaz',    'bruno.diaz@example.com',    'Córdoba',       'Argentina', '2025-01-03'),
('Carla Gómez',   'carla.gomez@example.com',   'Rosario',       'Argentina', '2025-02-14'),
('Diego Torres',  'diego.torres@example.com',  'La Plata',      'Argentina', '2025-03-01'),
('Elena Ruiz',    'elena.ruiz@example.com',    'Mendoza',       'Argentina', '2025-05-10');

INSERT INTO productos (nombre, categoria, precio, activo) VALUES
('Notebook 14"',          'Tecnología', 850000.00, 1),
('Mouse Inalámbrico',     'Tecnología',  18000.00, 1),
('Silla Ergonómica',      'Hogar',      220000.00, 1),
('Auriculares Bluetooth', 'Tecnología',  45000.00, 1),
('Escritorio Gamer',      'Hogar',      300000.00, 1);

-- Pedidos en distintos momentos del 2025 (y alguno 2024 para variedad)
INSERT INTO pedidos (id_cliente, estado, creado_en, pagado_en, enviado_en, entregado_en) VALUES
(1, 'entregado', '2024-12-30 11:15:00', '2024-12-30 11:20:00', '2024-12-31 09:00:00', '2025-01-02'),
(2, 'enviado',   '2025-01-12 10:05:00', '2025-01-12 10:07:00', '2025-01-13 16:30:00', NULL),
(3, 'creado',    '2025-03-05 08:50:00', NULL, NULL, NULL),
(4, 'entregado', '2025-06-20 15:12:00', '2025-06-20 15:13:00', '2025-06-21 10:00:00', '2025-06-24'),
(5, 'enviado',   '2025-09-05 19:40:00', '2025-09-05 19:45:00', '2025-09-06 09:20:00', NULL),
(2, 'creado',    CONCAT(CURDATE(), ' 09:00:00'), NULL, NULL, NULL);

INSERT INTO items_pedido (id_pedido, id_producto, cantidad, precio_unit) VALUES
(1, 1, 1, 850000.00),
(1, 2, 1,  18000.00),
(2, 4, 1,  45000.00),
(3, 3, 1, 220000.00),
(4, 5, 1, 300000.00),
(4, 2, 2,  18000.00),
(5, 1, 1, 850000.00),
(6, 2, 1,  18000.00),
(6, 4, 1,  45000.00);

INSERT INTO pagos (id_pedido, metodo, importe, creado_en, acreditado_en) VALUES
(1, 'tarjeta',       868000.00, '2024-12-30 11:20:30', '2024-12-30 12:00:00'),
(2, 'wallet',         45000.00, '2025-01-12 10:07:30', '2025-01-12 10:15:00'),
(4, 'transferencia', 336000.00, '2025-06-20 15:13:30', '2025-06-20 16:10:00'),
(5, 'tarjeta',       850000.00, '2025-09-05 19:45:30', '2025-09-05 20:05:00');

-- =====================================================
-- 📘 Guía de Ejercicios – Funciones de Manejo de Fechas
-- Contexto: E-Commerce
-- =====================================================

-- 1) Mostrar la fecha y hora actual del sistema (usar NOW, CURDATE y CURTIME en una misma consulta).
SELECT NOW()   AS ahora_completo,
       CURDATE() AS fecha_hoy,
       CURTIME() AS hora_actual;
-- 2) Listar id_pedido y creado_en de los pedidos creados este año.
SELECT id_pedido, creado_en
FROM pedidos
WHERE YEAR(creado_en) = YEAR(CURDATE());
-- 3) Listar id_pedido y creado_en de los pedidos creados en los últimos 30 días.
SELECT id_pedido, creado_en
FROM pedidos
WHERE creado_en >= DATE_SUB(NOW(), INTERVAL 30 DAY);
-- 4) Para pedidos entregados:Mostrar id_pedido, creado_en, entregado_en y calcular cuántos días pasaron entre creación y entrega (DATEDIFF).
SELECT id_pedido,
       creado_en,
       entregado_en,
       DATEDIFF(entregado_en, DATE(creado_en)) AS dias_entre_creacion_entrega
FROM pedidos
WHERE entregado_en IS NOT NULL;
-- 5) Para pedidos con pago y envío: Calcular el tiempo en minutos entre pagado_en y enviado_en (usar TIMESTAMPDIFF con unidad MINUTE).
SELECT id_pedido,
       pagado_en,
       enviado_en,
       TIMESTAMPDIFF(MINUTE, pagado_en, enviado_en) AS minutos_pago_a_envio
FROM pedidos
WHERE pagado_en IS NOT NULL AND enviado_en IS NOT NULL;
-- 6) Listar id_pedido y creado_en formateado como dd/mm/aaaa hh:mm (usar DATE_FORMAT).
SELECT id_pedido,
       DATE_FORMAT(creado_en, '%d/%m/%Y %H:%i') AS creado_formateado
FROM pedidos;
-- 7) Mostrar cantidad de pedidos por año y mes (usar YEAR(creado_en) y MONTH(creado_en)).
SELECT YEAR(creado_en) AS anio,
       MONTH(creado_en) AS mes,
       COUNT(*) AS total_pedidos
FROM pedidos
GROUP BY YEAR(creado_en), MONTH(creado_en)
ORDER BY YEAR(creado_en), MONTH(creado_en);
-- 8) Para cada pedido, mostrar id_pedido, creado_en y el último día del mes de creado_en (usar LAST_DAY).
SELECT id_pedido,
       creado_en,
       LAST_DAY(creado_en) AS ultimo_dia_del_mes
FROM pedidos;
-- 9) Listar clientes dados de alta en el trimestre actual  Mostrar id_cliente, nombre y fecha_alta.
SELECT id_cliente, nombre, fecha_alta
FROM clientes
WHERE YEAR(fecha_alta) = YEAR(CURDATE())
  AND QUARTER(fecha_alta) = QUARTER(CURDATE());
-- 10) Simular que recibimos un texto '19/09/2025 14:35'. Convertirlo a DATETIME con STR_TO_DATE y compararlo con NOW() devolviendo "Pasado" o "Futuro" en una columna calculada.
SELECT STR_TO_DATE('19/09/2025 14:35', '%d/%m/%Y %H:%i') AS fecha_convertida,
       CASE 
         WHEN STR_TO_DATE('19/09/2025 14:35', '%d/%m/%Y %H:%i') < NOW() THEN 'Pasado'
         WHEN STR_TO_DATE('19/09/2025 14:35', '%d/%m/%Y %H:%i') > NOW() THEN 'Futuro'
         ELSE 'Ahora'
       END AS comparacion_con_now;
