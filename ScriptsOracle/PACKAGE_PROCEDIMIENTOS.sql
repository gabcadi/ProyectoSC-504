/******************************************************************************/
/******************************MODIFICACION PAQUETES***************************/
CREATE OR REPLACE PACKAGE fide_universidad_sabiduria_pkg_procedimientos AS
    -- Cursos
    PROCEDURE insertar_curso(
        p_nombre IN VARCHAR2,
        p_creditos IN NUMBER,
        p_cupos IN NUMBER,
        p_id_estado IN NUMBER,
        p_id_curso OUT NUMBER
    );

    PROCEDURE editar_curso(
        p_id_curso IN NUMBER,
        p_nombre IN VARCHAR2,
        p_creditos IN NUMBER,
        p_cupos IN NUMBER,
        p_resultado OUT VARCHAR2
    );

    PROCEDURE cambiar_estado_curso(
        p_id_curso IN NUMBER,
        p_resultado OUT VARCHAR2
    );

    PROCEDURE consultar_cursos_disponibles(
        p_resultados OUT SYS_REFCURSOR
    );

    -- Usuarios
    PROCEDURE registrar_usuario(
        p_nombre IN VARCHAR2,
        p_primer_apellido IN VARCHAR2,
        p_segundo_apellido IN VARCHAR2,
        p_correo IN VARCHAR2,
        p_tipo_usuario IN VARCHAR2,
        p_codigo_pais IN VARCHAR2,
        p_telefono IN VARCHAR2,
        p_id_direccion IN NUMBER,
        p_id_especializacion IN NUMBER,
        p_id_usuario OUT NUMBER
    );

    PROCEDURE editar_usuario(
        p_id_usuario IN NUMBER,
        p_nombre IN VARCHAR2,
        p_primer_apellido IN VARCHAR2,
        p_segundo_apellido IN VARCHAR2,
        p_correo IN VARCHAR2,
        p_tipo_usuario IN VARCHAR2,
        p_codigo_pais IN VARCHAR2,
        p_telefono IN VARCHAR2,
        p_id_direccion IN NUMBER,
        p_id_especializacion IN NUMBER,
        p_resultado OUT VARCHAR2
    );

    PROCEDURE eliminar_usuario(
        p_id_usuario IN NUMBER,
        p_resultado OUT VARCHAR2
    );

    -- Aulas
    PROCEDURE agregar_aula(
        p_nombre_aula IN VARCHAR2,
        p_capacidad IN NUMBER,
        p_id_estado IN NUMBER,
        p_id_aula OUT NUMBER
    );

    -- Horarios
    PROCEDURE agregar_horario(
        p_dia_semana IN VARCHAR2,
        p_turno IN VARCHAR2,
        p_id_estado IN NUMBER,
        p_id_horario OUT NUMBER
    );

    PROCEDURE editar_horario(
        p_id_horario IN NUMBER,
        p_dia_semana IN VARCHAR2,
        p_turno IN VARCHAR2,
        p_id_estado IN NUMBER,
        p_resultado OUT VARCHAR2
    );

    PROCEDURE eliminar_horario(
        p_id_horario IN NUMBER,
        p_resultado OUT VARCHAR2
    );

    PROCEDURE consultar_horarios(
        p_resultados OUT SYS_REFCURSOR
    );
    

    

END fide_universidad_sabiduria_pkg_procedimientos;
/
/******************************************************************************/
CREATE OR REPLACE PACKAGE BODY fide_universidad_sabiduria_pkg_procedimientos AS
    PROCEDURE insertar_curso(
        p_nombre IN VARCHAR2,
        p_creditos IN NUMBER,
        p_cupos IN NUMBER,
        p_id_estado IN NUMBER,
        p_id_curso OUT NUMBER
    ) IS
    BEGIN
        p_id_curso := fide_curso_tb_insertar_curso_fn(
            p_nombre, 
            p_creditos, 
            p_cupos, 
            p_id_estado
        );
    END insertar_curso;

    PROCEDURE editar_curso(
        p_id_curso IN NUMBER,
        p_nombre IN VARCHAR2,
        p_creditos IN NUMBER,
        p_cupos IN NUMBER,
        p_resultado OUT VARCHAR2
    ) IS
    BEGIN
        p_resultado := fide_curso_tb_editar_curso_fn(
            p_id_curso, 
            p_nombre, 
            p_creditos, 
            p_cupos
        );
    END editar_curso;

    PROCEDURE cambiar_estado_curso(
        p_id_curso IN NUMBER,
        p_resultado OUT VARCHAR2
    ) IS
    BEGIN
        p_resultado := fide_curso_tb_ocultar_curso_fn(p_id_curso);
    END cambiar_estado_curso;

    PROCEDURE consultar_cursos_disponibles(
        p_resultados OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN p_resultados FOR
        SELECT id_curso, nombre, creditos, cupos
        FROM fide_curso_tb
        WHERE id_estado = 1;
    END consultar_cursos_disponibles;

    PROCEDURE registrar_usuario(
        p_nombre IN VARCHAR2,
        p_primer_apellido IN VARCHAR2,
        p_segundo_apellido IN VARCHAR2,
        p_correo IN VARCHAR2,
        p_tipo_usuario IN VARCHAR2,
        p_codigo_pais IN VARCHAR2,
        p_telefono IN VARCHAR2,
        p_id_direccion IN NUMBER,
        p_id_especializacion IN NUMBER,
        p_id_usuario OUT NUMBER
    ) IS
    BEGIN
        p_id_usuario := fide_usuario_tb_registrar_usuario_fn(
            p_nombre, 
            p_primer_apellido, 
            p_segundo_apellido, 
            p_correo, 
            p_tipo_usuario, 
            p_codigo_pais, 
            p_telefono, 
            p_id_direccion, 
            p_id_especializacion
        );
    END registrar_usuario;

    PROCEDURE editar_usuario(
        p_id_usuario IN NUMBER,
        p_nombre IN VARCHAR2,
        p_primer_apellido IN VARCHAR2,
        p_segundo_apellido IN VARCHAR2,
        p_correo IN VARCHAR2,
        p_tipo_usuario IN VARCHAR2,
        p_codigo_pais IN VARCHAR2,
        p_telefono IN VARCHAR2,
        p_id_direccion IN NUMBER,
        p_id_especializacion IN NUMBER,
        p_resultado OUT VARCHAR2
    ) IS
    BEGIN
        p_resultado := fide_usuario_tb_editar_usuario_fn(
            p_id_usuario, 
            p_nombre, 
            p_primer_apellido, 
            p_segundo_apellido, 
            p_correo, 
            p_tipo_usuario, 
            p_codigo_pais, 
            p_telefono, 
            p_id_direccion, 
            p_id_especializacion
        );
    END editar_usuario;

    -- CURSOS
    PROCEDURE insertar_curso(
        p_nombre IN VARCHAR2,
        p_creditos IN NUMBER,
        p_cupos IN NUMBER,
        p_id_estado IN NUMBER,
        p_id_curso OUT NUMBER
    ) IS
    BEGIN
        p_id_curso := fide_curso_tb_insertar_curso_fn(
            p_nombre, 
            p_creditos, 
            p_cupos, 
            p_id_estado
        );
    END insertar_curso;

    PROCEDURE editar_curso(
        p_id_curso IN NUMBER,
        p_nombre IN VARCHAR2,
        p_creditos IN NUMBER,
        p_cupos IN NUMBER,
        p_resultado OUT VARCHAR2
    ) IS
    BEGIN
        p_resultado := fide_curso_tb_editar_curso_fn(
            p_id_curso, 
            p_nombre, 
            p_creditos, 
            p_cupos
        );
    END editar_curso;

    PROCEDURE cambiar_estado_curso(
        p_id_curso IN NUMBER,
        p_resultado OUT VARCHAR2
    ) IS
    BEGIN
        p_resultado := fide_curso_tb_ocultar_curso_fn(p_id_curso);
    END cambiar_estado_curso;

    PROCEDURE consultar_cursos_disponibles(
        p_resultados OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN p_resultados FOR
        SELECT id_curso, nombre, creditos, cupos
        FROM fide_curso_tb
        WHERE id_estado = 1;
    END consultar_cursos_disponibles;

    -- USUARIOS
    PROCEDURE registrar_usuario(
        p_nombre IN VARCHAR2,
        p_primer_apellido IN VARCHAR2,
        p_segundo_apellido IN VARCHAR2,
        p_correo IN VARCHAR2,
        p_tipo_usuario IN VARCHAR2,
        p_codigo_pais IN VARCHAR2,
        p_telefono IN VARCHAR2,
        p_id_direccion IN NUMBER,
        p_id_especializacion IN NUMBER,
        p_id_usuario OUT NUMBER
    ) IS
    BEGIN
        p_id_usuario := fide_usuario_tb_registrar_usuario_fn(
            p_nombre, 
            p_primer_apellido, 
            p_segundo_apellido, 
            p_correo, 
            p_tipo_usuario, 
            p_codigo_pais, 
            p_telefono, 
            p_id_direccion, 
            p_id_especializacion
        );
    END registrar_usuario;

    PROCEDURE editar_usuario(
        p_id_usuario IN NUMBER,
        p_nombre IN VARCHAR2,
        p_primer_apellido IN VARCHAR2,
        p_segundo_apellido IN VARCHAR2,
        p_correo IN VARCHAR2,
        p_tipo_usuario IN VARCHAR2,
        p_codigo_pais IN VARCHAR2,
        p_telefono IN VARCHAR2,
        p_id_direccion IN NUMBER,
        p_id_especializacion IN NUMBER,
        p_resultado OUT VARCHAR2
    ) IS
    BEGIN
        p_resultado := fide_usuario_tb_editar_usuario_fn(
            p_id_usuario, 
            p_nombre, 
            p_primer_apellido, 
            p_segundo_apellido, 
            p_correo, 
            p_tipo_usuario, 
            p_codigo_pais, 
            p_telefono, 
            p_id_direccion, 
            p_id_especializacion
        );
    END editar_usuario;

    PROCEDURE eliminar_usuario(
        p_id_usuario IN NUMBER,
        p_resultado OUT VARCHAR2
    ) IS
    BEGIN
        p_resultado := fide_usuario_tb_eliminar_usuario_fn(p_id_usuario);
    END eliminar_usuario;

    -- AULAS
    PROCEDURE agregar_aula(
        p_nombre_aula IN VARCHAR2,
        p_capacidad IN NUMBER,
        p_id_estado IN NUMBER,
        p_id_aula OUT NUMBER
    ) IS
    BEGIN
        p_id_aula := fide_aula_tb_agregar_aula_fn(
            p_nombre_aula, 
            p_capacidad, 
            p_id_estado
        );
    END agregar_aula;

    -- HORARIOS
    PROCEDURE agregar_horario(
        p_dia_semana IN VARCHAR2,
        p_turno IN VARCHAR2,
        p_id_estado IN NUMBER,
        p_id_horario OUT NUMBER
    ) IS
    BEGIN
        p_id_horario := fide_horario_tb_agregar_horario_fn(
            p_dia_semana, 
            p_turno, 
            p_id_estado
        );
    END agregar_horario;

    PROCEDURE editar_horario(
        p_id_horario IN NUMBER,
        p_dia_semana IN VARCHAR2,
        p_turno IN VARCHAR2,
        p_id_estado IN NUMBER,
        p_resultado OUT VARCHAR2
    ) IS
    BEGIN
        p_resultado := fide_horario_tb_editar_horario_fn(
            p_id_horario, 
            p_dia_semana, 
            p_turno, 
            p_id_estado
        );
    END editar_horario;

    PROCEDURE eliminar_horario(
        p_id_horario IN NUMBER,
        p_resultado OUT VARCHAR2
    ) IS
    BEGIN
        p_resultado := fide_horario_tb_eliminar_horario_fn(p_id_horario);
    END eliminar_horario;

    PROCEDURE consultar_horarios(
        p_resultados OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN p_resultados FOR
        SELECT id_horario, dia_semana, turno, id_estado
        FROM fide_horario_tb;
    END consultar_horarios;

END fide_universidad_sabiduria_pkg_procedimientos;
/


/******************************************************************************/

create or replace package fide_universidad_sabiduria_pkg_procedimientos is
    -- CURSOS
   procedure fide_curso_tb_insertar_curso_sp (
      p_nombre    in varchar2,
      p_creditos  in number,
      p_cupos     in number,
      p_id_estado in number,
      p_id_curso  out number
   );

   procedure fide_curso_tb_editar_curso_sp (
      p_id_curso  in number,
      p_nombre    in varchar2,
      p_creditos  in number,
      p_cupos     in number,
      p_resultado out varchar2
   );

   procedure fide_curso_tb_cambiar_estado_curso_sp (
      p_id_curso  in number,
      p_resultado out varchar2
   );

    -- DOCENTES
   procedure fide_usuario_tb_registrar_docente_sp (
      p_nombre             in varchar2,
      p_primer_apellido    in varchar2,
      p_segundo_apellido   in varchar2,
      p_correo             in varchar2,
      p_tipo_usuario       in varchar2,
      p_codigo_pais        in varchar2,
      p_telefono           in varchar2,
      p_id_direccion       in number,
      p_id_especializacion in number,
      p_id_usuario         out number
   );

   procedure fide_usuario_tb_editar_docente_sp (
      p_id_usuario         in number,
      p_nombre             in varchar2,
      p_primer_apellido    in varchar2,
      p_segundo_apellido   in varchar2,
      p_correo             in varchar2,
      p_tipo_usuario       in varchar2,
      p_codigo_pais        in varchar2,
      p_telefono           in varchar2,
      p_id_direccion       in number,
      p_id_especializacion in number,
      p_resultado          out varchar2
   );

    -- AULAS
   procedure fide_aulas_tb_agregar_aula_sp (
      p_nombre_aula in varchar2,
      p_capacidad   in number,
      p_id_estado   in number,
      p_id_aula     out number
   );

    -- HORARIOS
   procedure fide_horario_tb_agregar_horario_sp (
      p_dia_semana in varchar2,
      p_turno      in varchar2,
      p_id_estado  in number,
      p_id_horario out number
   );

   procedure fide_horario_tb_editar_horario_sp (
      p_id_horario in number,
      p_dia_semana in varchar2,
      p_turno      in varchar2,
      p_id_estado  in number,
      p_resultado  out varchar2
   );
end fide_universidad_sabiduria_pkg_procedimientos;
/

create or replace package body fide_universidad_sabiduria_pkg_procedimientos is
    -- CURSOS
   procedure fide_curso_tb_insertar_curso_sp (
      p_nombre    in varchar2,
      p_creditos  in number,
      p_cupos     in number,
      p_id_estado in number,
      p_id_curso  out number
   ) is
   begin
      p_id_curso := fide_insertar_curso(
         p_nombre,
         p_creditos,
         p_cupos,
         p_id_estado
      );
   end;

   procedure fide_curso_tb_editar_curso_sp (
      p_id_curso  in number,
      p_nombre    in varchar2,
      p_creditos  in number,
      p_cupos     in number,
      p_resultado out varchar2
   ) is
   begin
      p_resultado := fide_editar_curso(
         p_id_curso,
         p_nombre,
         p_creditos,
         p_cupos
      );
   end;

   procedure fide_curso_tb_cambiar_estado_curso_sp (
      p_id_curso  in number,
      p_resultado out varchar2
   ) is
   begin
      p_resultado := fide_cambiar_estado_cursos(p_id_curso);
   end;

    -- DOCENTES
   procedure fide_usuario_tb_registrar_docente_sp (
      p_nombre             in varchar2,
      p_primer_apellido    in varchar2,
      p_segundo_apellido   in varchar2,
      p_correo             in varchar2,
      p_tipo_usuario       in varchar2,
      p_codigo_pais        in varchar2,
      p_telefono           in varchar2,
      p_id_direccion       in number,
      p_id_especializacion in number,
      p_id_usuario         out number
   ) is
   begin
      p_id_usuario := fide_registrar_docente(
         p_nombre,
         p_primer_apellido,
         p_segundo_apellido,
         p_correo,
         p_tipo_usuario,
         p_codigo_pais,
         p_telefono,
         p_id_direccion,
         p_id_especializacion
      );
   end;

   procedure fide_usuario_tb_editar_docente_sp (
      p_id_usuario         in number,
      p_nombre             in varchar2,
      p_primer_apellido    in varchar2,
      p_segundo_apellido   in varchar2,
      p_correo             in varchar2,
      p_tipo_usuario       in varchar2,
      p_codigo_pais        in varchar2,
      p_telefono           in varchar2,
      p_id_direccion       in number,
      p_id_especializacion in number,
      p_resultado          out varchar2
   ) is
   begin
      p_resultado := fide_editar_docente(
         p_id_usuario,
         p_nombre,
         p_primer_apellido,
         p_segundo_apellido,
         p_correo,
         p_tipo_usuario,
         p_codigo_pais,
         p_telefono,
         p_id_direccion,
         p_id_especializacion
      );
   end;

    -- AULAS
   procedure fide_aulas_tb_agregar_aula_sp (
      p_nombre_aula in varchar2,
      p_capacidad   in number,
      p_id_estado   in number,
      p_id_aula     out number
   ) is
   begin
      p_id_aula := fide_aulas_tb_agregar_fn(
         p_nombre_aula,
         p_capacidad,
         p_id_estado
      );
   end;

    -- HORARIOS
   procedure fide_horario_tb_agregar_horario_sp (
      p_dia_semana in varchar2,
      p_turno      in varchar2,
      p_id_estado  in number,
      p_id_horario out number
   ) is
   begin
      p_id_horario := fide_horario_tb_agregar_fn(
         p_dia_semana,
         p_turno,
         p_id_estado
      );
   end;

   procedure fide_horario_tb_editar_horario_sp (
      p_id_horario in number,
      p_dia_semana in varchar2,
      p_turno      in varchar2,
      p_id_estado  in number,
      p_resultado  out varchar2
   ) is
   begin
      p_resultado := fide_horario_tb_editar_fn(
         p_id_horario,
         p_dia_semana,
         p_turno,
         p_id_estado
      );
   end;
end fide_universidad_sabiduria_pkg_procedimientos;
/