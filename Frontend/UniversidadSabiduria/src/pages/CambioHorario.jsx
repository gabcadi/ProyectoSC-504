import React, { useEffect, useState, useContext } from "react";
import SidebarNavigation from "../components/SidebarNavigation.jsx";
import axios from "axios";
import { UserContext } from "../hooks/UserContext";

export default function CambioHorario() {
  const [horarios, setHorarios] = useState([]);
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(true);
  const [showModal, setShowModal] = useState(false);
  const [showConfirmModal, setShowConfirmModal] = useState(false);
  const [mensaje, setMensaje] = useState("");
  const [horarioToDelete, setHorarioToDelete] = useState(null);
  const { user } = useContext(UserContext);

  useEffect(() => {
    const fetchHorariosMatriculados = async () => {
      try {
        const response = await axios.get(`http://localhost:5000/getHorariosMatriculados/${user.ID_USUARIO}`);
        if (Array.isArray(response.data)) {
          setHorarios(response.data);
        } else {
          setError('La respuesta del servidor no es un arreglo');
        }
      } catch (err) {
        console.error('Error:', err);
        setError('Error al obtener los horarios matriculados');
      } finally {
        setLoading(false);
      }
    };

    fetchHorariosMatriculados();
  }, [user.ID_USUARIO]);

  const eliminarHorario = async () => {
    try {
      await axios.post('http://localhost:5000/eliminarHorarioMatriculado', {
        idHorarioMatriculado: horarioToDelete.ID_HORARIO_MATRICULADO,
        idCurso: horarioToDelete.ID_CURSO
      });
      setMensaje('Horario eliminado exitosamente');
      setShowModal(true);
      setShowConfirmModal(false);
      // Actualizar la lista de horarios después de la eliminación
      setHorarios(horarios.filter(horario => horario.ID_HORARIO_MATRICULADO !== horarioToDelete.ID_HORARIO_MATRICULADO));
    } catch (err) {
      console.error('Error:', err);
      setMensaje('Error al eliminar el horario');
      setShowModal(true);
      setShowConfirmModal(false);
    }
  };

  const openConfirmModal = (horario) => {
    setHorarioToDelete(horario);
    setShowConfirmModal(true);
  };

  const closeConfirmModal = () => {
    setShowConfirmModal(false);
    setHorarioToDelete(null);
  };

  const closeModal = () => {
    setShowModal(false);
  };

  return (
    <div className="flex">
      <SidebarNavigation className="w-1/4" />
      <div className="w-3/4 p-8">
        <h1 className="text-3xl font-bold mb-6">Cambio de Horario</h1>
        {loading && <p>Cargando...</p>}
        {error && <p className="text-red-500">{error}</p>}
        {!loading && !error && horarios.length === 0 && (
          <p>No tienes horarios matriculados.</p>
        )}
        {!loading && !error && horarios.length > 0 && (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            {horarios.map((horario) => (
              <div key={horario.ID_HORARIO_MATRICULADO} className="bg-white p-4 rounded-lg shadow-md">
                <h2 className="text-xl font-bold mb-2">{horario.NOMBRE_CURSO}</h2>
                <p><strong>Horario:</strong> {horario.V_DIA_SEMANA} - {horario.V_TURNO}</p>
                <p><strong>Aula:</strong> {horario.NOMBRE_AULA || 'No asignada'}</p>
                <button
                  onClick={() => openConfirmModal(horario)}
                  className="mt-4 bg-red-500 text-white py-2 px-4 rounded"
                >
                  Eliminar
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
        {showConfirmModal && (
          <div className="fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center">
            <div className="bg-white rounded-lg p-8 w-3/4 max-w-md">
              <h2 className="text-xl font-bold mb-4">Confirmación</h2>
              <p className="mb-4">¿Estás seguro de que deseas eliminar este horario?</p>
              <div className="flex justify-end">
                <button
                  onClick={closeConfirmModal}
                  className="mr-4 bg-gray-500 text-white py-2 px-4 rounded"
                >
                  Cancelar
                </button>
                <button
                  onClick={eliminarHorario}
                  className="bg-red-500 text-white py-2 px-4 rounded"
                >
                  Eliminar
                </button>
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}