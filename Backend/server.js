const express = require('express');
const oracledb = require('oracledb');
const cors = require('cors')
const app = express();
const PORT = 5000;

// Configuración de conexión a Oracle
const dbConfig = {
  user: 'ProyectoFinal',
  password: '123',
  connectString: 'localhost/orcl',
};

// Función para ejecutar consultas
async function executeQuery(query, params = []) {
  let connection;
  try {
    connection = await oracledb.getConnection(dbConfig);
    const result = await connection.execute(query, params);
    return result.rows;
  } catch (error) {
    console.error('Database Error:', error);
    throw new Error('Error al ejecutar la consulta');
  } finally {
    if (connection) {
      try {
        await connection.close();
      } catch (closeError) {
        console.error('Error closing connection:', closeError);
      }
    }
  }
}

// Rutas
app.use(cors())

app.get('/', (req, res) => {
  res.send('Hello World!');
});

app.get('/getAllEstudiantes', async (req, res) => {
  try {
    const students = await executeQuery('SELECT NOMBRE, PRIMER_APELLIDO, SEGUNDO_APELLIDO, CORREO FROM FIDE_USUARIO_TB');
    res.json(students);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Inicio del servidor
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
