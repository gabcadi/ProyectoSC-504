CREATE TABLE ESTADO (
    ID_ESTADO NUMBER(1) PRIMARY KEY, -- 1 = Activo, 0 = Inactivo
    DESCRIPCION VARCHAR2(50) NOT NULL
);

-- Tabla de Cursos
CREATE TABLE CURSO (
    ID_CURSO NUMBER PRIMARY KEY, 
    NOMBRE VARCHAR2(100) NOT NULL,
    CREDITOS NUMBER NOT NULL,
    CUPOS NUMBER NOT NULL,
    ID_ESTADO NUMBER(1),
    FOREIGN KEY (ID_ESTADO) REFERENCES ESTADO(ID_ESTADO)
);

-- Tabla de Horarios
CREATE TABLE HORARIO (
    ID_HORARIO NUMBER PRIMARY KEY,
    DIA_SEMANA VARCHAR2(10), -- Ej: "Lunes", "Martes"
    TURNO VARCHAR2(10), -- Ej: "Mañana", "Tarde", "Noche"
    ID_ESTADO NUMBER(1),
    FOREIGN KEY (ID_ESTADO) REFERENCES ESTADO(ID_ESTADO)
);

-- Relación Curso-Horario
CREATE TABLE CURSO_HORARIO (
    ID_CURSO NUMBER,
    ID_HORARIO NUMBER,
    ID_ESTADO NUMBER(1),
    PRIMARY KEY (ID_CURSO, ID_HORARIO),
    FOREIGN KEY (ID_CURSO) REFERENCES CURSO(ID_CURSO),
    FOREIGN KEY (ID_HORARIO) REFERENCES HORARIO(ID_HORARIO),
    FOREIGN KEY (ID_ESTADO) REFERENCES ESTADO(ID_ESTADO)
);

-- Tabla de Requisitos y Correquisitos combinada
CREATE TABLE CURSO_RELACIONADO (
    ID_REQUISITO NUMBER PRIMARY KEY,
    ID_CURSO NUMBER,
    ID_CURSO_REQUISITO NUMBER, -- Curso prerrequisito o correquisito 
    TIPO_RELACION VARCHAR2(20) CHECK (TIPO_RELACION IN ('Requisito', 'Correquisito')),
    ID_ESTADO NUMBER(1),
    FOREIGN KEY (ID_CURSO) REFERENCES CURSO(ID_CURSO),
    FOREIGN KEY (ID_CURSO_REQUISITO) REFERENCES CURSO(ID_CURSO),
    FOREIGN KEY (ID_ESTADO) REFERENCES ESTADO(ID_ESTADO)
);

-- Tabla de Usuarios (Estudiantes, Docentes, Administración)
CREATE TABLE USUARIO (
    ID_USUARIO NUMBER PRIMARY KEY,
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
    FOREIGN KEY (ID_ESTADO) REFERENCES ESTADO(ID_ESTADO),
    FOREIGN KEY (ID_DIRECCION) REFERENCES DIRECCION(ID_DIRECCION),
    FOREIGN KEY (ID_ESPECIALIZACION) REFERENCES ESPECIALIZACION_DOCENTE(ID_ESPECIALIZACION)
);

-- Tabla de Dirección
CREATE TABLE DIRECCION (
    ID_DIRECCION NUMBER PRIMARY KEY,
    CALLE VARCHAR2(100),
    NUMERO_CASA VARCHAR2(10),
    OTRAS_SENAS VARCHAR2(100),
    ID_PAIS NUMBER,
    ID_PROVINCIA NUMBER,
    ID_CANTON NUMBER,
    ID_DISTRITO NUMBER,
    ID_ESTADO NUMBER(1),
    FOREIGN KEY (ID_PAIS) REFERENCES PAIS(ID_PAIS),
    FOREIGN KEY (ID_PROVINCIA) REFERENCES PROVINCIA(ID_PROVINCIA),    
    FOREIGN KEY (ID_CANTON) REFERENCES CANTON(ID_CANTON),
    FOREIGN KEY (ID_DISTRITO) REFERENCES DISTRITO(ID_DISTRITO),
    FOREIGN KEY (ID_ESTADO) REFERENCES ESTADO(ID_ESTADO)
);

-- Tabla de País
CREATE TABLE PAIS (
    ID_PAIS NUMBER PRIMARY KEY,
    PAIS VARCHAR2(50) NOT NULL
);

-- Tabla de Provincia
CREATE TABLE PROVINCIA (
    ID_PROVINCIA NUMBER PRIMARY KEY,
    PROVINCIA VARCHAR2(50) NOT NULL
);

-- Tabla de Cantón
CREATE TABLE CANTON (
    ID_CANTON NUMBER PRIMARY KEY,
    CANTON VARCHAR2(50) NOT NULL
);

-- Tabla de Distrito
CREATE TABLE DISTRITO (
    ID_DISTRITO NUMBER PRIMARY KEY,
    DISTRITO VARCHAR2(50) NOT NULL
);


-- Tabla de Horario Matriculado
CREATE TABLE HORARIO_MATRICULADO (
    ID_HORARIO_MATRICULADO NUMBER PRIMARY KEY,
    FECHA_MATRICULA DATE NOT NULL,
    ID_USUARIO NUMBER,
    ID_CURSO NUMBER,
    ID_HORARIO NUMBER,
    ID_ESTADO NUMBER(1),
    FOREIGN KEY (ID_USUARIO) REFERENCES USUARIO(ID_USUARIO),
    FOREIGN KEY (ID_CURSO, ID_HORARIO) REFERENCES CURSO_HORARIO(ID_CURSO, ID_HORARIO),
    FOREIGN KEY (ID_ESTADO) REFERENCES ESTADO(ID_ESTADO)
);

-- Tabla de Plan de Estudios
CREATE TABLE PLAN_ESTUDIOS (
    ID_PLAN_ESTUDIOS NUMBER PRIMARY KEY,
    NOMBRE_CARRERA VARCHAR2(100) NOT NULL,
    ID_ESTADO NUMBER(1),
    FOREIGN KEY (ID_ESTADO) REFERENCES ESTADO(ID_ESTADO)
);

-- Relación Curso-Plan de Estudios
CREATE TABLE CURSOS_PLAN (
    ID_CURSO NUMBER,
    ID_PLAN_ESTUDIOS NUMBER,
    ID_ESTADO NUMBER(1),
    PRIMARY KEY (ID_CURSO, ID_PLAN_ESTUDIOS),
    FOREIGN KEY (ID_CURSO) REFERENCES CURSO(ID_CURSO),
    FOREIGN KEY (ID_PLAN_ESTUDIOS) REFERENCES PLAN_ESTUDIOS(ID_PLAN_ESTUDIOS),
    FOREIGN KEY (ID_ESTADO) REFERENCES ESTADO(ID_ESTADO)
);

-- Tabla de Asignaciones de Docentes a Cursos
CREATE TABLE ASIGNACION_DOCENTE (
    ID_ASIGNACION NUMBER PRIMARY KEY,
    ID_USUARIO NUMBER, -- El docente asignado
    ID_CURSO NUMBER,
    ID_HORARIO NUMBER,
    ID_ESTADO NUMBER(1),
    FOREIGN KEY (ID_USUARIO) REFERENCES USUARIO(ID_USUARIO),
    FOREIGN KEY (ID_CURSO, ID_HORARIO) REFERENCES CURSO_HORARIO(ID_CURSO, ID_HORARIO),
    FOREIGN KEY (ID_ESTADO) REFERENCES ESTADO(ID_ESTADO)
);

-- Tabla de Aulas
CREATE TABLE AULAS (
    ID_AULA NUMBER PRIMARY KEY,
    NOMBRE_AULA VARCHAR2(50) UNIQUE NOT NULL,
    CAPACIDAD NUMBER NOT NULL,
    ID_ESTADO NUMBER(1),
    FOREIGN KEY (ID_ESTADO) REFERENCES ESTADO(ID_ESTADO)
);

-- Relación Curso-Horario-Aula
CREATE TABLE CURSO_AULA (
    ID_CURSO NUMBER,
    ID_HORARIO NUMBER,
    ID_AULA NUMBER,
    ID_ESTADO NUMBER(1),
    PRIMARY KEY (ID_CURSO, ID_HORARIO, ID_AULA),
    FOREIGN KEY (ID_CURSO) REFERENCES CURSO(ID_CURSO),
    FOREIGN KEY (ID_HORARIO) REFERENCES HORARIO(ID_HORARIO),
    FOREIGN KEY (ID_AULA) REFERENCES AULAS(ID_AULA),
    FOREIGN KEY (ID_ESTADO) REFERENCES ESTADO(ID_ESTADO)
);

-- Tabla de Historial Académico
CREATE TABLE HISTORIAL_ACADEMICO (
    ID_HISTORIAL NUMBER PRIMARY KEY,
    ID_USUARIO NUMBER,
    ID_CURSO NUMBER,
    PERIODO VARCHAR2(50),
    ANNO NUMBER,
    OBSERVACIONES VARCHAR2(500),
    CALIFICACION NUMBER CHECK (CALIFICACION BETWEEN 0 AND 100),
    ID_ESTADO NUMBER(1),
    FOREIGN KEY (ID_USUARIO) REFERENCES USUARIO(ID_USUARIO),
    FOREIGN KEY (ID_CURSO) REFERENCES CURSO(ID_CURSO),
    FOREIGN KEY (ID_ESTADO) REFERENCES ESTADO(ID_ESTADO)
);


-- Tabla de Notificaciones
CREATE TABLE NOTIFICACIONES (
    ID_NOTIFICACION NUMBER PRIMARY KEY,
    ID_USUARIO NUMBER,
    MENSAJE VARCHAR2(255),
    FECHA_ENVIO DATE,
    ID_ESTADO NUMBER(1), -- 0 = No leído, 1 = Leído
    FOREIGN KEY (ID_USUARIO) REFERENCES USUARIO(ID_USUARIO),
    FOREIGN KEY (ID_ESTADO) REFERENCES ESTADO(ID_ESTADO)
);

-- Tabla de Especialización de Docentes
CREATE TABLE ESPECIALIZACION_DOCENTE (
    ID_ESPECIALIZACION NUMBER PRIMARY KEY,
    AREA_ESPECIALIZACION VARCHAR2(100),
    ID_ESTADO NUMBER(1),
    FOREIGN KEY (ID_ESTADO) REFERENCES ESTADO(ID_ESTADO)
);