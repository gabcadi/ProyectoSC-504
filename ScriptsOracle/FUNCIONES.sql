--- INSERTAR CURSO ---
CREATE OR REPLACE FUNCTION FIDE_CURSO_TB_INSERTAR_CURSO_FN (
    P_NOMBRE IN VARCHAR2,
    P_CREDITOS IN NUMBER,
    P_CUPOS IN NUMBER,
    P_ID_ESTADO IN NUMBER
) 
RETURN NUMBER
IS
    V_ID_CURSO NUMBER;
BEGIN
    -- Insertar el nuevo curso
    INSERT INTO FIDE_CURSO_TB (ID_CURSO, NOMBRE, CREDITOS, CUPOS, ID_ESTADO)
    VALUES (FIDE_CURSO_ID_CURSO_SEQ.NEXTVAL, P_NOMBRE, P_CREDITOS, P_CUPOS, P_ID_ESTADO)
    RETURNING ID_CURSO INTO V_ID_CURSO;

    -- Retornar el ID del nuevo curso insertado
    RETURN V_ID_CURSO;
END;

/
--- EDITAR CURSO ---
CREATE OR REPLACE FUNCTION FIDE_CURSO_TB_EDITAR_CURSO_FN (
    P_ID_CURSO IN NUMBER,
    P_NOMBRE IN VARCHAR2,
    P_CREDITOS IN NUMBER,
    P_CUPOS IN NUMBER
) 
RETURN VARCHAR2
IS
BEGIN
    -- Actualizar los datos del curso
    UPDATE FIDE_CURSO_TB
    SET 
        NOMBRE = P_NOMBRE,
        CREDITOS = P_CREDITOS,
        CUPOS = P_CUPOS,
        FECHA_MODIFICACION = SYSTIMESTAMP -- Actualizamos la fecha de modificaci�n
    WHERE ID_CURSO = P_ID_CURSO;

    -- Verificar si se actualiz� alg�n registro
    IF SQL%ROWCOUNT > 0 THEN
        RETURN 'Curso actualizado exitosamente';
    ELSE
        RETURN 'No se encontr� el curso con el ID especificado';
    END IF;
END;

/
--- CAMBIAR ESTADO ---
CREATE OR REPLACE FUNCTION FIDE_CURSO_TB_OCULTAR_CURSO_FN (
    P_ID_CURSO IN NUMBER
) 
RETURN VARCHAR2
IS
BEGIN
    -- Actualizar el estado del curso a 0
    UPDATE FIDE_CURSO_TB
    SET ID_ESTADO = 0, 
        FECHA_MODIFICACION = SYSTIMESTAMP -- Actualizamos la fecha de modificaci�n
    WHERE ID_CURSO = P_ID_CURSO;

    -- Verificar si se actualiz� alg�n registro
    IF SQL%ROWCOUNT > 0 THEN
        RETURN 'Estado del curso cambiado a INACTIVO (0) exitosamente';
    ELSE
        RETURN 'No se encontr� el curso con el ID especificado';
    END IF;
END;
/
--- REGISTRAR DOCENTE ---
CREATE OR REPLACE FUNCTION FIDE_USUARIO_TB_REGISTRAR_DOCENTE_FN (
    P_NOMBRE IN VARCHAR2,
    P_PRIMER_APELLIDO IN VARCHAR2,
    P_SEGUNDO_APELLIDO IN VARCHAR2,
    P_CORREO IN VARCHAR2,
    P_TIPO_USUARIO IN VARCHAR2,
    P_CODIGO_PAIS IN VARCHAR2,
    P_TELEFONO IN VARCHAR2,
    P_ID_DIRECCION IN NUMBER,
    P_ID_ESPECIALIZACION IN NUMBER
) 
RETURN NUMBER
IS
    V_ID_USUARIO NUMBER;
BEGIN
    -- Insertar el nuevo docente
    INSERT INTO FIDE_USUARIO_TB (
        ID_USUARIO, NOMBRE, PRIMER_APELLIDO, SEGUNDO_APELLIDO, CORREO, 
        TIPO_USUARIO, CODIGO_PAIS, TELEFONO, ID_DIRECCION, ID_ESPECIALIZACION
    ) 
    VALUES (
        FIDE_USUARIO_ID_USUARIO_SEQ.NEXTVAL, P_NOMBRE, P_PRIMER_APELLIDO, 
        P_SEGUNDO_APELLIDO, P_CORREO, P_TIPO_USUARIO, P_CODIGO_PAIS, 
        P_TELEFONO, P_ID_DIRECCION, P_ID_ESPECIALIZACION
    )
    RETURNING ID_USUARIO INTO V_ID_USUARIO;

    -- Retornar el ID del nuevo docente
    RETURN V_ID_USUARIO;
END;

/
--- EDITAR DOCENTE ---
CREATE OR REPLACE FUNCTION FIDE_USUARIO_TB_EDITAR_DOCENTE_FN (
    P_ID_USUARIO IN NUMBER,
    P_NOMBRE IN VARCHAR2,
    P_PRIMER_APELLIDO IN VARCHAR2,
    P_SEGUNDO_APELLIDO IN VARCHAR2,
    P_CORREO IN VARCHAR2,
    P_TIPO_USUARIO IN VARCHAR2,
    P_CODIGO_PAIS IN VARCHAR2,
    P_TELEFONO IN VARCHAR2,
    P_ID_DIRECCION IN NUMBER,
    P_ID_ESPECIALIZACION IN NUMBER
) 
RETURN VARCHAR2
IS
BEGIN
    -- Actualizar la informaci�n del docente
    UPDATE FIDE_USUARIO_TB
    SET 
        NOMBRE = P_NOMBRE,
        PRIMER_APELLIDO = P_PRIMER_APELLIDO,
        SEGUNDO_APELLIDO = P_SEGUNDO_APELLIDO,
        CORREO = P_CORREO,
        TIPO_USUARIO = P_TIPO_USUARIO,
        CODIGO_PAIS = P_CODIGO_PAIS,
        TELEFONO = P_TELEFONO,
        ID_DIRECCION = P_ID_DIRECCION,
        ID_ESPECIALIZACION = P_ID_ESPECIALIZACION,
        FECHA_MODIFICACION = SYSTIMESTAMP  -- Actualizamos la fecha de modificaci�n
    WHERE ID_USUARIO = P_ID_USUARIO;

    -- Verificar si se actualiz� alg�n registro
    IF SQL%ROWCOUNT > 0 THEN
        RETURN 'Docente actualizado exitosamente';
    ELSE
        RETURN 'No se encontr� el docente con el ID especificado';
    END IF;
END;

/
--- AGREGAR AULA ---
CREATE OR REPLACE FUNCTION FIDE_AULAS_TB_AGREGAR_AULA_FN (
    P_NOMBRE_AULA IN VARCHAR2,
    P_CAPACIDAD IN NUMBER,
    P_ID_ESTADO IN NUMBER
) 
RETURN NUMBER
IS
    V_ID_AULA NUMBER;
BEGIN
    -- Insertar el nuevo aula
    INSERT INTO FIDE_AULAS_TB (ID_AULA, NOMBRE_AULA, CAPACIDAD, ID_ESTADO)
    VALUES (FIDE_AULAS_ID_AULA_SEQ.NEXTVAL, P_NOMBRE_AULA, P_CAPACIDAD, P_ID_ESTADO)
    RETURNING ID_AULA INTO V_ID_AULA;

    -- Retornar el ID del nuevo aula
    RETURN V_ID_AULA;
END;

/
--- AGREGAR UN NUEVO HORARIO ---
CREATE OR REPLACE FUNCTION FIDE_HORARIO_TB_AGREGAR_HORARIO_FN (
    P_DIA_SEMANA IN VARCHAR2,
    P_TURNO IN VARCHAR2,
    P_ID_ESTADO IN NUMBER
) 
RETURN NUMBER
IS
    V_ID_HORARIO NUMBER;
BEGIN
    -- Insertar el nuevo horario
    INSERT INTO FIDE_HORARIO_TB (ID_HORARIO, V_DIA_SEMANA, V_TURNO, ID_ESTADO)
    VALUES (FIDE_HORARIO_ID_HORARIO_SEQ.NEXTVAL, P_DIA_SEMANA, P_TURNO, P_ID_ESTADO)
    RETURNING ID_HORARIO INTO V_ID_HORARIO;

    -- Retornar el ID del nuevo horario
    RETURN V_ID_HORARIO;
END;

/
--- EDITAR HORARIO ---
CREATE OR REPLACE FUNCTION FIDE_HORARIO_TB_EDITAR_HORARIO_FN (
    P_ID_HORARIO IN NUMBER,
    P_DIA_SEMANA IN VARCHAR2,
    P_TURNO IN VARCHAR2,
    P_ID_ESTADO IN NUMBER
) 
RETURN VARCHAR2
IS
BEGIN
    -- Actualizar el horario existente
    UPDATE FIDE_HORARIO_TB
    SET 
        V_DIA_SEMANA = P_DIA_SEMANA,
        V_TURNO = P_TURNO,
        ID_ESTADO = P_ID_ESTADO
    WHERE ID_HORARIO = P_ID_HORARIO;

    -- Verificar si se actualiz� alg�n registro
    IF SQL%ROWCOUNT > 0 THEN
        RETURN 'Horario actualizado exitosamente';
    ELSE
        RETURN 'No se encontr� el horario con el ID especificado';
    END IF;
END;
/