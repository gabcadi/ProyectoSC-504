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

    -- Funciones relacionadas con docentes
   function fide_usuario_tb_registrar_docente_fn (
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

   function fide_usuario_tb_editar_docente_fn (
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

   function fide_usuario_tb_registrar_docente_fn (
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

   function fide_usuario_tb_editar_docente_fn (
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