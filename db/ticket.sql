-- Active: 1730854107786@@127.0.0.1@3306@first
CREATE TABLE tickets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    modulo VARCHAR(255),
    severidad VARCHAR(50),
    cliente VARCHAR(255),
    estado VARCHAR(50) DEFAULT 'trabajando en solucion',
    fecha_inicio DATETIME,
    fecha_entrega DATETIME,
    descripcion_breve VARCHAR(100),
    descripcion_detallada VARCHAR(1000)
    nivel_servicio_id INT,
    tiempo_entrega_id INT,
    CONSTRAINT fk_nivel_servicio_ticket FOREIGN KEY (nivel_servicio_id) 
        REFERENCES niveles_servicio(id) 
        ON DELETE SET NULL,
    CONSTRAINT fk_tiempo_entrega_ticket FOREIGN KEY (tiempo_entrega_id) 
        REFERENCES tiempos_entrega(id) 
        ON DELETE SET NULL
);
DESCRIBE tickets;
INSERT INTO tickets (modulo, severidad, cliente, estado, fecha_inicio, fecha_entrega, descripcion_breve,descripcion_detallada)
VALUES ('Módulo de pago', 'Alta', 'Cliente X', 'trabajando en solucion', '2024-11-06', '2024-11-07', 'hola','hola como estan');
SELECT * FROM tickets;
DROP TABLE IF EXISTS tickets;
CREATE TABLE niveles_servicio (
    id INT AUTO_INCREMENT PRIMARY KEY,
    modulo VARCHAR(50),          -- Nombre del módulo (Ej: "Atención Clientes", "Facturación", etc.)
    pais VARCHAR(50),            -- País (Ej: "Chile", "Colombia", etc.)
    nivel_servicio VARCHAR(20)   -- Nivel de servicio (Ej: "Oro", "Plata", etc.)
);

INSERT INTO niveles_servicio (modulo, pais, nivel_servicio) VALUES
('Atención Clientes', 'Chile', 'Oro'),
('Atención Clientes', 'Colombia', 'Oro'),
('Atención Clientes', 'Costa Rica', 'Oro'),
('Atención Clientes', 'Ecuador', 'Oro'),
('Atención Clientes', 'Guatemala', 'Oro'),
('Atención Clientes', 'México', 'Oro'),
('Atención Clientes', 'Nicaragua', 'Oro'),
('Atención Clientes', 'Panamá', 'Oro'),
('Beneficios y Promociones', 'Chile', 'Oro'),
('Beneficios y Promociones', 'Colombia', 'Plata'),
('Beneficios y Promociones', 'Costa Rica', 'Plata'),
('Beneficios y Promociones', 'Ecuador', 'Plata'),
('Beneficios y Promociones', 'Guatemala', 'Plata'),
('Beneficios y Promociones', 'México', 'Plata'),
('Beneficios y Promociones', 'Nicaragua', 'Plata'),
('Beneficios y Promociones', 'Panamá', 'Plata'),
('Cobranza', 'Chile', 'Platino'),
('Cobranza', 'Colombia', 'Platino'),
('Cobranza', 'Costa Rica', 'Oro'),
('Cobranza', 'Ecuador', 'Oro'),
('Cobranza', 'Guatemala', 'Oro'),
('Cobranza', 'México', 'Platino'),
('Cobranza', 'Nicaragua', 'Oro'),
('Cobranza', 'Panamá', 'Oro'),
('Comisiones', 'Chile', 'Plata'),
('Comisiones', 'Colombia', 'Plata'),
('Comisiones', 'Costa Rica', 'Bronce'),
('Comisiones', 'Ecuador', 'Bronce'),
('Comisiones', 'Guatemala', 'Bronce'),
('Comisiones', 'México', 'Plata'),
('Comisiones', 'Nicaragua', 'Bronce'),
('Comisiones', 'Panamá', 'Bronce'),
('Correspondencia', 'Chile', 'Bronce'),
('Correspondencia', 'Colombia', 'Bronce'),
('Correspondencia', 'Costa Rica', 'Bronce'),
('Correspondencia', 'Ecuador', 'Bronce'),
('Correspondencia', 'Guatemala', 'Bronce'),
('Correspondencia', 'México', 'Bronce'),
('Correspondencia', 'Nicaragua', 'Bronce'),
('Correspondencia', 'Panamá', 'Bronce'),
('Evaluación de Riesgo', 'Chile', 'Plata'),
('Evaluación de Riesgo', 'Colombia', 'Plata'),
('Evaluación de Riesgo', 'Costa Rica', 'Plata'),
('Evaluación de Riesgo', 'Ecuador', 'Plata'),
('Evaluación de Riesgo', 'Guatemala', 'Plata'),
('Evaluación de Riesgo', 'México', 'Plata'),
('Evaluación de Riesgo', 'Nicaragua', 'Plata'),
('Evaluación de Riesgo', 'Panamá', 'Plata'),
('Facturación', 'Chile', 'Platino'),
('Facturación', 'Colombia', 'Platino'),
('Facturación', 'Costa Rica', 'Oro'),
('Facturación', 'Ecuador', 'Platino'),
('Facturación', 'Guatemala', 'Oro'),
('Facturación', 'México', 'Platino'),
('Facturación', 'Nicaragua', 'Platino'),
('Facturación', 'Panamá', 'Oro'),
('Ficha Retenciones', 'Chile', 'Plata'),
('Ficha Retenciones', 'Colombia', 'Oro'),
('Ficha Retenciones', 'Costa Rica', 'Plata'),
('Ficha Retenciones', 'Ecuador', 'Plata'),
('Ficha Retenciones', 'Guatemala', 'Plata'),
('Ficha Retenciones', 'México', 'Oro'),
('Ficha Retenciones', 'Nicaragua', 'Plata'),
('Ficha Retenciones', 'Panamá', 'Plata'),
('Gestión de Documentos', 'Chile', 'Bronce'),
('Gestión de Documentos', 'Colombia', 'Bronce'),
('Gestión de Documentos', 'Costa Rica', 'Bronce'),
('Gestión de Documentos', 'Ecuador', 'Bronce'),
('Gestión de Documentos', 'Guatemala', 'Bronce'),
('Gestión de Documentos', 'México', 'Bronce'),
('Gestión de Documentos', 'Nicaragua', 'Bronce'),
('Gestión de Documentos', 'Panamá', 'Bronce'),
('Logística', 'Chile', 'Oro'),
('Logística', 'Colombia', 'Platino'),
('Logística', 'Costa Rica', 'Plata'),
('Logística', 'Ecuador', 'Plata'),
('Logística', 'Guatemala', 'Plata'),
('Logística', 'México', 'Platino'),
('Logística', 'Nicaragua', 'Plata'),
('Logística', 'Panamá', 'Plata'),
('Postventas', 'Chile', 'Platino'),
('Postventas', 'Colombia', 'Platino'),
('Postventas', 'Costa Rica', 'Oro'),
('Postventas', 'Ecuador', 'Platino'),
('Postventas', 'Guatemala', 'Oro'),
('Postventas', 'México', 'Platino'),
('Postventas', 'Nicaragua', 'Platino'),
('Postventas', 'Panamá', 'Oro'),
('Recaudación y Cajas', 'Chile', 'Plata'),
('Recaudación y Cajas', 'Colombia', 'Plata'),
('Recaudación y Cajas', 'Costa Rica', 'Plata'),
('Recaudación y Cajas', 'Ecuador', 'Plata'),
('Recaudación y Cajas', 'Guatemala', 'Plata'),
('Recaudación y Cajas', 'México', 'Plata'),
('Recaudación y Cajas', 'Nicaragua', 'Plata'),
('Recaudación y Cajas', 'Panamá', 'Plata'),
('Reclamos', 'Chile', 'Oro'),
('Reclamos', 'Colombia', 'Oro'),
('Reclamos', 'Costa Rica', 'Plata'),
('Reclamos', 'Ecuador', 'Plata'),
('Reclamos', 'Guatemala', 'Oro'),
('Reclamos', 'México', 'Oro'),
('Reclamos', 'Nicaragua', 'Plata'),
('Reclamos', 'Panamá', 'Plata'),
('Reportes', 'Chile', 'Bronce'),
('Reportes', 'Colombia', 'Bronce'),
('Reportes', 'Costa Rica', 'Bronce'),
('Reportes', 'Ecuador', 'Bronce'),
('Reportes', 'Guatemala', 'Bronce'),
('Reportes', 'México', 'Bronce'),
('Reportes', 'Nicaragua', 'Bronce'),
('Reportes', 'Panamá', 'Bronce'),
('Servicio Técnico', 'Chile', 'Plata'),
('Servicio Técnico', 'Colombia', 'Oro'),
('Servicio Técnico', 'Costa Rica', 'Plata'),
('Servicio Técnico', 'Ecuador', 'Plata'),
('Servicio Técnico', 'Guatemala', 'Plata'),
('Servicio Técnico', 'México', 'Oro'),
('Servicio Técnico', 'Nicaragua', 'Plata'),
('Servicio Técnico', 'Panamá', 'Plata'),
('Ventas', 'Chile', 'Platino'),
('Ventas', 'Colombia', 'Platino'),
('Ventas', 'Costa Rica', 'Oro'),
('Ventas', 'Ecuador', 'Platino'),
('Ventas', 'Guatemala', 'Oro'),
('Ventas', 'México', 'Platino'),
('Ventas', 'Nicaragua', 'Oro'),
('Ventas', 'Panamá', 'Oro');
SELECT * FROM niveles_servicio;

SELECT n.nivel_servicio 
FROM niveles_servicio AS n
WHERE n.modulo = 'Atención Clientes' AND n.pais = 'Mexico';

SELECT * FROM niveles_servicio WHERE modulo = 'Atención Clientes' AND pais = 'México';


CREATE TABLE tiempos_entrega (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nivel_servicio VARCHAR(255) NOT NULL,
    severidad VARCHAR(255) NOT NULL,
    tiempo_entrega INT NOT NULL,  -- Tiempo en horas o días según el nivel de severidad
    descripcion VARCHAR(255)      -- Descripción opcional
     CONSTRAINT fk_nivel_servicio FOREIGN KEY (nivel_servicio) 
        REFERENCES niveles_servicio(nivel_servicio) 
        ON DELETE CASCADE
);
-- Insertar tiempos de entrega para cada combinación de nivel de servicio y severidad
INSERT INTO tiempos_entrega (nivel_servicio, severidad, tiempo_entrega, descripcion)
VALUES 
('Platino', 'Crítica', 6, '6 horas (24x7)'),
('Platino', 'Alta', 24, '1 día hábil'),
('Platino', 'Normal', 24, '1 día hábil'),
('Platino', 'Baja', 24, '1 día hábil'),
('Oro', 'Crítica', 10, '10 horas (24x7)'),
('Oro', 'Alta', 48, '2 días hábiles'),
('Oro', 'Normal', 48, '2 días hábiles'),
('Oro', 'Baja', 48, '2 días hábiles'),
('Plata', 'Crítica', 72, '3 días hábiles'),
('Plata', 'Alta', 96, '4 días hábiles'),
('Plata', 'Normal', 96, '4 días hábiles'),
('Plata', 'Baja', 96, '4 días hábiles'),
('Bronce', 'Crítica', 144, '6 días hábiles'),
('Bronce', 'Alta', 192, '8 días hábiles'),
('Bronce', 'Normal', 192, '8 días hábiles'),
('Bronce', 'Baja', 192, '8 días hábiles');
SELECT * FROM tiempos_entrega;
DROP TABLE tiempos_entrega;
SELECT nivel_servicio 
FROM niveles_servicio 
WHERE modulo = 'Atención Clientes' AND pais = 'México';
SELECT * FROM tiempos_entrega WHERE nivel_servicio = 'Oro' AND severidad = 'Alta';
