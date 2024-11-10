const mysql = require('mysql2');

// Configura la conexión con la base de datos
const conexion = mysql.createConnection({
  host: 'localhost',
  user: 'root', // Tu usuario
  password: 'admin', // Tu contraseña
  database: 'first' // El nombre de tu base de datos
});

// Verifica que la conexión sea exitosa
conexion.connect((err) => {
  if (err) {
    console.error('Error al conectar a la base de datos:', err);
    return;
  }
  console.log('Conexión exitosa a la base de datos');
});
