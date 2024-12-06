import React, { useEffect, useState } from 'react';

export default function RegistrarUsuario() {
    const [areas, setAreas] = useState([]);
    const [paises, setPaises] = useState([]);
    const [cantones, setCantones] = useState([]);
    const [provincias, setProvincias] = useState([]);
    const [distritos, setDistritos] = useState([]);
    const [contrasena, setContrasena] = useState('');

    useEffect(() => {
        const fetchData = async (url, setState) => {
            try {
                const response = await fetch(url);
                const data = await response.json();
                setState(data);
                //console.log(`Data fetched from ${url}:`, data);
            } catch (error) {
                console.error(`Error fetching data from ${url}:`, error);
            }
        };
        fetchData('http://localhost:5000/getAllAreaEspecializacion', setAreas);
        fetchData('http://localhost:5000/getAllPaises', setPaises);
        fetchData('http://localhost:5000/getAllCantones', setCantones);
        fetchData('http://localhost:5000/getAllProvincias', setProvincias);
        fetchData('http://localhost:5000/getAllDistritos', setDistritos);
    }, []);
    
    const handleSubmit = (e) => {
        e.preventDefault();
        console.log('Form submitted');
    };

	return (
        <div>
            <div className="max-w-md mx-auto mt-20 p-6 bg-white rounded-lg shadow-md">
                <h2 className="text-2xl font-bold mb-6 text-center">Registrar Usuario</h2>
                <form onSubmit={handleSubmit}>
                    <div className="mb-4">
                        <label className="block text-gray-700">Nombre</label>
                        <input type="text" className="w-full px-3 py-2 border border-gray-300 rounded-lg" required />
                    </div>
                    <div className="mb-4 flex space-x-4">
                        <div className="w-1/2">
                            <label className="block text-gray-700">Primer Apellido</label>
                            <input type="text" className="w-full px-3 py-2 border border-gray-300 rounded-lg" required />
                        </div>
                        <div className="w-1/2">
                            <label className="block text-gray-700">Segundo Apellido</label>
                            <input type="text" className="w-full px-3 py-2 border border-gray-300 rounded-lg" required />
                        </div>
                    </div>
                    <div className="mb-4">
                        <label className="block text-gray-700">Correo</label>
                        <input type="email" className="w-full px-3 py-2 border border-gray-300 rounded-lg" required />
                    </div>
                    <div className="mb-4 flex space-x-4">
                        <div className="w-1/2">
                            <label className="block text-gray-700">Tipo de Usuario</label>
                            <select className="w-full px-3 py-2 text-gray-600 border border-gray-300 rounded-lg" required>
                                <option value="Estudiante">Estudiante</option>
                                <option value="Docente">Docente</option>
                                <option value="Administrativo">Administrativo</option>
                                <option value="Decanato">Decanato</option>
                            </select>
                        </div>
                        <div className="w-1/2">
                            <label className="block text-gray-700">Área de Especialización</label>
                            <select className="w-full px-3 py-2 text-gray-600 border border-gray-300 rounded-lg" required>
                                {areas.map((areaEspecializacion, index) => (
                                    <option key={index} value={areaEspecializacion}>{areaEspecializacion}</option>
                                ))}
                            </select>
                        </div>
                    </div>
                    <div className="mb-4 flex space-x-4">
                        <div className="w-1/2">
                            <label className="block text-gray-700">País</label>
                            <select className="w-full px-3 py-2 text-gray-600 border border-gray-300 rounded-lg" required>
                                {paises.map((pais, index) => (
                                    <option key={index} value={pais[0]}>{pais[1]}</option>
                                ))}
                            </select>
                        </div>
                        <div className="w-1/2">
                            <label className="block text-gray-700">Provincia</label>
                            <select className="w-full px-3 py-2 text-gray-600 border border-gray-300 rounded-lg" required>
                                {provincias.map((provincia, index) => (
                                    <option key={index} value={provincia[0]}>{provincia[1]}</option>
                                ))}
                            </select>
                        </div>
                    </div>
                    <div className="mb-4 flex space-x-4">
                        <div className="w-1/2">
                            <label className="block text-gray-700">Cantón</label>
                            <select className="w-full px-3 py-2 text-gray-600 border border-gray-300 rounded-lg" required>
                                {cantones.map((canton, index) => (
                                    <option key={index} value={canton[0]}>{canton[1]}</option>
                                ))}
                            </select>
                        </div>
                        <div className="w-1/2">
                            <label className="block text-gray-700">Distrito</label>
                            <select className="w-full px-3 py-2 text-gray-600 border border-gray-300 rounded-lg" required>
                                {distritos.map((distrito, index) => (
                                    <option key={index} value={distrito[0]}>{distrito[1]}</option>
                                ))}
                            </select>
                        </div>
                    </div>
                    <div className="mb-4 flex space-x-4">
                        <div className="w-1/4">
                            <label className="block text-gray-700">Código País</label>
                            <input type="text" className="w-full px-3 py-2 border border-gray-300 rounded-lg" required />
                        </div>
                        <div className="w-3/4">
                            <label className="block text-gray-700">Teléfono</label>
                            <input type="text" className="w-full px-3 py-2 border border-gray-300 rounded-lg" required />
                        </div>
                    </div>
                    <div className="mb-4">
                        <label className="block text-gray-700">Contraseña</label>
                        <input className="w-full px-3 py-2 border border-gray-300 rounded-lg" required />
                    </div>
                    <div className="text-center">
                        <button type="submit" className="w-full px-4 py-2 bg-blue-600 hover:bg-blue-800 text-white rounded-lg transition ease-in-out duration-500">
                            Crear Usuario
                        </button>
                    </div>
                </form>
            </div>
        </div>
	);
}
