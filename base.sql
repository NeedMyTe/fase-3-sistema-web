CREATE TABLE modulos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    activo BOOLEAN DEFAULT 1
);

CREATE TABLE severidades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
);

CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
);

CREATE TABLE tickets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    modulo_id INT,
    severidad_id INT,
    cliente_id INT,
    descripcion_breve TEXT,
    descripcion_detallada TEXT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (modulo_id) REFERENCES modulos(id),
    FOREIGN KEY (severidad_id) REFERENCES severidades(id),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);
INSERT INTO modulos (nombre) VALUES
('Atencion Clientes'),
('Beneficios y promociones'),
('Cobranza'),
('Comisiones'),
('Correspondencia'),
('Evaluacion de riesgo'),
('Facturacion'),
('Ficha Retenciones'),
('Gestion de documentos'),
('Logistica'),
('Postventas'),
('Recaudacion y cajas'),
('Reclamos'),
('Reportes'),
('Servicion tecnico'),
('Ventas');

INSERT INTO severidades (nombre) VALUES
('Critica'),
('Alta'),
('Normal'),
('Baja');

INSERT INTO clientes (nombre) VALUES
('Chile'),
('Colombia'),
('Costa Rica'),
('Ecuador'),
('Guatemala'),
('Mexico'),
('Nicaragua'),
('Panama');
