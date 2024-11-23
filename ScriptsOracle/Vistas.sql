--Vista cursos
CREATE OR REPLACE VIEW V_CURSOS_DETALLES AS
SELECT 
    C.ID_CURSO,
    C.NOMBRE AS NOMBRE_CURSO,
    C.CREDITOS,
    C.CUPOS,
    E.DESCRIPCION AS ESTADO_CURSO,
    C.CREADO_POR,
    C.FECHA_CREACION
FROM 
    FIDE_CURSO_TB C
JOIN 
    FIDE_ESTADO_TB E ON C.ID_ESTADO = E.ID_ESTADO;
    
    --vista horarios dsiponibles por curso
    CREATE OR REPLACE VIEW V_HORARIOS_CURSO AS
SELECT 
    CH.ID_CURSO,
    C.NOMBRE AS NOMBRE_CURSO,
    H.V_DIA_SEMANA,
    H.V_TURNO,
    A.NOMBRE_AULA,
    A.CAPACIDAD,
    E.DESCRIPCION AS ESTADO
FROM 
    FIDE_CURSO_AULA_TB CA
JOIN 
    FIDE_CURSO_TB C ON CA.ID_CURSO = C.ID_CURSO
JOIN 
    FIDE_HORARIO_TB H ON CA.ID_HORARIO = H.ID_HORARIO
JOIN 
    FIDE_AULAS_TB A ON CA.ID_AULA = A.ID_AULA
JOIN 
    FIDE_ESTADO_TB E ON CA.ID_ESTADO = E.ID_ESTADO;
    --Vista estudiantes con datos de contacto
    CREATE OR REPLACE VIEW V_ESTUDIANTES_CONTACTO AS
SELECT 
    U.ID_USUARIO,
    U.NOMBRE,
    U.PRIMER_APELLIDO,
    U.SEGUNDO_APELLIDO,
    U.CORREO,
    U.TELEFONO,
    D.CALLE || ', ' || D.NUMERO_CASA || ', ' || D.OTRAS_SENAS AS DIRECCION_COMPLETA,
    E.DESCRIPCION AS ESTADO
FROM 
    FIDE_USUARIO_TB U
LEFT JOIN 
    FIDE_DIRECCION_TB D ON U.ID_DIRECCION = D.ID_DIRECCION
JOIN 
    FIDE_ESTADO_TB E ON U.ID_ESTADO = E.ID_ESTADO
WHERE 
    U.TIPO_USUARIO = 'Estudiante';
    --Vista docente y sus asignaciones
    CREATE OR REPLACE VIEW V_DOCENTES_ASIGNACIONES AS
SELECT 
    D.ID_USUARIO AS ID_DOCENTE,
    U.NOMBRE || ' ' || U.PRIMER_APELLIDO || ' ' || U.SEGUNDO_APELLIDO AS NOMBRE_DOCENTE,
    C.NOMBRE AS CURSO,
    H.V_DIA_SEMANA AS DIA,
    H.V_TURNO AS TURNO,
    A.NOMBRE_AULA AS AULA,
    E.DESCRIPCION AS ESTADO_ASIGNACION
FROM 
    FIDE_ASIGNACION_DOCENTE_TB D
JOIN 
    FIDE_USUARIO_TB U ON D.ID_USUARIO = U.ID_USUARIO
JOIN 
    FIDE_CURSO_TB C ON D.ID_CURSO = C.ID_CURSO
JOIN 
    FIDE_HORARIO_TB H ON D.ID_HORARIO = H.ID_HORARIO
JOIN 
    FIDE_AULAS_TB A ON D.ID_CURSO = A.ID_AULA
JOIN 
    FIDE_ESTADO_TB E ON D.ID_ESTADO = E.ID_ESTADO;
    -- Vista Historial Académico de Estudiantes
    CREATE OR REPLACE VIEW V_HISTORIAL_ACADEMICO_ESTUDIANTES AS
SELECT 
    H.ID_HISTORIAL,
    U.NOMBRE || ' ' || U.PRIMER_APELLIDO AS ESTUDIANTE,
    C.NOMBRE AS CURSO,
    H.PERIODO,
    H.ANNO,
    H.CALIFICACION,
    E.DESCRIPCION AS ESTADO_HISTORIAL,
    H.OBSERVACIONES
FROM 
    FIDE_HISTORIAL_ACADEMICO_TB H
JOIN 
    FIDE_USUARIO_TB U ON H.ID_USUARIO = U.ID_USUARIO
JOIN 
    FIDE_CURSO_TB C ON H.ID_CURSO = C.ID_CURSO
JOIN 
    FIDE_ESTADO_TB E ON H.ID_ESTADO = E.ID_ESTADO;
    --Vista notificaciones por usuario
    CREATE OR REPLACE VIEW V_NOTIFICACIONES_USUARIOS AS
SELECT 
    N.ID_NOTIFICACION,
    U.NOMBRE || ' ' || U.PRIMER_APELLIDO AS USUARIO,
    N.MENSAJE,
    N.FECHA_ENVIO,
    E.DESCRIPCION AS ESTADO_NOTIFICACION
FROM 
    FIDE_NOTIFICACIONES_TB N
JOIN 
    FIDE_USUARIO_TB U ON N.ID_USUARIO = U.ID_USUARIO
JOIN 
    FIDE_ESTADO_TB E ON N.ID_ESTADO = E.ID_ESTADO;
--Vista planes de estudio y cursos
    CREATE OR REPLACE VIEW V_PLANES_CURSOS AS
SELECT 
    PE.ID_PLAN_ESTUDIOS,
    PE.NOMBRE_CARRERA,
    C.ID_CURSO,
    C.NOMBRE AS NOMBRE_CURSO,
    E.DESCRIPCION AS ESTADO_PLAN
FROM 
    FIDE_PLAN_ESTUDIOS_TB PE
JOIN 
    FIDE_CURSOS_PLAN_TB CP ON PE.ID_PLAN_ESTUDIOS = CP.ID_PLAN_ESTUDIOS
JOIN 
    FIDE_CURSO_TB C ON CP.ID_CURSO = C.ID_CURSO
JOIN 
    FIDE_ESTADO_TB E ON CP.ID_ESTADO = E.ID_ESTADO;