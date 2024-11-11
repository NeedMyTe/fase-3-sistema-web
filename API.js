const express = require('express');
const mysql = require('mysql2');
const app = express();

// Configurar el middleware para parsear el JSON
app.use(express.json());

// Conexión a la base de datos
const connection = mysql.createConnection({
  host: '3000',
  user: 'root',
  password: 'admin',
  database: 'base'
});

// Ruta para obtener los módulos, severidades y clientes
app.get('/api/datos', (req, res) => {
  const modulosQuery = 'SELECT * FROM modulos WHERE activo = 1';
  const severidadesQuery = 'SELECT * FROM severidades';
  const clientesQuery = 'SELECT * FROM clientes';

  connection.query(modulosQuery, (err, modulos) => {
    if (err) return res.status(500).json({ error: 'Error al obtener los módulos' });

    connection.query(severidadesQuery, (err, severidades) => {
      if (err) return res.status(500).json({ error: 'Error al obtener las severidades' });

      connection.query(clientesQuery, (err, clientes) => {
        if (err) return res.status(500).json({ error: 'Error al obtener los clientes' });

        // Enviamos los datos como respuesta
        res.json({ modulos, severidades, clientes });
      });
    });
  });
});

// Levantar el servidor
const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});