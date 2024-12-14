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
  const [mensaje, setMensaje] = useState("");
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

  const matricularCurso = async (idCurso) => {
    try {
      await axios.post('http://localhost:5000/matricularCurso', {
        idUsuario: user.ID_USUARIO,
        idCurso
      });
      setMensaje('Matrícula exitosa');
      setShowModal(true);
      // Actualizar la lista de cursos después de la matrícula
      setCursos(cursos.map(curso => 
        curso.ID_CURSO === idCurso ? { ...curso, CUPOS: curso.CUPOS - 1 } : curso
      ));
      setCursosMatriculados([...cursosMatriculados, idCurso]);
    } catch (err) {
      console.error('Error:', err);
      setMensaje('Error al matricular el curso');
      setShowModal(true);
    }
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
            {cursos.map((curso) => (
              <div key={curso.ID_CURSO} className="bg-white p-4 rounded-lg shadow-md">
                <h2 className="text-xl font-bold mb-2">{curso.NOMBRE_CURSO}</h2>
                <p><strong>Créditos:</strong> {curso.CREDITOS}</p>
                <p><strong>Cupos:</strong> {curso.CUPOS}</p>
                <button
                  onClick={() => matricularCurso(curso.ID_CURSO)}
                  className="mt-4 bg-teal-500 text-white py-2 px-4 rounded"
                  disabled={curso.CUPOS <= 0 || cursosMatriculados.includes(curso.ID_CURSO)}
                >
                  {curso.CUPOS > 0 ? (cursosMatriculados.includes(curso.ID_CURSO) ? 'Ya se encuentra matriculado' : 'Matricular') : 'Sin Cupos'}
                </button>
              </div>
            ))}
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
      </div>
    </div>
  );
}