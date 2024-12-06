const express = require('express');
const oracledb = require('oracledb');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true })); 

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
app.get('/', (req, res) => {
  res.send('Hello World!');
});

app.post('/login', async (req, res) => {
  const { email, password } = req.body;
  try {
    const connection = await oracledb.getConnection(dbConfig);
    const query = 'SELECT * FROM FIDE_USUARIO_TB WHERE correo = :email AND contrasena = :password';
    const result = await connection.execute(query, [email, password], { outFormat: oracledb.OBJECT });

    await connection.close();

    if (result.rows.length > 0) {
      res.status(200).send(result.rows);
    } else {
      res.status(401).send('Contraseña o correo electrónico incorrecto');
    }
  } catch (err) {
    console.error(err);
    res.status(500).send('Server error');
  }
});

app.get('/getAllEstudiantes', async (req, res) => {
  try {
    const students = await executeQuery('SELECT NOMBRE, PRIMER_APELLIDO, SEGUNDO_APELLIDO, CORREO FROM FIDE_USUARIO_TB WHERE ID_ESTADO = 1');
    res.json(students);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.get('/getAllAreaEspecializacion', async (req, res) => {
  try {
    const result = await executeQuery('SELECT AREA_ESPECIALIZACION FROM FIDE_ESPECIALIZACION_DOCENTE_TB WHERE ID_ESTADO = 1');
    res.json(result.map((area) => area[0]));
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.get('/getAllPaises', async (req, res) => {
  try {
    const result = await executeQuery('SELECT ID_PAIS, PAIS FROM FIDE_PAIS_TB');
    res.json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.get('/getAllProvincias', async (req, res) => {
  try {
    const result = await executeQuery('SELECT ID_PROVINCIA, PROVINCIA FROM FIDE_PROVINCIA_TB');
    res.json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.get('/getAllCantones', async (req, res) => {
  try {
    const result = await executeQuery('SELECT ID_CANTON, CANTON FROM FIDE_CANTON_TB');
    res.json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.get('/getAllDistritos', async (req, res) => {
  try {
    const result = await executeQuery('SELECT ID_DISTRITO, DISTRITO FROM FIDE_DISTRITO_TB');
    res.json(result);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.post('/agregarUsuario', async (req, res) => {
  const { nombre, primerApellido, segundoApellido, correo, tipoUsuario, codigoPais, telefono, idDireccion, idEspecializacion, contrasena } = req.body;

  try {
    const connection = await oracledb.getConnection(dbConfig);
    const query = `
      INSERT INTO FIDE_USUARIO_TB (
        NOMBRE, PRIMER_APELLIDO, SEGUNDO_APELLIDO, CORREO, TIPO_USUARIO, CODIGO_PAIS, TELEFONO, ID_DIRECCION, ID_ESPECIALIZACION, CONTRASENA
      ) VALUES (:nombre, :primerApellido, :segundoApellido, :correo, :tipoUsuario, :codigoPais, :telefono, :idDireccion, :idEspecializacion, :contrasena)`;
    const binds = {
      nombre,
      primerApellido,
      segundoApellido,
      correo,
      tipoUsuario,
      codigoPais,
      telefono,
      idDireccion,
      idEspecializacion,
      contrasena
    };

    await connection.execute(query, binds, { autoCommit: true });
    await connection.close();

    res.status(201).send('Usuario creado exitosamente');
  } catch (err) {
    console.error(err);
    res.status(500).send('Error del servidor');
  }
});


// Inicio del servidor
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
