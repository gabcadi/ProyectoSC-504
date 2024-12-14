import React, { useEffect, useState } from "react";
import SidebarNavigation from "../components/SidebarNavigation.jsx";
import axios from "axios";

export default function PlanEstudios() {
  const [plan, setPlan] = useState([]);
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(true);
  const [selectedCarrera, setSelectedCarrera] = useState(null);
  const [isModalVisible, setIsModalVisible] = useState(false);

  useEffect(() => {
    const fetchPlanEstudios = async () => {
      try {
        const response = await axios.get('http://localhost:5000/getPlanEstudios');
        setPlan(response.data);
      } catch (err) {
        console.error('Error:', err);
        setError('Error al obtener el plan de estudios');
      } finally {
        setLoading(false);
      }
    };

    fetchPlanEstudios();
  }, []);

  const openModal = (carrera) => {
    setSelectedCarrera(carrera);
    setIsModalVisible(true);
  };

  const closeModal = () => {
    setIsModalVisible(false);
    setTimeout(() => setSelectedCarrera(null), 600); // Delay to allow animation to complete
  };

  const renderPlan = () => {
    const carreras = {};

    plan.forEach(item => {
      const { NOMBRE_CARRERA, NOMBRE_CURSO, CREDITOS, CUPOS } = item;

      if (!carreras[NOMBRE_CARRERA]) {
        carreras[NOMBRE_CARRERA] = [];
      }
      carreras[NOMBRE_CARRERA].push({
        nombreCurso: NOMBRE_CURSO,
        creditos: CREDITOS,
        cupos: CUPOS
      });
    });

    return Object.keys(carreras).map(carrera => (
      <div key={carrera} className="mb-4">
        <button
          onClick={() => openModal(carrera)}
          className="block bg-gray-200 p-4 w-full text-left cursor-pointer rounded-lg"
        >
          <h2 className="text-xl font-bold">{carrera}</h2>
        </button>
      </div>
    ));
  };

  const renderModal = () => {
    if (!selectedCarrera) return null;

    const cursos = plan.filter(item => item.NOMBRE_CARRERA === selectedCarrera);

    return (
      <div className={`fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center transition-opacity duration-300 ease-in-out ${isModalVisible ? 'opacity-100' : 'opacity-0'}`}>
        <div className={`bg-white rounded-lg p-8 w-3/4 max-w-3xl transform transition-transform duration-300 ease-in-out ${isModalVisible ? 'scale-100' : 'scale-95'}`}>
          <h2 className="text-2xl font-bold mb-4">{selectedCarrera}</h2>
          <table className="min-w-full bg-white border border-gray-200">
            <thead>
              <tr>
                <th className="py-2 px-4 border-b">Materia</th>
                <th className="py-2 px-4 border-b">Créditos</th>
                <th className="py-2 px-4 border-b">Cupos</th>
              </tr>
            </thead>
            <tbody>
              {cursos.map((curso, index) => (
                <tr key={index} className="text-center">
                  <td className="py-2 px-4 border-b">{curso.NOMBRE_CURSO}</td>
                  <td className="py-2 px-4 border-b">{curso.CREDITOS}</td>
                  <td className="py-2 px-4 border-b">{curso.CUPOS}</td>
                </tr>
              ))}
            </tbody>
          </table>
          <button
            onClick={closeModal}
            className="mt-4 bg-red-600 text-white py-2 px-4 rounded"
          >
            Cerrar
          </button>
        </div>
      </div>
    );
  };

  return (
    <div className="flex">
      <SidebarNavigation className="w-1/4" />
      <div className="w-3/4 p-8">
        <h1 className="text-3xl font-bold mb-6">Plan de Estudios</h1>
        {loading && <p>Cargando...</p>}
        {error && <p className="text-red-500">{error}</p>}
        {!loading && !error && renderPlan()}
        {renderModal()}
      </div>
    </div>
  );
}