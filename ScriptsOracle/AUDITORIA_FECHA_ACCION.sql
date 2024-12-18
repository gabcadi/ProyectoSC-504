/************TRIGGERS AUDITORIA FECHA CREACION/MODIFICACION********************/
/***************TRIGGERS AUDITORIA ACCION*************/
-- Trigger para FIDE_CURSO_TB
CREATE OR REPLACE TRIGGER FIDE_CURSO_TB_CREADO_MOD_CREACION
BEFORE INSERT ON FIDE_CURSO_TB
FOR EACH ROW
BEGIN
    IF INSERTING THEN 
        :NEW.FECHA_CREACION := SYSTIMESTAMP;
    ELSE
        :NEW.FECHA_MODIFICACION := SYSTIMESTAMP;
    END IF;
END;
/

-- Trigger para FIDE_CURSO_TB ACCION
CREATE OR REPLACE TRIGGER FIDE_CURSO_TB_ACCION_TRG
BEFORE INSERT ON FIDE_CURSO_TB
FOR EACH ROW
BEGIN
    IF INSERTING THEN 
        :NEW.ACCION := 'INSERT';
    ELSE
        :NEW.ACCION := 'UPDATE';
    END IF;
END;
/

-- Trigger para FIDE_HORARIO_MATRICULADO_TB
CREATE OR REPLACE TRIGGER FIDE_HORARIO_MATRICULADO_TB_CREADO_MOD_CREACION
BEFORE INSERT ON FIDE_HORARIO_MATRICULADO_TB
FOR EACH ROW
BEGIN
    IF INSERTING THEN 
        :NEW.FECHA_CREACION := SYSTIMESTAMP;
    ELSE
        :NEW.FECHA_MODIFICACION := SYSTIMESTAMP;
    END IF;
END;
/

-- Trigger para FIDE_HORARIO_MATRICULADO_TB ACCION
CREATE OR REPLACE TRIGGER FIDE_HORARIO_MATRICULADO_TB_ACCION_TRG
BEFORE INSERT ON FIDE_HORARIO_MATRICULADO_TB
FOR EACH ROW
BEGIN
    IF INSERTING THEN 
        :NEW.ACCION := 'INSERT';
    ELSE
        :NEW.ACCION := 'UPDATE';
    END IF;
END;
/

-- Trigger para FIDE_ESPECIALIZACION_DOCENTE_TB
CREATE OR REPLACE TRIGGER FIDE_ESPECIALIZACION_DOCENTE_TB_CREADO_MOD_CREACION
BEFORE INSERT ON FIDE_ESPECIALIZACION_DOCENTE_TB
FOR EACH ROW
BEGIN
    IF INSERTING THEN 
        :NEW.FECHA_CREACION := SYSTIMESTAMP;
    ELSE
        :NEW.FECHA_MODIFICACION := SYSTIMESTAMP;
    END IF;
END;
/

-- Trigger para FIDE_HORARIO_MATRICULADO_TB ACCION
CREATE OR REPLACE TRIGGER FIDE_ESPECIALIZACION_DOCENTE_TB_ACCION_TRG
BEFORE INSERT ON FIDE_ESPECIALIZACION_DOCENTE_TB
FOR EACH ROW
BEGIN
    IF INSERTING THEN 
        :NEW.ACCION := 'INSERT';
    ELSE
        :NEW.ACCION := 'UPDATE';
    END IF;
END;
/

-- Trigger para FIDE_ASIGNACION_DOCENTE_TB
CREATE OR REPLACE TRIGGER FIDE_ASIGNACION_DOCENTE_TB_CREADO_MOD_CREACION
BEFORE INSERT ON FIDE_ASIGNACION_DOCENTE_TB
FOR EACH ROW
BEGIN
    IF INSERTING THEN 
        :NEW.FECHA_CREACION := SYSTIMESTAMP;
    ELSE
        :NEW.FECHA_MODIFICACION := SYSTIMESTAMP;
    END IF;
END;
/

-- Trigger para FIDE_HORARIO_MATRICULADO_TB ACCION
CREATE OR REPLACE TRIGGER FIDE_ASIGNACION_DOCENTE_TB_ACCION_TRG
BEFORE INSERT ON FIDE_ASIGNACION_DOCENTE_TB
FOR EACH ROW
BEGIN
    IF INSERTING THEN 
        :NEW.ACCION := 'INSERT';
    ELSE
        :NEW.ACCION := 'UPDATE';
    END IF;
END;
/

-- Trigger para FIDE_AULAS_TB
CREATE OR REPLACE TRIGGER FIDE_HORARIO_MATRICULADO_TB_CREADO_MOD_CREACION
BEFORE INSERT ON FIDE_HORARIO_MATRICULADO_TB
FOR EACH ROW
BEGIN
    IF INSERTING THEN 
        :NEW.FECHA_CREACION := SYSTIMESTAMP;
    ELSE
        :NEW.FECHA_MODIFICACION := SYSTIMESTAMP;
    END IF;
END;
/

-- Trigger para FIDE_HORARIO_MATRICULADO_TB ACCION
CREATE OR REPLACE TRIGGER FIDE_HORARIO_MATRICULADO_TB_ACCION_TRG
BEFORE INSERT ON FIDE_HORARIO_MATRICULADO_TB
FOR EACH ROW
BEGIN
    IF INSERTING THEN 
        :NEW.ACCION := 'INSERT';
    ELSE
        :NEW.ACCION := 'UPDATE';
    END IF;
END;
/


-- Trigger para FIDE_HORARIO_TB
CREATE OR REPLACE TRIGGER FIDE_HORARIO_TB_CREADO_MOD_CREACION
BEFORE INSERT ON FIDE_HORARIO_TB
FOR EACH ROW
BEGIN
    IF INSERTING THEN 
        :NEW.FECHA_CREACION := SYSTIMESTAMP;
    ELSE
        :NEW.FECHA_MODIFICACION := SYSTIMESTAMP;
    END IF;
END;
/

-- Trigger para FIDE_HORARIO_TB ACCION
CREATE OR REPLACE TRIGGER FIDE_HORARIO_TB_ACCION_TRG
BEFORE INSERT ON FIDE_HORARIO_TB
FOR EACH ROW
BEGIN
    IF INSERTING THEN 
        :NEW.ACCION := 'INSERT';
    ELSE
        :NEW.ACCION := 'UPDATE';
    END IF;
END;
/

-- Trigger para FIDE_CURSO_RELACIONADO_TB
CREATE OR REPLACE TRIGGER FIDE_CURSO_RELACIONADO_TB_CREADO_MOD_CREACION
BEFORE INSERT ON FIDE_CURSO_RELACIONADO_TB
FOR EACH ROW
BEGIN
    IF INSERTING THEN 
        :NEW.FECHA_CREACION := SYSTIMESTAMP;
    ELSE
        :NEW.FECHA_MODIFICACION := SYSTIMESTAMP;
    END IF;
END;
/

-- Trigger para FIDE_CURSO_RELACIONADO_TB ACCION
CREATE OR REPLACE TRIGGER FIDE_CURSO_RELACIONADO_TB_ACCION_TRG
BEFORE INSERT ON FIDE_CURSO_RELACIONADO_TB
FOR EACH ROW
BEGIN
    IF INSERTING THEN 
        :NEW.ACCION := 'INSERT';
    ELSE
        :NEW.ACCION := 'UPDATE';
    END IF;
END;
/

-- Trigger para FIDE_USUARIO_TB
CREATE OR REPLACE TRIGGER FIDE_USUARIO_TB_CREADO_MOD_CREACION
BEFORE INSERT ON FIDE_USUARIO_TB
FOR EACH ROW
BEGIN
    IF INSERTING THEN 
        :NEW.FECHA_CREACION := SYSTIMESTAMP;
    ELSE
        :NEW.FECHA_MODIFICACION := SYSTIMESTAMP;
    END IF;
END;
/

-- Trigger para FIDE_USUARIO_TB ACCION
CREATE OR REPLACE TRIGGER FIDE_USUARIO_TB_ACCION_TRG
BEFORE INSERT ON FIDE_USUARIO_TB
FOR EACH ROW
BEGIN
    IF INSERTING THEN 
        :NEW.ACCION := 'INSERT';
    ELSE
        :NEW.ACCION := 'UPDATE';
    END IF;
END;
/

-- Trigger para FIDE_DIRECCION_TB
CREATE OR REPLACE TRIGGER FIDE_DIRECCION_TB_CREADO_MOD_CREACION
BEFORE INSERT ON FIDE_DIRECCION_TB
FOR EACH ROW
BEGIN
    IF INSERTING THEN 
        :NEW.FECHA_CREACION := SYSTIMESTAMP;
    ELSE
        :NEW.FECHA_MODIFICACION := SYSTIMESTAMP;
    END IF;
END;
/

-- Trigger para FIDE_DIRECCION_TB ACCION
CREATE OR REPLACE TRIGGER FIDE_DIRECCION_TB_ACCION_TRG
BEFORE INSERT ON FIDE_DIRECCION_TB
FOR EACH ROW
BEGIN
    IF INSERTING THEN 
        :NEW.ACCION := 'INSERT';
    ELSE
        :NEW.ACCION := 'UPDATE';
    END IF;
END;
/

-- Trigger para FIDE_PAIS_TB
CREATE OR REPLACE TRIGGER FIDE_PAIS_TB_CREADO_MOD_CREACION
BEFORE INSERT ON FIDE_PAIS_TB
FOR EACH ROW
BEGIN
    IF INSERTING THEN 
        :NEW.FECHA_CREACION := SYSTIMESTAMP;
    ELSE
        :NEW.FECHA_MODIFICACION := SYSTIMESTAMP;
    END IF;
END;
/

-- Trigger para FIDE_PAIS_TB ACCION
CREATE OR REPLACE TRIGGER FIDE_PAIS_TB_ACCION_TRG
BEFORE INSERT ON FIDE_PAIS_TB
FOR EACH ROW
BEGIN
    IF INSERTING THEN 
        :NEW.ACCION := 'INSERT';
    ELSE
        :NEW.ACCION := 'UPDATE';
    END IF;
END;
/

-- Trigger para FIDE_PROVINCIA_TB
CREATE OR REPLACE TRIGGER FIDE_PROVINCIA_TB_CREADO_MOD_CREACION
BEFORE INSERT ON FIDE_PROVINCIA_TB
FOR EACH ROW
BEGIN
    IF INSERTING THEN 
        :NEW.FECHA_CREACION := SYSTIMESTAMP;
    ELSE
        :NEW.FECHA_MODIFICACION := SYSTIMESTAMP;
    END IF;
END;
/

-- Trigger para FIDE_PROVINCIA_TB ACCION
CREATE OR REPLACE TRIGGER FIDE_PROVINCIA_TB_ACCION_TRG
BEFORE INSERT ON FIDE_PROVINCIA_TB
FOR EACH ROW
BEGIN
    IF INSERTING THEN 
        :NEW.ACCION := 'INSERT';
    ELSE
        :NEW.ACCION := 'UPDATE';
    END IF;
END;
/

-- Trigger para FIDE_CANTON_TB
CREATE OR REPLACE TRIGGER FIDE_CANTON_TB_CREADO_MOD_CREACION
BEFORE INSERT ON FIDE_CANTON_TB
FOR EACH ROW
BEGIN
    IF INSERTING THEN 
        :NEW.FECHA_CREACION := SYSTIMESTAMP;
    ELSE
        :NEW.FECHA_MODIFICACION := SYSTIMESTAMP;
    END IF;
END;
/

-- Trigger para FIDE_CANTON_TB ACCION
CREATE OR REPLACE TRIGGER FIDE_CANTON_TB_ACCION_TRG
BEFORE INSERT ON FIDE_CANTON_TB
FOR EACH ROW
BEGIN
    IF INSERTING THEN 
        :NEW.ACCION := 'INSERT';
    ELSE
        :NEW.ACCION := 'UPDATE';
    END IF;
END;
/

-- Trigger para FIDE_DISTRITO_TB
CREATE OR REPLACE TRIGGER FIDE_DISTRITO_TB_CREADO_MOD_CREACION
BEFORE INSERT ON FIDE_DISTRITO_TB
FOR EACH ROW
BEGIN
    IF INSERTING THEN 
        :NEW.FECHA_CREACION := SYSTIMESTAMP;
    ELSE
        :NEW.FECHA_MODIFICACION := SYSTIMESTAMP;
    END IF;
END;
/

-- Trigger para FIDE_DISTRITO_TB ACCION
CREATE OR REPLACE TRIGGER FIDE_DISTRITO_TB_ACCION_TRG
BEFORE INSERT ON FIDE_DISTRITO_TB
FOR EACH ROW
BEGIN
    IF INSERTING THEN 
        :NEW.ACCION := 'INSERT';
    ELSE
        :NEW.ACCION := 'UPDATE';
    END IF;
END;
/