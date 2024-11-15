const express= require("express");
const mysql = require('mysql2');
const APP=express();
const port=3000;
APP.use(express.json());
const conexion = mysql.createConnection({
    host: 'localhost',
    user: 'root', // Tu usuario
    password: 'admin', // Tu contraseña
    database: 'first' // El nombre de tu base de datos
  });
class Ticket {
    constructor(modulo,severidad,cliente,estado,fecha_inicio,fecha_entrega,descripcion_breve,descripcion_detallada) {
        this.modulo=modulo;
        this.severidad=severidad;
        this.cliente= cliente;
        this.estado="trabajando en una solucion";
        this.fecha_inicio=fecha_inicio;
        this.fecha_entrega=fecha_entrega;
        this.descripcion_breve=descripcion_breve;
        this.descripcion_detallada=descripcion_detallada;
    }
}
function obtener_fecha(){
  
  const fecha =new Date();
  const año= fecha.getFullYear();
  const mes= String(fecha.getMonth()+1).padStart(2,'0');
  const dia= String(fecha.getDate()).padStart(2,'0');
  const hora =String(fecha.getHours()).padStart(2,'0');
  const minutos= String(fecha.getMinutes()).padStart(2,'0');
  const segundos= String(fecha.getSeconds()).padStart(2,'0');
  return `${año}-${mes}-${dia} ${hora}:${minutos}:${segundos}`
}

async function calcularFechaEntrega(modulo, severidad, cliente) {
  try {
    const fecha_actual = new Date();

    // Obtener el nivel de servicio para el módulo y cliente desde la tabla `niveles_servicio`
    const result = await conexion.execute(`
      SELECT n.nivel_servicio 
      FROM niveles_servicio AS n
      WHERE n.modulo = ? AND n.pais = ?`, [modulo, cliente]);

    console.log("Módulo:", modulo);
    console.log("Cliente:", cliente);
    console.log(result);

    if (!result || !Array.isArray(result) || result.length === 0) {
      throw new Error("No se encontró el nivel de servicio para el módulo y cliente proporcionado");
    }

    const nivel_servicio = result[0][0].nivel_servicio; // Obtener el nivel de servicio de la consulta
    console.log("Nivel de servicio encontrado:", nivel_servicio);
    console.log("Severidad recibida:", severidad);

    // Realizar la consulta a la tabla tiempos_entrega
    const resultTiempos = await conexion.execute(`
      SELECT tiempo_entrega 
      FROM tiempos_entrega
      WHERE nivel_servicio = ? AND severidad = ?`, [nivel_servicio, severidad]);

    console.log(resultTiempos);

    if (!resultTiempos || !Array.isArray(resultTiempos) || resultTiempos.length === 0) {
      throw new Error("No se encontró el tiempo de entrega para el nivel de servicio y severidad proporcionados");
    }

    const horas_entrega = resultTiempos[0][0].tiempo_entrega; // Extraer el tiempo de entrega
    console.log("Horas de entrega:", horas_entrega);

    // Calcular la fecha de entrega
    const fecha_entrega = new Date(fecha_actual.getTime() + horas_entrega * 60 * 60 * 1000);
    return fecha_entrega.toLocaleString("es-ES", { timeZone: "UTC" });

  } catch (error) {
    console.error(error);
    throw new Error(`Error al calcular la fecha de entrega: ${error.message}`);
  }
}
APP.post('/CreateTickets', async (req, res) => {
  try {
    const { modulo, severidad, cliente, descripcion_breve, descripcion_detallada } = req.body;
    const fecha_inicio = obtener_fecha();
    const fecha_entrega = await calcularFechaEntrega(modulo, severidad, cliente);
  
    const sql = `
      INSERT INTO tickets (modulo, severidad, cliente, estado, fecha_inicio, fecha_entrega, descripcion_breve, descripcion_detallada)
      VALUES (?, ?, ?, 'trabajando en una solucion', ?, ?, ?, ?)`;
  
    conexion.query(sql, [modulo, severidad, cliente, fecha_inicio, fecha_entrega, descripcion_breve, descripcion_detallada], (err, result) => {
      if (err) {
        console.error('Error al insertar el ticket:', err);
        return res.status(500).json({ error: 'Error al guardar el ticket' });
      }
      res.status(201).json({ ticket_id: result.insertId });
    });
  } catch (error) {
    console.error('Error en la creación del ticket:', error);
    res.status(500).json({ error: 'Error interno en el servidor' });
  }
});
  

APP.listen(port, () => {
    console.log(`Servidor escuchando en http://localhost:${port}`);
});