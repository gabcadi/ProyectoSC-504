import React, { useState } from "react";
import axios from "axios";
import { Link } from "react-router-dom";

export default function CambiarContrasena() {
  const [correo, setCorreo] = useState("");
  const [contrasenaActual, setContrasenaActual] = useState("");
  const [nuevaContrasena, setNuevaContrasena] = useState("");
  const [mensaje, setMensaje] = useState("");
  const [showModal, setShowModal] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const response = await axios.post('http://localhost:5000/cambiarContrasena', {
        correo,
        contrasenaActual,
        nuevaContrasena
      });
      setMensaje(response.data);
      setShowModal(true);
    } catch (err) {
      setMensaje(err.response.data);
      setShowModal(true);
    }
  };

  const handleCloseModal = () => {
    setShowModal(false);
  };

  return (
    <div className="max-w-md mx-auto mt-20 p-6 bg-white rounded-lg shadow-md">
      <h2 className="text-2xl font-bold mb-6 text-center">Cambiar Contraseña</h2>
      <form onSubmit={handleSubmit}>
        <div className="mb-4">
          <label className="block text-gray-700">Correo:</label>
          <input
            type="email"
            value={correo}
            onChange={(e) => setCorreo(e.target.value)}
            className="w-full px-3 py-2 border rounded"
            required
          />
        </div>
        <div className="mb-4">
          <label className="block text-gray-700">Contraseña Actual:</label>
          <input
            type="password"
            value={contrasenaActual}
            onChange={(e) => setContrasenaActual(e.target.value)}
            className="w-full px-3 py-2 border rounded"
            required
          />
        </div>
        <div className="mb-4">
          <label className="block text-gray-700">Nueva Contraseña:</label>
          <input
            type="password"
            value={nuevaContrasena}
            onChange={(e) => setNuevaContrasena(e.target.value)}
            className="w-full px-3 py-2 border rounded"
            required
          />
        </div>
        <div className="text-center">
          <button
            type="submit"
            className="w-max px-4 py-2 bg-blue-600 hover:bg-blue-800 text-white rounded-lg transition ease-in-out duration-500"
          >
            Cambiar Contraseña
          </button>
        </div>
      </form>
      {showModal && (
        <div className="fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center">
          <div className="bg-white rounded-lg p-8 w-3/4 max-w-md">
            <h2 className="text-xl font-bold mb-4">Mensaje</h2>
            <p className="mb-4">{mensaje}</p>
              <button
                onClick={handleCloseModal}
                className="mt-4 bg-red-700 text-white py-2 px-4 rounded"
              >
                Cerrar
              </button>
            <Link to="/"
            className="ms-4 font-medium text-gray-700 py-2 px-2 hover:bg-blue-500 hover:text-white hover:scale-105 rounded-md transition duration-350 ease-in-out">
                <span>Ir a Login</span>
            </Link>
          </div>
        </div>
      )}
    </div>
  );
}