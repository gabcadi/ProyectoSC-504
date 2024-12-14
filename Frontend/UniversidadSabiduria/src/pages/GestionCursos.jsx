import React, { useEffect, useState } from "react";
import axios from "axios";
import SidebarNavigation from "../components/SidebarNavigation.jsx";

export default function GestionCursos() {
  const [cursos, setCursos] = useState([]);
  const [selectedCurso, setSelectedCurso] = useState(null);
  const [showModal, setShowModal] = useState(false);
  const [nombre, setNombre] = useState("");
  const [creditos, setCreditos] = useState("");
  const [cupos, setCupos] = useState("");
  const [mensaje, setMensaje] = useState("");

  useEffect(() => {
    const fetchCursos = async () => {
      try {
        const response = await axios.get('http://localhost:5000/getCursosDisponibles');
        if (Array.isArray(response.data)) {
          setCursos(response.data);
        } else {
          setMensaje('La respuesta del servidor no es un arreglo');
        }
      } catch (err) {
        console.error('Error:', err);
        setMensaje('Error al obtener los cursos disponibles');
      }
    };

    fetchCursos();
  }, []);

  const openModal = (curso) => {
    setSelectedCurso(curso);
    setNombre(curso.NOMBRE_CURSO);
    setCreditos(curso.CREDITOS);
    setCupos(curso.CUPOS);
    setShowModal(true);
  };

  const closeModal = () => {
    setShowModal(false);
    setSelectedCurso(null);
  };

  const handleSave = async () => {
    try {
      await axios.post('http://localhost:5000/editarCurso', {
        idCurso: selectedCurso.ID_CURSO,
        nombre,
        creditos,
        cupos
      });
      setMensaje('Curso actualizado exitosamente');
      setShowModal(false);
      // Actualizar la lista de cursos después de la edición
      setCursos(cursos.map(curso => 
        curso.ID_CURSO === selectedCurso.ID_CURSO ? { ...curso, NOMBRE_CURSO: nombre, CREDITOS: creditos, CUPOS: cupos } : curso
      ));
    } catch (err) {
      console.error('Error:', err);
      setMensaje('Error al actualizar el curso');
    }
  };

  return (
    <div className="flex">
      <SidebarNavigation className="w-1/4" />
      <div className="w-3/4 p-8">
        <h1 className="text-3xl font-bold mb-6">Gestión de Cursos</h1>
        {mensaje && <p className="text-red-500">{mensaje}</p>}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {cursos.map((curso) => (
            <div key={curso.ID_CURSO} className="bg-white p-4 rounded-lg shadow-md">
              <h2 className="text-xl font-bold mb-2">{curso.NOMBRE_CURSO}</h2>
              <p><strong>Créditos:</strong> {curso.CREDITOS}</p>
              <p><strong>Cupos:</strong> {curso.CUPOS}</p>
              <button
                onClick={() => openModal(curso)}
                className="mt-4 bg-blue-500 text-white py-2 px-4 rounded"
              >
                Editar
              </button>
            </div>
          ))}
        </div>
        {showModal && (
          <div className="fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center">
            <div className="bg-white rounded-lg p-8 w-3/4 max-w-md">
              <h2 className="text-xl font-bold mb-4">Editar Curso</h2>
              <div className="mb-4">
                <label className="block text-gray-700">Nombre:</label>
                <input
                  type="text"
                  value={nombre}
                  onChange={(e) => setNombre(e.target.value)}
                  className="w-full px-3 py-2 border rounded"
                />
              </div>
              <div className="mb-4">
                <label className="block text-gray-700">Créditos:</label>
                <input
                  type="number"
                  value={creditos}
                  onChange={(e) => setCreditos(e.target.value)}
                  className="w-full px-3 py-2 border rounded"
                />
              </div>
              <div className="mb-4">
                <label className="block text-gray-700">Cupos:</label>
                <input
                  type="number"
                  value={cupos}
                  onChange={(e) => setCupos(e.target.value)}
                  className="w-full px-3 py-2 border rounded"
                />
              </div>
              <div className="flex justify-end">
                <button
                  onClick={closeModal}
                  className="mr-4 bg-gray-500 text-white py-2 px-4 rounded"
                >
                  Cancelar
                </button>
                <button
                  onClick={handleSave}
                  className="bg-blue-500 text-white py-2 px-4 rounded"
                >
                  Guardar
                </button>
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}