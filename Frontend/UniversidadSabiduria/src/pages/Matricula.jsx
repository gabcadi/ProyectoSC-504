import React, { useEffect, useState, useContext } from "react";
import SidebarNavigation from "../components/SidebarNavigation.jsx";
import axios from "axios";
import { UserContext } from "../hooks/UserContext";

export default function Matricula() {
  const [cursos, setCursos] = useState([]);
  const [cursosMatriculados, setCursosMatriculados] = useState([]);
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(true);
  const [showModal, setShowModal] = useState(false);
  const [showConfirmModal, setShowConfirmModal] = useState(false);
  const [mensaje, setMensaje] = useState("");
  const [cursoToMatricular, setCursoToMatricular] = useState(null);
  const { user } = useContext(UserContext);

  useEffect(() => {
    const fetchCursosDisponibles = async () => {
      try {
        const response = await axios.get('http://localhost:5000/getCursosDisponibles');
        if (Array.isArray(response.data)) {
          setCursos(response.data);
        } else {
          setError('La respuesta del servidor no es un arreglo');
        }
      } catch (err) {
        console.error('Error:', err);
        setError('Error al obtener los cursos disponibles');
      } finally {
        setLoading(false);
      }
    };

    const fetchCursosMatriculados = async () => {
      try {
        const response = await axios.get(`http://localhost:5000/getCursosMatriculados/${user.ID_USUARIO}`);
        if (Array.isArray(response.data)) {
          setCursosMatriculados(response.data.map(curso => curso.ID_CURSO));
        } else {
          setError('La respuesta del servidor no es un arreglo');
        }
      } catch (err) {
        console.error('Error:', err);
        setError('Error al obtener los cursos matriculados');
      }
    };

    fetchCursosDisponibles();
    fetchCursosMatriculados();
  }, [user.ID_USUARIO]);

  const matricularCurso = async () => {
    try {
      await axios.post('http://localhost:5000/matricularCurso', {
        idUsuario: user.ID_USUARIO,
        idCurso: cursoToMatricular.ID_CURSO,
        idHorario: cursoToMatricular.ID_HORARIO
      });
      setMensaje('Matrícula exitosa');
      setShowModal(true);
      setShowConfirmModal(false);
      // Actualizar la lista de cursos después de la matrícula
      setCursos(cursos.map(curso => 
        curso.ID_CURSO === cursoToMatricular.ID_CURSO ? { ...curso, CUPOS: curso.CUPOS - 1 } : curso
      ));
      setCursosMatriculados([...cursosMatriculados, cursoToMatricular.ID_CURSO]);
    } catch (err) {
      console.error('Error:', err);
      setMensaje('Error al matricular el curso');
      setShowModal(true);
      setShowConfirmModal(false);
    }
  };

  const openConfirmModal = (curso) => {
    setCursoToMatricular(curso);
    setShowConfirmModal(true);
  };

  const closeConfirmModal = () => {
    setShowConfirmModal(false);
    setCursoToMatricular(null);
  };

  const closeModal = () => {
    setShowModal(false);
  };

  return (
    <div className="flex">
      <SidebarNavigation className="w-1/4" />
      <div className="w-3/4 p-8">
        <h1 className="text-3xl font-bold mb-6">Matrícula de Cursos</h1>
        {loading && <p>Cargando...</p>}
        {error && <p className="text-red-500">{error}</p>}
        {!loading && !error && (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            {cursos.map((curso) => {
              const isMatriculado = cursosMatriculados.includes(curso.ID_CURSO);
              const isSinCupos = curso.CUPOS <= 0;
              return (
                <div key={curso.ID_CURSO} className="bg-white p-4 rounded-lg shadow-md">
                  <h2 className="text-xl font-bold mb-2">{curso.NOMBRE_CURSO}</h2>
                  <p><strong>Carrera:</strong> {curso.NOMBRE_CARRERA}</p>
                  <p><strong>Créditos:</strong> {curso.CREDITOS}</p>
                  <p><strong>Cupos:</strong> {curso.CUPOS}</p>
                  <p><strong>Horario:</strong> {curso.V_DIA_SEMANA} - {curso.V_TURNO}</p>
                  <p><strong>Aula:</strong> {curso.NOMBRE_AULA || 'No asignada'}</p>
                  <button
                    onClick={() => openConfirmModal(curso)}
                    className={`mt-4 py-2 px-4 rounded ${isMatriculado || isSinCupos ? 'bg-gray-400 cursor-not-allowed' : 'bg-green-500 text-white'}`}
                    disabled={isMatriculado || isSinCupos}
                  >
                    {isMatriculado ? 'Ya Matriculado' : isSinCupos ? 'Sin Cupos' : 'Matricular'}
                  </button>
                </div>
              );
            })}
          </div>
        )}
        {showModal && (
          <div className="fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center">
            <div className="bg-white rounded-lg p-8 w-3/4 max-w-md">
              <h2 className="text-xl font-bold mb-4">Mensaje</h2>
              <p className="mb-4">{mensaje}</p>
              <button
                onClick={closeModal}
                className="mt-4 bg-teal-500 text-white py-2 px-4 rounded"
              >
                Cerrar
              </button>
            </div>
          </div>
        )}
        {showConfirmModal && (
          <div className="fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center">
            <div className="bg-white rounded-lg p-8 w-3/4 max-w-md">
              <h2 className="text-xl font-bold mb-4">Confirmación</h2>
              <p className="mb-4">¿Estás seguro de que deseas matricular este curso?</p>
              <div className="flex justify-end">
                <button
                  onClick={closeConfirmModal}
                  className="mr-4 bg-gray-500 text-white py-2 px-4 rounded"
                >
                  Cancelar
                </button>
                <button
                  onClick={matricularCurso}
                  className="bg-green-500 text-white py-2 px-4 rounded"
                >
                  Matricular
                </button>
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}