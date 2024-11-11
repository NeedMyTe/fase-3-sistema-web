const express= require("express");
const mysql = require('mysql2/promise');
const APP=express();
const port=3000;
const Axios=require('axios');
APP.use(express.json());
let conexion;
async function conectarBD() {
  try {
    conexion = await mysql.createConnection({
      host: 'localhost',
      user: 'root', // Tu usuario
      password: 'admin', // Tu contraseña
      database: 'first' // El nombre de tu base de datos
    });
    console.log('Conexión a la base de datos establecida');
  } catch (error) {
    console.error('Error al conectar con la base de datos:', error);
    process.exit(1); // Detenemos el servidor si no se puede conectar
  }
}

conectarBD();
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
    const con= await conexion
    // Obtener el nivel de servicio para el módulo y cliente desde la tabla `niveles_servicio`
    const [result] = await con.execute(`
      SELECT n.nivel_servicio 
      FROM niveles_servicio AS n
      WHERE n.modulo = ? AND n.pais = ?;`, [modulo, cliente]);

    console.log("Módulo:", modulo);
    console.log("Cliente:", cliente);
    console.log(result);

    if (!result || !Array.isArray(result) || result.length === 0) {
      throw new Error("No se encontró el nivel de servicio para el módulo y cliente proporcionado");
    }

    const nivel_servicio = result[0].nivel_servicio; // Obtener el nivel de servicio de la consulta
    console.log("Nivel de servicio encontrado:", nivel_servicio);
    console.log("Severidad recibida:", severidad);

    // Realizar la consulta a la tabla tiempos_entrega
    const resultTiempos = await con.execute(`
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
    const horas_diferencia=-3;
    fecha_actual.setHours(fecha_actual.getHours()+ horas_diferencia);
    const fecha_entrega = new Date(fecha_actual.getTime() + horas_entrega * 60 * 60 * 1000);
    const fecha_entrega_mysql = fecha_entrega.toISOString().slice(0, 19).replace('T', ' ');
    return fecha_entrega_mysql;
  } catch (error) {
    console.error(error);
    throw new Error(`Error al calcular la fecha de entrega: ${error.message}`);
  }
}
async function obtenerDatosDesdeAPI() {
  try {
    const response = await axios.get('https://miapi.com/datos'); // URL de la API externa
    return response.data; // Devolver los datos obtenidos
  } catch (error) {
    console.error('Error al obtener datos desde la API externa:', error);
    throw new Error('No se pudieron obtener los datos de la API externa');
  }
}
APP.post('/CreateTickets', async (req, res) => {
  try {
    const datosAPI= await obtenerDatosDesdeAPI();
    const { modulo, severidad, cliente, descripcion_breve, descripcion_detallada } = datosAPI;
    const fecha_inicio = obtener_fecha();
    const fecha_entrega = await calcularFechaEntrega(modulo, severidad, cliente);
  
    const sql = `
      INSERT INTO tickets (modulo, severidad, cliente, estado, fecha_inicio, fecha_entrega, descripcion_breve, descripcion_detallada)
      VALUES (?, ?, ?, 'trabajando en una solucion', ?, ?, ?, ?)`;
      const [result]= await conexion.execute(sql,[modulo, severidad, cliente, fecha_inicio, fecha_entrega, descripcion_breve, descripcion_detallada]);
      res.status(201).json({ ticket_id: result.insertId });

  } catch (error) {
    console.error('Error en la creación del ticket:', error);
    res.status(500).json({ error: 'Error interno en el servidor' });
  }
});
  

APP.listen(port, () => {
    console.log(`Servidor escuchando en http://localhost:${port}`);
});
