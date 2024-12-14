import React, { useEffect, useState, useContext } from "react";
import SidebarNavigation from "../components/SidebarNavigation.jsx";
import axios from "axios";
import { UserContext } from "../hooks/UserContext";

export default function HistorialAcademico() {
  const [historial, setHistorial] = useState([]);
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(true);
  const { user } = useContext(UserContext);

  useEffect(() => {
    const fetchHistorialAcademico = async () => {
      try {
        const response = await axios.get(`http://localhost:5000/getHistorialAcademico/${user.ID_USUARIO}`);
        setHistorial(response.data);
      } catch (err) {
        console.error('Error:', err);
        setError('Error al obtener el historial académico');
      } finally {
        setLoading(false);
      }
    };

    fetchHistorialAcademico();
  }, [user.ID_USUARIO]);

  return (
    <div className="flex">
      <SidebarNavigation className="w-1/4" />
      <div className="w-3/4 p-8">
        <h1 className="text-3xl font-bold mb-6">Historial Académico</h1>
        {loading && <p>Cargando...</p>}
        {error && <p className="text-red-500">{error}</p>}
        {!loading && !error && (
          <>
            {historial.length === 0 ? (
              <p>No hay historial académico disponible.</p>
            ) : (
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                {historial.map((curso) => (
                  <div key={curso.ID_HISTORIAL} className="bg-white p-4 rounded-lg shadow-md">
                    <h2 className="text-xl font-bold mb-2">{curso.NOMBRE_CURSO}</h2>
                    <p><strong>Periodo:</strong> {curso.PERIODO}</p>
                    <p><strong>Año:</strong> {curso.ANNO}</p>
                    <p><strong>Observaciones:</strong> {curso.OBSERVACIONES}</p>
                    <p><strong>Calificación:</strong> {curso.CALIFICACION}</p>
                  </div>
                ))}
              </div>
            )}
          </>
        )}
      </div>
    </div>
  );
}