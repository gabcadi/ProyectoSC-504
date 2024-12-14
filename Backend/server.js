const express = require('express');
const oracledb = require('oracledb');
const bodyParser = require('body-parser');
const cors = require('cors');
const nodemailer = require('nodemailer');
require('dotenv').config(); // Cargar variables de entorno desde .env

const transporter = nodemailer.createTransport({
  service: 'outlook', // Puedes usar cualquier servicio de correo compatible
  auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_PASS
  }
});

// Función para enviar correo
const sendEmail = (to, subject, htmlContent) => {
  const mailOptions = {
    from: process.env.EMAIL_USER,
    to,
    subject,
    html: htmlContent
  };

  transporter.sendMail(mailOptions, (error, info) => {
    if (error) {
      console.error('Error al enviar el correo:', error);
    } else {
      console.log('Correo enviado:', info.response);
    }
  });
};

const app = express();
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true })); 

// Configuración de conexión a Oracle
const dbConfig = {
  user: 'FIDE_PROYECTO_FINAL_USUARIO_ADMIN',
  password: '123',
  connectString: 'localhost/orcl',
};

// Función para ejecutar consultas
async function executeQuery(query, params = [], options = {}) {
  let connection;
  try {
    connection = await oracledb.getConnection(dbConfig);
    const result = await connection.execute(query, params, options);
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
    const query = 'SELECT * FROM FIDE_USUARIO_TB WHERE correo = :email AND contrasena = :password AND ID_ESTADO = 1';
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
    const result = await executeQuery('SELECT ID_ESPECIALIZACION, AREA_ESPECIALIZACION FROM FIDE_ESPECIALIZACION_DOCENTE_TB WHERE ID_ESTADO = 1');
    res.json(result);
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
  const { nombre, primerApellido, segundoApellido, correo, tipoUsuario, codigoPais, telefono, idEspecializacion, contrasena } = req.body;
  try {
    const connection = await oracledb.getConnection(dbConfig);
    const query = `
      INSERT INTO FIDE_USUARIO_TB (
        NOMBRE, PRIMER_APELLIDO, SEGUNDO_APELLIDO, CORREO, TIPO_USUARIO, CODIGO_PAIS, TELEFONO, ID_ESPECIALIZACION, CONTRASENA, ID_ESTADO
      ) VALUES (:nombre, :primerApellido, :segundoApellido, :correo, :tipoUsuario, :codigoPais, :telefono, :idEspecializacion, :contrasena, 1)`;
     
      const binds = {
      nombre,
      primerApellido,
      segundoApellido,
      correo,
      tipoUsuario,
      codigoPais,
      telefono,
      idEspecializacion,
      contrasena
    };

    await connection.execute(query, binds, { autoCommit: true });
    await connection.close();

    // Enviar correo de notificación
    const emailContent = `
    <div style="font-family: Arial, sans-serif; max-width: 600px; margin: auto; padding: 20px; border: 1px solid #ddd; border-radius: 10px;">
      <h2 style="color: #4CAF50; text-align: center;">Universidad Sabiduría</h2>
      <p>Hola ${nombre} ${primerApellido},</p>
      <p>Tu registro en la Universidad Sabiduría ha sido exitoso!</p>
      <p>Estamos emocionados de tenerte con nosotros. Aquí encontrarás una comunidad vibrante y recursos para ayudarte a alcanzar tus metas académicas.</p>
      <p>Tu correo es ${correo} y contraseña: ${contrasena}. Puedes cambiarlo en cualquier momento</p>
      <p>Saludos,</p>
      <p><strong>Equipo de Soporte</strong></p>
      <hr style="border: none; border-top: 1px solid #ddd; margin: 20px 0;">
      <p style="font-size: 12px; color: #888; text-align: center;">Este es un correo automático, por favor no respondas a este mensaje.</p>
    </div>
  `;
  
  sendEmail(
    'gcastroa16@gmail.com', // Correo del usuario
    'Registro Exitoso en Universidad Sabiduría',
    emailContent
  );

    res.status(201).send('Usuario creado exitosamente');
  } catch (err) {
    console.error(err);
    res.status(500).send('Error del servidor');
  }
});

app.get('/getDireccionId/:id', async (req, res) => {
  try {
    const inventario = await executeQuery('SELECT CALLE, NUMERO_CASA, OTRAS_SENAS FROM FIDE_DIRECCION_TB WHERE ID_ESTADO = 1 AND ID_DIRECCION = :id', [req.params.id]);
    res.json(inventario);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.get('/getPlanEstudios', async (req, res) => {
  try {
    const query = `
      SELECT 
        pe.NOMBRE_CARRERA,
        c.ID_CURSO,
        c.NOMBRE AS NOMBRE_CURSO,
        c.CREDITOS,
        c.CUPOS
      FROM 
        FIDE_PLAN_ESTUDIOS_TB pe
      JOIN 
        FIDE_CURSOS_PLAN_TB cp ON pe.ID_PLAN_ESTUDIOS = cp.ID_PLAN_ESTUDIOS
      JOIN 
        FIDE_CURSO_TB c ON cp.ID_CURSO = c.ID_CURSO
      WHERE 
        pe.ID_ESTADO = 1 AND
        cp.ID_ESTADO = 1 AND
        c.ID_ESTADO = 1
      ORDER BY 
        pe.NOMBRE_CARRERA, c.NOMBRE
    `;
    const planEstudios = await executeQuery(query, [], { outFormat: oracledb.OBJECT });
    res.json(planEstudios);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Error al obtener el plan de estudios' });
  }
});

app.get('/getHistorialAcademico/:idUsuario', async (req, res) => {
  const { idUsuario } = req.params;
  try {
    const query = `
      SELECT 
        ha.ID_HISTORIAL,
        c.NOMBRE AS NOMBRE_CURSO,
        ha.PERIODO,
        ha.ANNO,
        ha.OBSERVACIONES,
        ha.CALIFICACION
      FROM 
        FIDE_HISTORIAL_ACADEMICO_TB ha
      JOIN 
        FIDE_CURSO_TB c ON ha.ID_CURSO = c.ID_CURSO
      WHERE 
        ha.ID_USUARIO = :idUsuario AND
        ha.ID_ESTADO = 1
      ORDER BY 
        ha.ANNO, ha.PERIODO
    `;
    const historialAcademico = await executeQuery(query, [idUsuario], { outFormat: oracledb.OBJECT });
    res.json(historialAcademico);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Error al obtener el historial académico' });
  }
});

app.post('/cambiarContrasena', async (req, res) => {
  const { correo, contrasenaActual, nuevaContrasena } = req.body;
  try {
    const connection = await oracledb.getConnection(dbConfig);
    
    // Verificar la contraseña actual
    const queryVerificar = `
      SELECT * FROM FIDE_USUARIO_TB 
      WHERE CORREO = :correo AND CONTRASENA = :contrasenaActual AND ID_ESTADO = 1
    `;
    const resultVerificar = await connection.execute(queryVerificar, [correo, contrasenaActual], { outFormat: oracledb.OBJECT });

    if (resultVerificar.rows.length === 0) {
      await connection.close();
      return res.status(401).send('Correo o contraseña actual incorrectos ❌');
    }

    // Actualizar la contraseña
    const queryActualizar = `
      UPDATE FIDE_USUARIO_TB 
      SET CONTRASENA = :nuevaContrasena, FECHA_MODIFICACION = SYSTIMESTAMP 
      WHERE CORREO = :correo
    `;
    await connection.execute(queryActualizar, [nuevaContrasena, correo], { autoCommit: true });
    await connection.close();

    res.status(200).send('Contraseña actualizada exitosamente ✅');
  } catch (err) {
    console.error(err);
    res.status(500).send('Error al cambiar la contraseña ❌');
  }
});

// Obtener cursos matriculados por el usuario
app.get('/getCursosMatriculados/:idUsuario', async (req, res) => {
  const { idUsuario } = req.params;
  try {
    const query = `
      SELECT ID_CURSO
      FROM FIDE_HORARIO_MATRICULADO_TB
      WHERE ID_USUARIO = :idUsuario AND ID_ESTADO = 1
    `;
    const result = await executeQuery(query, [idUsuario], { outFormat: oracledb.OBJECT });
    res.json(result);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Error al obtener los cursos matriculados' });
  }
});


// Obtener cursos disponibles
app.get('/getCursosDisponibles', async (req, res) => {
  try {
    const query = `
      SELECT 
        ID_CURSO,
        NOMBRE AS NOMBRE_CURSO,
        CREDITOS,
        CUPOS
      FROM 
        FIDE_CURSO_TB
      WHERE 
        ID_ESTADO = 1
      ORDER BY 
        NOMBRE
    `;
    const result = await executeQuery(query, [], { outFormat: oracledb.OBJECT });
    res.json(result);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Error al obtener los cursos disponibles' });
  }
});

// Matricularse en un curso
app.post('/matricularCurso', async (req, res) => {
  const { idUsuario, idCurso } = req.body;
  try {
    const connection = await oracledb.getConnection(dbConfig);

    // Verificar cupos disponibles
    const queryVerificar = `
      SELECT CUPOS FROM FIDE_CURSO_TB WHERE ID_CURSO = :idCurso FOR UPDATE
    `;
    const resultVerificar = await connection.execute(queryVerificar, [idCurso], { outFormat: oracledb.OBJECT });

    if (resultVerificar.rows.length === 0 || resultVerificar.rows[0].CUPOS <= 0) {
      await connection.close();
      return res.status(400).send('No hay cupos disponibles');
    }

    // Reducir cupo
    const queryReducirCupo = `
      UPDATE FIDE_CURSO_TB 
      SET CUPOS = CUPOS - 1 
      WHERE ID_CURSO = :idCurso
    `;
    await connection.execute(queryReducirCupo, [idCurso], { autoCommit: false });

    // Insertar matrícula
    const queryMatricular = `
      INSERT INTO FIDE_HORARIO_MATRICULADO_TB (
        FECHA_MATRICULA, ID_USUARIO, ID_CURSO, ID_ESTADO
      ) VALUES (SYSDATE, :idUsuario, :idCurso, 1)
    `;
    await connection.execute(queryMatricular, [idUsuario, idCurso], { autoCommit: true });

    await connection.close();
    res.status(201).send('Matrícula exitosa');
  } catch (err) {
    console.error(err);
    res.status(500).send('Error al matricular el curso');
  }
});

// Matricularse en un curso
app.post('/matricularCurso', async (req, res) => {
  const { idUsuario, idCurso, idHorario } = req.body;
  try {
    const connection = await oracledb.getConnection(dbConfig);
    const query = `
      INSERT INTO FIDE_HORARIO_MATRICULADO_TB (
        FECHA_MATRICULA, ID_USUARIO, ID_CURSO, ID_HORARIO, ID_ESTADO
      ) VALUES (SYSDATE, :idUsuario, :idCurso, :idHorario, 1)
    `;
    const binds = { idUsuario, idCurso, idHorario };
    await connection.execute(query, binds, { autoCommit: true });
    await connection.close();
    res.status(201).send('Matrícula exitosa');
  } catch (err) {
    console.error(err);
    res.status(500).send('Error al matricular el curso');
  }
});

// ... código existente ...

// Inicio del servidor
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
