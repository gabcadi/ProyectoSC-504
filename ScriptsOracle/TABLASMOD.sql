-- Tabla de Estado
CREATE TABLE FIDE_ESTADO_TB (
    ID_ESTADO NUMBER(1) NOT NULL, -- 1 = Activo, 0 = Inactivo
    DESCRIPCION VARCHAR2(50) NOT NULL,
    CONSTRAINT FIDE_ESTADO_ID_ESTADO_PK PRIMARY KEY (ID_ESTADO)
);

-- Tabla de PAIS
CREATE TABLE FIDE_PAIS_TB (
    ID_PAIS NUMBER,  
    PAIS VARCHAR2(50) NOT NULL,
    CREADO_POR VARCHAR2(100),
    MODIFICADO_POR VARCHAR2(100),
    FECHA_CREACION TIMESTAMP,
    FECHA_MODIFICACION TIMESTAMP,
    ACCION VARCHAR2(100),
    CONSTRAINT FIDE_PAIS_ID_PAIS_PK PRIMARY KEY (ID_PAIS)  
);

-- Tabla de PROVINCIA
CREATE TABLE FIDE_PROVINCIA_TB (
    ID_PROVINCIA NUMBER,  
    PROVINCIA VARCHAR2(50) NOT NULL,
    CREADO_POR VARCHAR2(100),
    MODIFICADO_POR VARCHAR2(100),
    FECHA_CREACION TIMESTAMP,
    FECHA_MODIFICACION TIMESTAMP,
    ACCION VARCHAR2(100),
    CONSTRAINT FIDE_PROVINCIA_ID_PROVINCIA_PK PRIMARY KEY (ID_PROVINCIA)  
);
-- Relaci�n CANTON
CREATE TABLE FIDE_CANTON_TB (
    ID_CANTON NUMBER,  
    CANTON VARCHAR2(50) NOT NULL,
    CREADO_POR VARCHAR2(100),
    MODIFICADO_POR VARCHAR2(100),
    FECHA_CREACION TIMESTAMP,
    FECHA_MODIFICACION TIMESTAMP,
    ACCION VARCHAR2(100),
    CONSTRAINT FIDE_CANTON_ID_CANTON_PK PRIMARY KEY (ID_CANTON)  
);

-- Tabla de DISTRITOS
CREATE TABLE FIDE_DISTRITO_TB (
    ID_DISTRITO NUMBER, 
    DISTRITO VARCHAR2(50) NOT NULL,
    CREADO_POR VARCHAR2(100),
    MODIFICADO_POR VARCHAR2(100),
    FECHA_CREACION TIMESTAMP,
    FECHA_MODIFICACION TIMESTAMP,
    ACCION VARCHAR2(100),
    CONSTRAINT FIDE_DISTRITO_ID_DISTRITO_PK PRIMARY KEY (ID_DISTRITO) 
);

-- Tabla de DIRECCION
CREATE TABLE FIDE_DIRECCION_TB (
    ID_DIRECCION NUMBER,  
    CALLE VARCHAR2(100),
    NUMERO_CASA VARCHAR2(10),
    OTRAS_SENAS VARCHAR2(100),
    ID_PAIS NUMBER,
    ID_PROVINCIA NUMBER,
    ID_CANTON NUMBER,
    ID_DISTRITO NUMBER,
    ID_ESTADO NUMBER(1),
    CREADO_POR VARCHAR2(100),
    MODIFICADO_POR VARCHAR2(100),
    FECHA_CREACION TIMESTAMP,
    FECHA_MODIFICACION TIMESTAMP,
    ACCION VARCHAR2(100),
    CONSTRAINT FIDE_DIRECCION_ID_DIRECCION_PK PRIMARY KEY (ID_DIRECCION),  
    FOREIGN KEY (ID_PAIS) REFERENCES FIDE_PAIS_TB(ID_PAIS),
    FOREIGN KEY (ID_PROVINCIA) REFERENCES FIDE_PROVINCIA_TB(ID_PROVINCIA),
    FOREIGN KEY (ID_CANTON) REFERENCES FIDE_CANTON_TB(ID_CANTON),
    FOREIGN KEY (ID_DISTRITO) REFERENCES FIDE_DISTRITO_TB(ID_DISTRITO),
    FOREIGN KEY (ID_ESTADO) REFERENCES FIDE_ESTADO_TB(ID_ESTADO)
);

-- Tabla de Especializaci�n de Docentes
CREATE TABLE FIDE_ESPECIALIZACION_DOCENTE_TB (
    ID_ESPECIALIZACION NUMBER,
    AREA_ESPECIALIZACION VARCHAR2(100),
    ID_ESTADO NUMBER(1),
    CREADO_POR VARCHAR2(100),
    MODIFICADO_POR VARCHAR2(100),
    FECHA_CREACION TIMESTAMP,
    FECHA_MODIFICACION TIMESTAMP,
    ACCION VARCHAR2(100),
    CONSTRAINT FIDE_ESPECIALIZACION_DOCENTE_ID_ESPECIALIZACION_PK PRIMARY KEY (ID_ESPECIALIZACION),
    FOREIGN KEY (ID_ESTADO) REFERENCES FIDE_ESTADO_TB(ID_ESTADO)
);

-- Tabla de USUARIOS
CREATE TABLE FIDE_USUARIO_TB (
    ID_USUARIO NUMBER, 
    NOMBRE VARCHAR2(50) NOT NULL,
    PRIMER_APELLIDO VARCHAR2(50) NOT NULL,
    SEGUNDO_APELLIDO VARCHAR2(50),
    CORREO VARCHAR2(100) UNIQUE NOT NULL,
    TIPO_USUARIO VARCHAR2(20) CHECK (TIPO_USUARIO IN ('Estudiante', 'Docente', 'Administrativo', 'Decanato')),
    CODIGO_PAIS VARCHAR2(10),
    TELEFONO VARCHAR2(20),
    ID_ESTADO NUMBER(1),
    ID_DIRECCION NUMBER,
    ID_ESPECIALIZACION NUMBER,
    CREADO_POR VARCHAR2(100),
    MODIFICADO_POR VARCHAR2(100),
    FECHA_CREACION TIMESTAMP,
    FECHA_MODIFICACION TIMESTAMP,
    ACCION VARCHAR2(100),
    CONSTRAINT FIDE_USUARIO_ID_USUARIO_PK PRIMARY KEY (ID_USUARIO),  
    FOREIGN KEY (ID_ESTADO) REFERENCES FIDE_ESTADO_TB(ID_ESTADO),
    FOREIGN KEY (ID_DIRECCION) REFERENCES FIDE_DIRECCION_TB(ID_DIRECCION),
    FOREIGN KEY (ID_ESPECIALIZACION) REFERENCES FIDE_ESPECIALIZACION_DOCENTE_TB(ID_ESPECIALIZACION)
);

-- Tabla de CURSO
CREATE TABLE FIDE_CURSO_TB (
    ID_CURSO NUMBER, 
    NOMBRE VARCHAR2(100) NOT NULL,
    CREDITOS NUMBER NOT NULL,
    CUPOS NUMBER NOT NULL,
    ID_ESTADO NUMBER(1),
    CREADO_POR VARCHAR2(100),
    MODIFICADO_POR VARCHAR2(100),
    FECHA_CREACION TIMESTAMP,
    FECHA_MODIFICACION TIMESTAMP,
    ACCION VARCHAR2(100),
    CONSTRAINT FIDE_CURSO_ID_CURSO_PK PRIMARY KEY (ID_CURSO),  
    FOREIGN KEY (ID_ESTADO) REFERENCES FIDE_ESTADO_TB(ID_ESTADO)
);

-- Tabla de HORARIOS
CREATE TABLE FIDE_HORARIO_TB (
    ID_HORARIO NUMBER,  
    V_DIA_SEMANA VARCHAR2(10), -- Ej: "Lunes", "Martes"
    V_TURNO VARCHAR2(10), -- Ej: "Ma�ana", "Tarde", "Noche"
    ID_ESTADO NUMBER(1),
    CREADO_POR VARCHAR2(100),
    MODIFICADO_POR VARCHAR2(100),
    FECHA_CREACION TIMESTAMP,
    FECHA_MODIFICACION TIMESTAMP,
    ACCION VARCHAR2(100),
    CONSTRAINT FIDE_HORARIO_ID_HORARIO_PK PRIMARY KEY (ID_HORARIO),  
    FOREIGN KEY (ID_ESTADO) REFERENCES FIDE_ESTADO_TB(ID_ESTADO)
);

-- Tabla de Curso-Horario
CREATE TABLE FIDE_CURSO_HORARIO_TB (
    ID_CURSO NUMBER,
    ID_HORARIO NUMBER,
    ID_ESTADO NUMBER(1),
    CREADO_POR VARCHAR2(100),
    MODIFICADO_POR VARCHAR2(100),
    FECHA_CREACION TIMESTAMP,
    FECHA_MODIFICACION TIMESTAMP,
    ACCION VARCHAR2(100),
    PRIMARY KEY (ID_CURSO, ID_HORARIO),
    FOREIGN KEY (ID_CURSO) REFERENCES FIDE_CURSO_TB(ID_CURSO),
    FOREIGN KEY (ID_HORARIO) REFERENCES FIDE_HORARIO_TB(ID_HORARIO),
    FOREIGN KEY (ID_ESTADO) REFERENCES FIDE_ESTADO_TB(ID_ESTADO)
);

-- Tabla de Requisitos y Correquisitos 
CREATE TABLE FIDE_CURSO_RELACIONADO_TB (
    ID_REQUISITO NUMBER,  
    ID_CURSO NUMBER,
    ID_CURSO_REQUISITO NUMBER, -- Curso prerrequisito o correquisito 
    TIPO_RELACION VARCHAR2(20) CHECK (TIPO_RELACION IN ('Requisito', 'Correquisito')),
    ID_ESTADO NUMBER(1),
    CREADO_POR VARCHAR2(100),
    MODIFICADO_POR VARCHAR2(100),
    FECHA_CREACION TIMESTAMP,
    FECHA_MODIFICACION TIMESTAMP,
    ACCION VARCHAR2(100),
    CONSTRAINT FIDE_CURSO_RELACIONADO_ID_REQUISITO_PK PRIMARY KEY (ID_REQUISITO), 
    FOREIGN KEY (ID_CURSO) REFERENCES FIDE_CURSO_TB(ID_CURSO),
    FOREIGN KEY (ID_CURSO_REQUISITO) REFERENCES FIDE_CURSO_TB(ID_CURSO),
    FOREIGN KEY (ID_ESTADO) REFERENCES FIDE_ESTADO_TB(ID_ESTADO)
);

-- Tabla de Asignaciones de Docentes a Cursos
CREATE TABLE FIDE_ASIGNACION_DOCENTE_TB (
    ID_ASIGNACION NUMBER,
    ID_USUARIO NUMBER,  -- El docente asignado
    ID_CURSO NUMBER,
    ID_HORARIO NUMBER,
    ID_ESTADO NUMBER(1),
    CREADO_POR VARCHAR2(100),
    MODIFICADO_POR VARCHAR2(100),
    FECHA_CREACION TIMESTAMP,
    FECHA_MODIFICACION TIMESTAMP,
    ACCION VARCHAR2(100),
    CONSTRAINT FIDE_ASIGNACION_DOCENTE_ID_ASIGNACION_PK PRIMARY KEY (ID_ASIGNACION),
    FOREIGN KEY (ID_USUARIO) REFERENCES FIDE_USUARIO_TB(ID_USUARIO),
    FOREIGN KEY (ID_CURSO, ID_HORARIO) REFERENCES FIDE_CURSO_HORARIO_TB(ID_CURSO, ID_HORARIO),
    FOREIGN KEY (ID_ESTADO) REFERENCES FIDE_ESTADO_TB(ID_ESTADO)
);

-- Tabla de AULAS
CREATE TABLE FIDE_AULAS_TB (
    ID_AULA NUMBER,
    NOMBRE_AULA VARCHAR2(50) UNIQUE NOT NULL,
    CAPACIDAD NUMBER NOT NULL,
    ID_ESTADO NUMBER(1),
    CREADO_POR VARCHAR2(100),
    MODIFICADO_POR VARCHAR2(100),
    FECHA_CREACION TIMESTAMP,
    FECHA_MODIFICACION TIMESTAMP,
    ACCION VARCHAR2(100),
    CONSTRAINT FIDE_AULAS_ID_AULA_PK PRIMARY KEY (ID_AULA),
    FOREIGN KEY (ID_ESTADO) REFERENCES FIDE_ESTADO_TB(ID_ESTADO)
);
-- Tabla de Curso-Horario-Aula
CREATE TABLE FIDE_CURSO_AULA_TB (
    ID_CURSO NUMBER,
    ID_HORARIO NUMBER,
    ID_AULA NUMBER,
    ID_ESTADO NUMBER(1),
    CREADO_POR VARCHAR2(100),
    MODIFICADO_POR VARCHAR2(100),
    FECHA_CREACION TIMESTAMP,
    FECHA_MODIFICACION TIMESTAMP,
    ACCION VARCHAR2(100),
    PRIMARY KEY (ID_CURSO, ID_HORARIO, ID_AULA),
    FOREIGN KEY (ID_CURSO) REFERENCES FIDE_CURSO_TB(ID_CURSO),
    FOREIGN KEY (ID_HORARIO) REFERENCES FIDE_HORARIO_TB(ID_HORARIO),
    FOREIGN KEY (ID_AULA) REFERENCES FIDE_AULAS_TB(ID_AULA),
    FOREIGN KEY (ID_ESTADO) REFERENCES FIDE_ESTADO_TB(ID_ESTADO)
);

-- Tabla de Plan de Estudios
CREATE TABLE FIDE_PLAN_ESTUDIOS_TB (
    ID_PLAN_ESTUDIOS NUMBER,
    NOMBRE_CARRERA VARCHAR2(100) NOT NULL,
    ID_ESTADO NUMBER(1),
    CREADO_POR VARCHAR2(100),
    MODIFICADO_POR VARCHAR2(100),
    FECHA_CREACION TIMESTAMP,
    FECHA_MODIFICACION TIMESTAMP,
    ACCION VARCHAR2(100),
    CONSTRAINT FIDE_PLAN_ESTUDIOS_ID_PLAN_ESTUDIOS_PK PRIMARY KEY (ID_PLAN_ESTUDIOS),
    FOREIGN KEY (ID_ESTADO) REFERENCES FIDE_ESTADO_TB(ID_ESTADO)
);

-- Relaci�n Curso-Plan de Estudios
CREATE TABLE FIDE_CURSOS_PLAN_TB (
    ID_CURSO NUMBER,
    ID_PLAN_ESTUDIOS NUMBER,
    ID_ESTADO NUMBER(1),
    CREADO_POR VARCHAR2(100),
    MODIFICADO_POR VARCHAR2(100),
    FECHA_CREACION TIMESTAMP,
    FECHA_MODIFICACION TIMESTAMP,
    ACCION VARCHAR2(100),
    PRIMARY KEY (ID_CURSO, ID_PLAN_ESTUDIOS),
    FOREIGN KEY (ID_CURSO) REFERENCES FIDE_CURSO_TB(ID_CURSO),
    FOREIGN KEY (ID_PLAN_ESTUDIOS) REFERENCES FIDE_PLAN_ESTUDIOS_TB(ID_PLAN_ESTUDIOS),
    FOREIGN KEY (ID_ESTADO) REFERENCES FIDE_ESTADO_TB(ID_ESTADO)
);

-- TABLA Historial Acad�mico
CREATE TABLE FIDE_HISTORIAL_ACADEMICO_TB (
    ID_HISTORIAL NUMBER,
    ID_USUARIO NUMBER,
    ID_CURSO NUMBER,
    PERIODO VARCHAR2(50),
    ANNO NUMBER,
    OBSERVACIONES VARCHAR2(500),
    CALIFICACION NUMBER CHECK (CALIFICACION BETWEEN 0 AND 100),
    ID_ESTADO NUMBER(1),
    CREADO_POR VARCHAR2(100),
    MODIFICADO_POR VARCHAR2(100),
    FECHA_CREACION TIMESTAMP,
    FECHA_MODIFICACION TIMESTAMP,
    ACCION VARCHAR2(100),
    CONSTRAINT FIDE_HISTORIAL_ACADEMICO_ID_HISTORIAL_PK PRIMARY KEY (ID_HISTORIAL),
    FOREIGN KEY (ID_USUARIO) REFERENCES FIDE_USUARIO_TB(ID_USUARIO),
    FOREIGN KEY (ID_CURSO) REFERENCES FIDE_CURSO_TB(ID_CURSO),
    FOREIGN KEY (ID_ESTADO) REFERENCES FIDE_ESTADO_TB(ID_ESTADO)
);

-- Tabla de Notificaciones
CREATE TABLE FIDE_NOTIFICACIONES_TB (
    ID_NOTIFICACION NUMBER,
    ID_USUARIO NUMBER,
    MENSAJE VARCHAR2(255),
    FECHA_ENVIO DATE,
    ID_ESTADO NUMBER(1),  -- 0 = No le�do, 1 = Le�do
    CREADO_POR VARCHAR2(100),
    MODIFICADO_POR VARCHAR2(100),
    FECHA_CREACION TIMESTAMP,
    FECHA_MODIFICACION TIMESTAMP,
    ACCION VARCHAR2(100),
    CONSTRAINT FIDE_NOTIFICACIONES_ID_NOTIFICACION_PK PRIMARY KEY (ID_NOTIFICACION),
    FOREIGN KEY (ID_USUARIO) REFERENCES FIDE_USUARIO_TB(ID_USUARIO),
    FOREIGN KEY (ID_ESTADO) REFERENCES FIDE_ESTADO_TB(ID_ESTADO)
);


-- Tabla de Horario Matriculado
CREATE TABLE FIDE_HORARIO_MATRICULADO_TB (
    ID_HORARIO_MATRICULADO NUMBER,
    FECHA_MATRICULA DATE NOT NULL,
    ID_USUARIO NUMBER,
    ID_CURSO NUMBER,
    ID_HORARIO NUMBER,
    ID_ESTADO NUMBER(1),
    CREADO_POR VARCHAR2(100),
    MODIFICADO_POR VARCHAR2(100),
    FECHA_CREACION TIMESTAMP,
    FECHA_MODIFICACION TIMESTAMP,
    ACCION VARCHAR2(100),
    CONSTRAINT FIDE_HORARIO_MATRICULADO_ID_HORARIO_MATRICULADO_PK PRIMARY KEY (ID_HORARIO_MATRICULADO),
    FOREIGN KEY (ID_USUARIO) REFERENCES FIDE_USUARIO_TB(ID_USUARIO),
    FOREIGN KEY (ID_CURSO, ID_HORARIO) REFERENCES FIDE_CURSO_HORARIO_TB(ID_CURSO, ID_HORARIO),
    FOREIGN KEY (ID_ESTADO) REFERENCES FIDE_ESTADO_TB(ID_ESTADO)
);
