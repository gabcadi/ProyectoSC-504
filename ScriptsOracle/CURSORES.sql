/**CURSOR PARA CURSOS DISPONIBLES*******************************/
/*IMPORTANTE: ESTE SELECT SIRVE UNICAMENTE PARA EL ADMINISTRADOR YA QUE APARECEN
TODOS LOS CURSOS QUE ESTEN ACTIVOS*/
CREATE OR REPLACE PROCEDURE obtener_cursos_disponibles_sp IS
    CURSOR cursos_disponibles IS
    SELECT
        *
    FROM
        fide_curso_tb;

BEGIN
    FOR lista_cursos IN cursos_disponibles LOOP
        IF ( lista_cursos.id_estado = 1 ) THEN
            dbms_output.put_line(lista_cursos.nombre);
            dbms_output.put_line(lista_cursos.cupos);
            dbms_output.put_line(lista_cursos.creditos);
        END IF;
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Error: ' || sqlerrm);
END obtener_cursos_disponibles_sp;
/**CURSOR PARA CURSOS MATRICULADOS*******************************/
/*IMPORTANTE: ESTE CURSOR SE UTILIZA UNICAMENTE PARA USUARIOS QUE TENGAN 
ASIGNADOS CURSOS EN LA TABLA HORARIO_MATRICULADO*/
CREATE OR REPLACE PROCEDURE obtener_cursos_matriculados_sp IS

    CURSOR cursos_matriculados IS
    SELECT
        c.*,
        hm.*,
        h.*,
        ca.*,
        a.*
    FROM
        fide_curso_tb               c,
        fide_horario_matriculado_tb hm,
        fide_horario_tb             h,
        fide_curso_aula_tb          ca,
        fide_aulas_tb               a;

BEGIN
    FOR lista_cursos IN cursos_matriculados LOOP
        IF (
            lista_cursos.hm.id_estado = 1
            AND lista_cursos.c.id_curso = lista_cursos.hm_id_curso
        ) THEN
            dbms_output.put_line(lista_cursos.c.nombre);
            dbms_output.put_line(lista_cursos.h.v_dia_semana
                                 || ' '
                                 || lista_cursos_h.v_turno);

            dbms_output.put_line(lista_cursos.c.creditos);
            dbms_output.put_line(lista_cursos.a.nombre_aula);
        END IF;
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Error: ' || sqlerrm);
END obtener_cursos_matriculados_sp;
/**CURSOR PARA VISUALIZAR HISTORIAL DE MATRICULA*******************************/
/*IMPORTANTE: ESTE CURSOR SE UTILIZA UNICAMENTE PARA USUARIOS QUE TENGAN 
ASIGNADOS VALORES EN HISTORIAL_ACADEMICO*/
CREATE OR REPLACE PROCEDURE obtener_historial_academico_sp IS

    CURSOR historial IS
    SELECT
        c.*,
        ha.*,
        u.*
    FROM
        fide_curso_tb               c,
        fide_usuario_tb             u,
        fide_historial_academico_tb ha;

BEGIN
    FOR lista_cursos IN historial LOOP
        IF (
            lista_cursos.ha.id_usuario = lista_cursos.u.id_usuario
            AND lista_cursos.ha.id_curso = lista_cursos.c.id_curso
        ) THEN
            dbms_output.put_line(lista_cursos.c.nombre);
            dbms_output.put_line(lista_cursos.ha.periodo
                                 || ' '
                                 || lista_cursos.ha.anno);

            dbms_output.put_line(lista_cursos.ha.observaciones);
            dbms_output.put_line(lista_cursos.ha.calificacion);
        END IF;
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Error: ' || sqlerrm);
END obtener_historial_academico_sp;
/**CURSOR PARA CURSOS DISPONIBLES*******************************/
/*IMPORTANTE: ESTE SELECT SIRVE UNICAMENTE PARA EL DOCENTE YA QUE APARECEN
TODOS LOS CURSOS QUE ESTEN ACTIVOS Y ASIGNADOS*/
CREATE OR REPLACE PROCEDURE obtener_cursos_disponibles_docente_sp IS
    CURSOR cursos_disponibles_docente IS
    SELECT
        c.*,
        ad.*
    FROM
        fide_curso_tb              c,
        fide_asignacion_docente_tb ad;

BEGIN
    FOR lista_cursos IN cursos_disponibles_docente LOOP
        IF (
            lista_cursos.c.id_estado = 1
            AND lista_cursos.c.id_curso = lista_cursos.ad.id_curso
        ) THEN
            dbms_output.put_line(lista_cursos.c.nombre);
            dbms_output.put_line(lista_cursos.c.cupos);
            dbms_output.put_line(lista_cursos.c.creditos);
        END IF;
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Error: ' || sqlerrm);
END obtener_cursos_disponibles_docente_sp;
/**CURSOR PARA CURSOS DISPONIBLES*******************************/
/*IMPORTANTE: ESTE SELECT SIRVE UNICAMENTE PARA EL ESTUDIANTE YA QUE APARECEN
TODOS LOS CURSOS QUE ESTEN ACTIVOS Y DISPONIBLES PARA MATRICULAR*/
CREATE OR REPLACE PROCEDURE obtener_cursos_disponibles_estudiante_sp IS

    CURSOR cursos_disponibles_estudiante IS
    SELECT
        c.*,
        ca.*,
        u.*,
        a.*
    FROM
        fide_curso_tb      c,
        fide_curso_aula_tb ca,
        fide_usuario_tb    u,
        fide_aulas_tb      a;

BEGIN
    FOR lista_cursos IN cursos_disponibles_estudiante LOOP
        IF (
            lista_cursos.c.id_estado = 1
            AND lista_cursos.c.id_curso = lista_cursos.ch.id_curso
            AND lista_cursos.u.tipo_usuario = 'Estudiante'
            AND lista_cursos.c.id_curso = lista_cursos.ca.id_curso
        ) THEN
            dbms_output.put_line(lista_cursos.c.nombre);
            dbms_output.put_line(lista_cursos.c.cupos);
            dbms_output.put_line(lista_cursos.c.creditos);
            dbms_output.put_line(lista_cursos.a.nombre_aula);
        END IF;
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Error: ' || sqlerrm);
END obtener_cursos_disponibles_estudiante_sp;
/**CURSOR PARA AULAS*******************************/
/*IMPORTANTE: ESTE SELECT SIRVE UNICAMENTE PARA EL ADMINISTRADOR
YA QUE SE MUESTRAN TODAS LAS AULAS CON EL CURSO Y PROFESOR ASIGNADOS*/
CREATE OR REPLACE PROCEDURE obtener_informacion_aulas_sp IS

    CURSOR aulas_disponibles IS
    SELECT
        c.*,
        ca.*,
        u.*,
        a.*,
        ad.*
    FROM
        fide_curso_tb              c,
        fide_asignacion_docente_tb ad,
        fide_curso_aula_tb         ca,
        fide_usuario_tb            u,
        fide_aulas_tb              a;

BEGIN
    FOR lista_aulas IN aulas_disponibles LOOP
        IF (
            lista_aulas.c.id_aula = lista_aulas.a.id_aula
            AND lista_aulas.c.id_curso = lista_aulas.ad.id_curso
        ) THEN
            dbms_output.put_line(lista_aulas.a.nombre_aula);
            dbms_output.put_line(lista_aulas.a.capacidad);
            dbms_output.put_line(lista_aulas.c.nombre);
            IF ( lista_aulas.ad.id_usuario = lista_aulas.u.id_usuario ) THEN
                dbms_output.put_line(lista_aulas.u.nombre);
            END IF;

        END IF;
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Error: ' || sqlerrm);
END obtener_informacion_aulas_sp;
/**CURSOR PARA ESTUDIANTES INSCRITOS EN UN CURSO*******************************/
/*IMPORTANTE: ESTE SELECT SIRVE UNICAMENTE PARA EL DOCENTE CON UN CURSO ASIGNADO
YA QUE SE MUESTRAN TODAS LAS AULAS CON EL CURSO Y PROFESOR ASIGNADOS*/
CREATE OR REPLACE PROCEDURE obtener_informacion_aulas_sp IS

    CURSOR aulas_disponibles IS
    SELECT
        c.*,
        ca.*,
        u.*,
        a.*,
        ad.*
    FROM
        fide_curso_tb              c,
        fide_asignacion_docente_tb ad,
        fide_curso_aula_tb         ca,
        fide_usuario_tb            u,
        fide_aulas_tb              a;

BEGIN
    FOR lista_aulas IN aulas_disponibles LOOP
        IF (
            lista_aulas.c.id_aula = lista_aulas.a.id_aula
            AND lista_aulas.c.id_curso = lista_aulas.ad.id_curso
        ) THEN
            dbms_output.put_line(lista_aulas.a.nombre_aula);
            dbms_output.put_line(lista_aulas.a.capacidad);
            dbms_output.put_line(lista_aulas.c.nombre);
            IF ( lista_aulas.ad.id_usuario = lista_aulas.u.id_usuario ) THEN
                dbms_output.put_line(lista_aulas.u.nombre);
            END IF;

        END IF;
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Error: ' || sqlerrm);
END obtener_informacion_aulas_sp;
/**CURSOR PARA PROFESORES ASIGNADOS A CURSOS*******************************/
CREATE OR REPLACE PROCEDURE obtener_profesores_asignados_sp IS

    CURSOR profesores_asignados IS
    SELECT
        c.nombre AS curso,
        u.nombre AS profesor
    FROM
        fide_curso_tb              c,
        fide_asignacion_docente_tb ad,
        fide_usuario_tb            u
    WHERE
            ad.id_curso = c.id_curso
        AND ad.id_usuario = u.id_usuario
        AND u.tipo_usuario = 'Docente';

BEGIN
    FOR lista_profesores IN profesores_asignados LOOP
        dbms_output.put_line('Curso: ' || lista_profesores.curso);
        dbms_output.put_line('Profesor: ' || lista_profesores.profesor);
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Error: ' || sqlerrm);
END obtener_profesores_asignados_sp;

/**CURSOR PARA ESTUDIANTES INSCRITOS EN UN CURSO ESPECÍFICO*******************************/
CREATE OR REPLACE PROCEDURE obtener_estudiantes_curso_sp (
    p_id_curso NUMBER
) IS

    CURSOR estudiantes_curso IS
    SELECT
        u.nombre AS estudiante,
        c.nombre AS curso
    FROM
        fide_usuario_tb             u,
        fide_horario_matriculado_tb hm,
        fide_curso_tb               c
    WHERE
            u.id_usuario = hm.id_usuario
        AND hm.id_curso = c.id_curso
        AND c.id_curso = p_id_curso;

BEGIN
    FOR lista_estudiantes IN estudiantes_curso LOOP
        dbms_output.put_line('Estudiante: ' || lista_estudiantes.estudiante);
        dbms_output.put_line('Curso: ' || lista_estudiantes.curso);
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Error: ' || sqlerrm);
END obtener_estudiantes_curso_sp;

/**CURSOR PARA HORARIOS DISPONIBLES DE CURSOS*******************************/
CREATE OR REPLACE PROCEDURE obtener_horarios_cursos_sp IS

    CURSOR horarios_cursos IS
    SELECT
        c.nombre       AS curso,
        h.v_dia_semana AS dia,
        h.v_turno      AS turno
    FROM
        fide_curso_tb   c,
        fide_horario_tb h
    WHERE
        c.id_curso = h.id_curso;

BEGIN
    FOR lista_horarios IN horarios_cursos LOOP
        dbms_output.put_line('Curso: ' || lista_horarios.curso);
        dbms_output.put_line('Día: ' || lista_horarios.dia);
        dbms_output.put_line('Turno: ' || lista_horarios.turno);
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Error: ' || sqlerrm);
END obtener_horarios_cursos_sp;

/**CURSOR PARA AULAS Y SU CAPACIDAD*******************************/
CREATE OR REPLACE PROCEDURE obtener_aulas_capacidad_sp IS
    CURSOR aulas_capacidad IS
    SELECT
        a.nombre_aula,
        a.capacidad
    FROM
        fide_aulas_tb a;

BEGIN
    FOR lista_aulas IN aulas_capacidad LOOP
        dbms_output.put_line('Aula: ' || lista_aulas.nombre_aula);
        dbms_output.put_line('Capacidad: ' || lista_aulas.capacidad);
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Error: ' || sqlerrm);
END obtener_aulas_capacidad_sp;

/**CURSOR PARA CURSOS CON MENOS DEL 50% DE CUPOS OCUPADOS*******************************/
CREATE OR REPLACE PROCEDURE obtener_cursos_baja_ocupacion_sp IS

    CURSOR cursos_baja_ocupacion IS
    SELECT
        nombre,
        cupos,
        ( cupos - cupos_disponibles ) AS cupos_ocupados
    FROM
        fide_curso_tb
    WHERE
        ( cupos_disponibles / cupos ) > 0.5;

BEGIN
    FOR lista_cursos IN cursos_baja_ocupacion LOOP
        dbms_output.put_line('Curso: ' || lista_cursos.nombre);
        dbms_output.put_line('Cupos disponibles: ' || lista_cursos.cupos_disponibles);
        dbms_output.put_line('Cupos ocupados: ' || lista_cursos.cupos_ocupados);
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Error: ' || sqlerrm);
END obtener_cursos_baja_ocupacion_sp;

/**CURSOR PARA ESTUDIANTES QUE NO HAN MATRICULADO CURSOS*******************************/
CREATE OR REPLACE PROCEDURE obtener_estudiantes_sin_matricula_sp IS

    CURSOR estudiantes_sin_matricula IS
    SELECT
        u.nombre AS estudiante
    FROM
        fide_usuario_tb u
    WHERE
            u.tipo_usuario = 'Estudiante'
        AND NOT EXISTS (
            SELECT
                1
            FROM
                fide_horario_matriculado_tb hm
            WHERE
                hm.id_usuario = u.id_usuario
        );

BEGIN
    FOR lista_estudiantes IN estudiantes_sin_matricula LOOP
        dbms_output.put_line('Estudiante sin matrícula: ' || lista_estudiantes.estudiante);
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Error: ' || sqlerrm);
END obtener_estudiantes_sin_matricula_sp;

/**CURSOR PARA CURSOS SIN PROFESOR ASIGNADO*******************************/
CREATE OR REPLACE PROCEDURE obtener_cursos_sin_profesor_sp IS

    CURSOR cursos_sin_profesor IS
    SELECT
        c.nombre AS curso
    FROM
        fide_curso_tb c
    WHERE
        NOT EXISTS (
            SELECT
                1
            FROM
                fide_asignacion_docente_tb ad
            WHERE
                ad.id_curso = c.id_curso
        );

BEGIN
    FOR lista_cursos IN cursos_sin_profesor LOOP
        dbms_output.put_line('Curso sin profesor: ' || lista_cursos.curso);
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Error: ' || sqlerrm);
END obtener_cursos_sin_profesor_sp;

/**CURSOR PARA CURSOS CON MÁS DEL 90% DE SUS CUPOS OCUPADOS*******************************/
CREATE OR REPLACE PROCEDURE obtener_cursos_alta_ocupacion_sp IS

    CURSOR cursos_alta_ocupacion IS
    SELECT
        nombre,
        cupos,
        ( cupos - cupos_disponibles ) AS cupos_ocupados
    FROM
        fide_curso_tb
    WHERE
        ( cupos_disponibles / cupos ) <= 0.1;

BEGIN
    FOR lista_cursos IN cursos_alta_ocupacion LOOP
        dbms_output.put_line('Curso: ' || lista_cursos.nombre);
        dbms_output.put_line('Cupos ocupados: ' || lista_cursos.cupos_ocupados);
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Error: ' || sqlerrm);
END obtener_cursos_alta_ocupacion_sp;

/**CURSOR PARA AULAS ASIGNADAS A MÁS DE UN CURSO AL MISMO TIEMPO*******************************/
CREATE OR REPLACE PROCEDURE obtener_aulas_conflictos_sp IS

    CURSOR aulas_conflictos IS
    SELECT
        a.nombre_aula,
        h1.id_curso AS curso1,
        h2.id_curso AS curso2
    FROM
             fide_aulas_tb a
        JOIN fide_horario_tb h1 ON a.id_aula = h1.id_aula
        JOIN fide_horario_tb h2 ON a.id_aula = h2.id_aula
    WHERE
            h1.id_curso <> h2.id_curso
        AND h1.v_dia_semana = h2.v_dia_semana
        AND h1.v_turno = h2.v_turno;

BEGIN
    FOR lista_aulas IN aulas_conflictos LOOP
        dbms_output.put_line('Aula en conflicto: ' || lista_aulas.nombre_aula);
        dbms_output.put_line('Curso 1: ' || lista_aulas.curso1);
        dbms_output.put_line('Curso 2: ' || lista_aulas.curso2);
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Error: ' || sqlerrm);
END obtener_aulas_conflictos_sp;