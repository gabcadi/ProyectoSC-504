/*******************************MODIFICACION DE PAQUETE FUNCIONES**************/
CREATE OR REPLACE PACKAGE fide_universidad_sabiduria_pkg_funciones IS
    -- CURSOS
    FUNCTION INSERTAR_CURSO (
        P_NOMBRE IN VARCHAR2,
        P_CREDITOS IN NUMBER,
        P_CUPOS IN NUMBER,
        P_ID_ESTADO IN NUMBER
    ) RETURN NUMBER;

    FUNCTION EDITAR_CURSO (
        P_ID_CURSO IN NUMBER,
        P_NOMBRE IN VARCHAR2,
        P_CREDITOS IN NUMBER,
        P_CUPOS IN NUMBER
    ) RETURN VARCHAR2;

    FUNCTION OCULTAR_CURSO (
        P_ID_CURSO IN NUMBER
    ) RETURN VARCHAR2;

    FUNCTION ELIMINAR_CURSO (
        P_ID_CURSO IN NUMBER
    ) RETURN VARCHAR2;

    FUNCTION CONSULTAR_CURSOS RETURN SYS_REFCURSOR;

    -- USUARIOS
    FUNCTION REGISTRAR_USUARIO (
        P_NOMBRE IN VARCHAR2,
        P_PRIMER_APELLIDO IN VARCHAR2,
        P_SEGUNDO_APELLIDO IN VARCHAR2,
        P_CORREO IN VARCHAR2,
        P_TIPO_USUARIO IN VARCHAR2,
        P_CODIGO_PAIS IN VARCHAR2,
        P_TELEFONO IN VARCHAR2,
        P_ID_DIRECCION IN NUMBER,
        P_ID_ESPECIALIZACION IN NUMBER
    ) RETURN NUMBER;

    FUNCTION EDITAR_USUARIO (
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
    ) RETURN VARCHAR2;

    FUNCTION CAMBIAR_ESTADO_USUARIO (
        P_ID_USUARIO IN NUMBER,
        P_ID_ESTADO IN NUMBER
    ) RETURN VARCHAR2;

    FUNCTION ELIMINAR_USUARIO (
        P_ID_USUARIO IN NUMBER
    ) RETURN VARCHAR2;

    -- AULAS
    FUNCTION AGREGAR_AULA (
        P_NOMBRE_AULA IN VARCHAR2,
        P_CAPACIDAD IN NUMBER,
        P_ID_ESTADO IN NUMBER
    ) RETURN NUMBER;

    FUNCTION CAMBIAR_ESTADO_AULA (
        P_ID_AULA IN NUMBER,
        P_ID_ESTADO IN NUMBER
    ) RETURN VARCHAR2;

    FUNCTION ELIMINAR_AULA (
        P_ID_AULA IN NUMBER
    ) RETURN VARCHAR2;

    -- HORARIOS
    FUNCTION AGREGAR_HORARIO (
        P_DIA_SEMANA IN VARCHAR2,
        P_TURNO IN VARCHAR2,
        P_ID_ESTADO IN NUMBER
    ) RETURN NUMBER;

    FUNCTION EDITAR_HORARIO (
        P_ID_HORARIO IN NUMBER,
        P_DIA_SEMANA IN VARCHAR2,
        P_TURNO IN VARCHAR2,
        P_ID_ESTADO IN NUMBER
    ) RETURN VARCHAR2;

    FUNCTION ELIMINAR_HORARIO (
        P_ID_HORARIO IN NUMBER
    ) RETURN VARCHAR2;


    FUNCTION INSERTAR_HORARIO_MATRICULADO (
        P_ID_USUARIO IN NUMBER,
        P_ID_HORARIO IN NUMBER,
        P_ID_CURSO IN NUMBER
    ) RETURN NUMBER;

    FUNCTION EDITAR_HORARIO_MATRICULADO (
        P_ID_HORARIO_MATRICULADO IN NUMBER,
        P_ID_USUARIO IN NUMBER,
        P_ID_HORARIO IN NUMBER,
        P_ID_CURSO IN NUMBER
    ) RETURN VARCHAR2;
END fide_universidad_sabiduria_pkg_funciones;
/

/******************************************************************************/
CREATE OR REPLACE PACKAGE BODY fide_universidad_sabiduria_pkg_funciones AS

    PROCEDURE INSERTAR_CURSO (
        P_NOMBRE IN VARCHAR2,
        P_CREDITOS IN NUMBER,
        P_CUPOS IN NUMBER,
        P_ID_ESTADO IN NUMBER
    ) IS
    BEGIN
        FIDE_CURSO_TB_INSERTAR_CURSO_FN(P_NOMBRE, P_CREDITOS, P_CUPOS, P_ID_ESTADO);
    END;

    PROCEDURE EDITAR_CURSO (
        P_ID_CURSO IN NUMBER,
        P_NOMBRE IN VARCHAR2,
        P_CREDITOS IN NUMBER,
        P_CUPOS IN NUMBER
    ) IS
    BEGIN
        FIDE_CURSO_TB_EDITAR_CURSO_FN(P_ID_CURSO, P_NOMBRE, P_CREDITOS, P_CUPOS);
    END;

    PROCEDURE CAMBIAR_ESTADO_CURSO (
        P_ID_CURSO IN NUMBER
    ) IS
    BEGIN
        FIDE_CURSO_TB_OCULTAR_CURSO_FN(P_ID_CURSO);
    END;


    PROCEDURE REGISTRAR_USUARIO (
        P_NOMBRE IN VARCHAR2,
        P_PRIMER_APELLIDO IN VARCHAR2,
        P_SEGUNDO_APELLIDO IN VARCHAR2,
        P_CORREO IN VARCHAR2,
        P_TIPO_USUARIO IN VARCHAR2,
        P_CODIGO_PAIS IN VARCHAR2,
        P_TELEFONO IN VARCHAR2,
        P_ID_DIRECCION IN NUMBER,
        P_ID_ESPECIALIZACION IN NUMBER
    ) IS
    BEGIN
        FIDE_USUARIO_TB_REGISTRAR_USUARIO_FN(P_NOMBRE, P_PRIMER_APELLIDO, P_SEGUNDO_APELLIDO, 
                                               P_CORREO, P_TIPO_USUARIO, P_CODIGO_PAIS, 
                                               P_TELEFONO, P_ID_DIRECCION, P_ID_ESPECIALIZACION);
    END;

    PROCEDURE EDITAR_USUARIO (
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
    ) IS
    BEGIN
        FIDE_USUARIO_TB_EDITAR_USUARIO_FN(P_ID_USUARIO, P_NOMBRE, P_PRIMER_APELLIDO, 
                                           P_SEGUNDO_APELLIDO, P_CORREO, P_TIPO_USUARIO, 
                                           P_CODIGO_PAIS, P_TELEFONO, P_ID_DIRECCION, 
                                           P_ID_ESPECIALIZACION);
    END;

    PROCEDURE AGREGAR_AULA (
        P_NOMBRE_AULA IN VARCHAR2,
        P_CAPACIDAD IN NUMBER,
        P_ID_ESTADO IN NUMBER
    ) IS
    BEGIN
        FIDE_AULAS_TB_AGREGAR_AULA_FN(P_NOMBRE_AULA, P_CAPACIDAD, P_ID_ESTADO);
    END;

    PROCEDURE AGREGAR_HORARIO (
        P_DIA_SEMANA IN VARCHAR2,
        P_TURNO IN VARCHAR2,
        P_ID_ESTADO IN NUMBER
    ) IS
    BEGIN
        FIDE_HORARIO_TB_AGREGAR_HORARIO_FN(P_DIA_SEMANA, P_TURNO, P_ID_ESTADO);
    END;

    PROCEDURE EDITAR_HORARIO (
        P_ID_HORARIO IN NUMBER,
        P_DIA_SEMANA IN VARCHAR2,
        P_TURNO IN VARCHAR2,
        P_ID_ESTADO IN NUMBER
    ) IS
    BEGIN
        FIDE_HORARIO_TB_EDITAR_HORARIO_FN(P_ID_HORARIO, P_DIA_SEMANA, P_TURNO, P_ID_ESTADO);
    END;


    PROCEDURE ELIMINAR_CURSO (
        P_ID_CURSO IN NUMBER
    ) IS
    BEGIN
        FIDE_CURSO_TB_ELIMINAR_CURSO_FN(P_ID_CURSO);
    END;

END fide_universidad_sabiduria_pkg_funciones;

/******************************************************************************/


-- Especificación del paquete
create or replace package fide_universidad_sabiduria_pkg_funciones as 
    -- Funciones relacionadas con cursos
   function fide_curso_tb_insertar_curso_fn (
      p_nombre    in varchar2,
      p_creditos  in number,
      p_cupos     in number,
      p_id_estado in number
   ) return number;

   function fide_curso_tb_editar_curso_fn (
      p_id_curso in number,
      p_nombre   in varchar2,
      p_creditos in number,
      p_cupos    in number
   ) return varchar2;

   function fide_curso_tb_ocultar_curso_fn (
      p_id_curso in number
   ) return varchar2;

    -- Funciones relacionadas con usuarios
   function fide_usuario_tb_registrar_usuario_fn (
      p_nombre             in varchar2,
      p_primer_apellido    in varchar2,
      p_segundo_apellido   in varchar2,
      p_correo             in varchar2,
      p_tipo_usuario       in varchar2,
      p_codigo_pais        in varchar2,
      p_telefono           in varchar2,
      p_id_direccion       in number,
      p_id_especializacion in number
   ) return number;

   function fide_usuario_tb_editar_usuario_fn (
      p_id_usuario         in number,
      p_nombre             in varchar2,
      p_primer_apellido    in varchar2,
      p_segundo_apellido   in varchar2,
      p_correo             in varchar2,
      p_tipo_usuario       in varchar2,
      p_codigo_pais        in varchar2,
      p_telefono           in varchar2,
      p_id_direccion       in number,
      p_id_especializacion in number
   ) return varchar2;

    -- Funciones relacionadas con aulas
   function fide_aulas_tb_agregar_aula_fn (
      p_nombre_aula in varchar2,
      p_capacidad   in number,
      p_id_estado   in number
   ) return number;

    -- Funciones relacionadas con horarios
   function fide_horario_tb_agregar_horario_fn (
      p_dia_semana in varchar2,
      p_turno      in varchar2,
      p_id_estado  in number
   ) return number;

   function fide_horario_tb_editar_horario_fn (
      p_id_horario in number,
      p_dia_semana in varchar2,
      p_turno      in varchar2,
      p_id_estado  in number
   ) return varchar2;
end fide_universidad_sabiduria_pkg_funciones;
/

-- Cuerpo del paquete
create or replace package body fide_universidad_sabiduria_pkg_funciones as
   function fide_curso_tb_insertar_curso_fn (
      p_nombre    in varchar2,
      p_creditos  in number,
      p_cupos     in number,
      p_id_estado in number
   ) return number is
      v_id_curso number;
   begin
      insert into fide_curso_tb (
         id_curso,
         nombre,
         creditos,
         cupos,
         id_estado
      ) values ( fide_curso_id_curso_seq.nextval,
                 p_nombre,
                 p_creditos,
                 p_cupos,
                 p_id_estado ) returning id_curso into v_id_curso;

      return v_id_curso;
   end;

   function fide_curso_tb_editar_curso_fn (
      p_id_curso in number,
      p_nombre   in varchar2,
      p_creditos in number,
      p_cupos    in number
   ) return varchar2 is
   begin
      update fide_curso_tb
         set nombre = p_nombre,
             creditos = p_creditos,
             cupos = p_cupos,
             fecha_modificacion = systimestamp
       where id_curso = p_id_curso;

      if sql%rowcount > 0 then
         return 'Curso actualizado exitosamente';
      else
         return 'No se encontró el curso con el ID especificado';
      end if;
   end;

   function fide_curso_tb_ocultar_curso_fn (
      p_id_curso in number
   ) return varchar2 is
   begin
      update fide_curso_tb
         set id_estado = 0,
             fecha_modificacion = systimestamp
       where id_curso = p_id_curso;

      if sql%rowcount > 0 then
         return 'Estado del curso cambiado a INACTIVO (0) exitosamente';
      else
         return 'No se encontró el curso con el ID especificado';
      end if;
   end;

   function fide_usuario_tb_registrar_usuario_fn (
      p_nombre             in varchar2,
      p_primer_apellido    in varchar2,
      p_segundo_apellido   in varchar2,
      p_correo             in varchar2,
      p_tipo_usuario       in varchar2,
      p_codigo_pais        in varchar2,
      p_telefono           in varchar2,
      p_id_direccion       in number,
      p_id_especializacion in number
   ) return number is
      v_id_usuario number;
   begin
      insert into fide_usuario_tb (
         id_usuario,
         nombre,
         primer_apellido,
         segundo_apellido,
         correo,
         tipo_usuario,
         codigo_pais,
         telefono,
         id_direccion,
         id_especializacion
      ) values ( fide_usuario_id_usuario_seq.nextval,
                 p_nombre,
                 p_primer_apellido,
                 p_segundo_apellido,
                 p_correo,
                 p_tipo_usuario,
                 p_codigo_pais,
                 p_telefono,
                 p_id_direccion,
                 p_id_especializacion ) returning id_usuario into v_id_usuario;

      return v_id_usuario;
   end;

   function fide_usuario_tb_editar_usuario_fn (
      p_id_usuario         in number,
      p_nombre             in varchar2,
      p_primer_apellido    in varchar2,
      p_segundo_apellido   in varchar2,
      p_correo             in varchar2,
      p_tipo_usuario       in varchar2,
      p_codigo_pais        in varchar2,
      p_telefono           in varchar2,
      p_id_direccion       in number,
      p_id_especializacion in number
   ) return varchar2 is
   begin
      update fide_usuario_tb
         set nombre = p_nombre,
             primer_apellido = p_primer_apellido,
             segundo_apellido = p_segundo_apellido,
             correo = p_correo,
             tipo_usuario = p_tipo_usuario,
             codigo_pais = p_codigo_pais,
             telefono = p_telefono,
             id_direccion = p_id_direccion,
             id_especializacion = p_id_especializacion,
             fecha_modificacion = systimestamp
       where id_usuario = p_id_usuario;

      if sql%rowcount > 0 then
         return 'Docente actualizado exitosamente';
      else
         return 'No se encontró el docente con el ID especificado';
      end if;
   end;

   function fide_aulas_tb_agregar_aula_fn (
      p_nombre_aula in varchar2,
      p_capacidad   in number,
      p_id_estado   in number
   ) return number is
      v_id_aula number;
   begin
      insert into fide_aulas_tb (
         id_aula,
         nombre_aula,
         capacidad,
         id_estado
      ) values ( fide_aulas_id_aula_seq.nextval,
                 p_nombre_aula,
                 p_capacidad,
                 p_id_estado ) returning id_aula into v_id_aula;

      return v_id_aula;
   end;

   function fide_horario_tb_agregar_horario_fn (
      p_dia_semana in varchar2,
      p_turno      in varchar2,
      p_id_estado  in number
   ) return number is
      v_id_horario number;
   begin
      insert into fide_horario_tb (
         id_horario,
         v_dia_semana,
         v_turno,
         id_estado
      ) values ( fide_horario_id_horario_seq.nextval,
                 p_dia_semana,
                 p_turno,
                 p_id_estado ) returning id_horario into v_id_horario;

      return v_id_horario;
   end;

   function fide_horario_tb_editar_horario_fn (
      p_id_horario in number,
      p_dia_semana in varchar2,
      p_turno      in varchar2,
      p_id_estado  in number
   ) return varchar2 is
   begin
      update fide_horario_tb
         set v_dia_semana = p_dia_semana,
             v_turno = p_turno,
             id_estado = p_id_estado
       where id_horario = p_id_horario;

      if sql%rowcount > 0 then
         return 'Horario actualizado exitosamente';
      else
         return 'No se encontró el horario con el ID especificado';
      end if;
   end;
end fide_universidad_sabiduria_pkg_funciones;
/