import React, { useEffect, useState } from 'react';
import axios from 'axios';

export default function RegistrarUsuario() {
	const [formData, setFormData] = useState({
		nombre: '',
		primerApellido: '',
		segundoApellido: '',
		correo: '',
		tipoUsuario: '',
		idEspecializacion: '',
		codigoPais: '',
		telefono: '',
		idPais: '',
		idProvincia: '',
		idCanton: '',
		idDistrito: '',
		calle: '',
		numeroCasa: '',
		otrasSenas: '',
		contrasena: '',
	});

	const [areas, setAreas] = useState([]);
	const [paises, setPaises] = useState([]);
	const [cantones, setCantones] = useState([]);
	const [provincias, setProvincias] = useState([]);
	const [distritos, setDistritos] = useState([]);
	const [showModal, setShowModal] = useState(false);
	const [mensaje, setMensaje] = useState('');

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

	const handleSubmit = async (event) => {
		event.preventDefault();
		try {
			console.log(formData);
			
			const response = await axios.post('http://localhost:5000/agregarUsuario', formData);
			setMensaje('Usuario agregado exitosamente!');
			setShowModal(true);
		} catch (error) {
			setMensaje('Error al agregar usuario');
			setShowModal(true);
		}
	};

	const handleChange = (e) => {
		const { name, value } = e.target;
		setFormData({
			...formData,
			[name]: value,
		});
	};

	return (
		<div>
			<div className="max-w-md mx-auto mt-20 p-6 bg-white rounded-lg shadow-md">
				<h2 className="text-2xl font-bold mb-6 text-center">Registrar Usuario</h2>
				<form onSubmit={handleSubmit}>
					<div className="mb-4">
						<label className="block text-gray-700">Nombre</label>
						<input
							type="text"
							name="nombre"
							value={formData.nombre}
							onChange={handleChange}
							className="w-full px-3 py-2 border rounded"
							required
						/>
					</div>
					<div className="mb-4 flex space-x-4">
						<div className="w-1/2">
							<label className="block text-gray-700">Primer Apellido</label>
							<input
								type="text"
								name="primerApellido"
								value={formData.primerApellido}
								onChange={handleChange}
								className="w-full px-3 py-2 border rounded"
								required
							/>
						</div>
						<div className="w-1/2">
							<label className="block text-gray-700">Segundo Apellido</label>
							<input
								type="text"
								name="segundoApellido"
								value={formData.segundoApellido}
								onChange={handleChange}
								className="w-full px-3 py-2 border rounded"
								required
							/>
						</div>
					</div>
					<div className="mb-4">
						<label className="block text-gray-700">Correo</label>
						<input
							type="email"
							name="correo"
							value={formData.correo}
							onChange={handleChange}
							className="w-full px-3 py-2 border rounded"
							required
						/>
					</div>
					<div className="mb-4 flex space-x-4">
						<div className="w-1/2">
							<label className="block text-gray-700">Tipo de Usuario</label>
							<select
								name="tipoUsuario"
								value={formData.tipoUsuario}
								onChange={handleChange}
								className="w-full px-3 py-2 text-gray-600 border border-gray-300 rounded-lg"
								required
							>
								<option value="Estudiante">Estudiante</option>
								<option value="Docente">Docente</option>
								<option value="Administrativo">Administrativo</option>
								<option value="Decanato">Decanato</option>
							</select>
						</div>
						<div className="w-1/2">
                        <label className="block text-gray-700">Área de Especialización</label>
							<select
								name="idEspecializacion"
								value={formData.idEspecializacion}
								onChange={handleChange}
								className="w-full px-3 py-2 border rounded"
								required
							>
								<option value="">Seleccione un área de especialización</option>
								{areas.map((area) => (
									<option key={area[0]} value={area[0]}>
										{area[1]}
									</option>
								))}
							</select>
						</div>
					</div>
					<div className="mb-4 flex space-x-4">
						<div className="w-1/2">
							<label className="block text-gray-700">País</label>
							<select
								name="idPais"
								value={formData.idPais}
								onChange={handleChange}
								className="w-full px-3 py-2 border rounded"
								required
							>
								<option value="">Seleccione un país</option>
								{paises.map((pais) => (
									<option key={pais[0]} value={pais[0]}>
										{pais[1]}
									</option>
								))}
							</select>
						</div>
						<div className="w-1/2">
							<label className="block text-gray-700">Provincia</label>
							<select
								name="idProvincia"
								value={formData.idProvincia}
								onChange={handleChange}
								className="w-full px-3 py-2 border rounded"
								required
							>
								<option value="">Seleccione una provincia</option>
								{provincias.map((provincia) => (
									<option key={provincia[0]} value={provincia[0]}>
										{provincia[1]}
									</option>
								))}
							</select>
						</div>
					</div>
					<div className="mb-4 flex space-x-4">
						<div className="w-1/2">
							<label className="block text-gray-700">Cantón</label>
							<select
								name="idCanton"
								value={formData.idCanton}
								onChange={handleChange}
								className="w-full px-3 py-2 border rounded"
								required
							>
								<option value="">Seleccione un cantón</option>
								{cantones.map((canton) => (
									<option key={canton[0]} value={canton[0]}>
										{canton[1]}
									</option>
								))}
							</select>
						</div>
						<div className="w-1/2">
							<label className="block text-gray-700">Distrito</label>
							<select
								name="idDistrito"
								value={formData.idDistrito}
								onChange={handleChange}
								className="w-full px-3 py-2 border rounded"
								required
							>
								{distritos.map((distrito, index) => (
									<option key={index} value={distrito[0]}>
										{distrito[1]}
									</option>
								))}
							</select>
						</div>
					</div>
					<div className="mb-4 flex space-x-4">
						<div className="w-1/4">
							<label className="block text-gray-700">Código País</label>
							<input
								type="text"
								name="codigoPais"
								value={formData.codigoPais}
								onChange={handleChange}
								className="w-full px-3 py-2 border rounded"
								required
							/>
						</div>
						<div className="w-3/4">
							<label className="block text-gray-700">Teléfono</label>
							<input
								type="text"
								name="telefono"
								value={formData.telefono}
								onChange={handleChange}
								className="w-full px-3 py-2 border rounded"
								required
							/>
						</div>
					</div>
					<div className="mb-4">
						<label className="block text-gray-700">Contraseña</label>
						<input
							type="text"
							name="contrasena"
							value={formData.contrasena}
							onChange={handleChange}
							className="w-full px-3 py-2 border rounded"
							required
						/>
					</div>
					<div className="text-center">
						<button
							type="submit"
							className="w-max px-4 py-2 bg-blue-600 hover:bg-blue-800 text-white rounded-lg transition ease-in-out duration-500"
						>
							Crear Usuario
						</button>
					</div>
				</form>
				{showModal && (
					<div className="fixed z-10 inset-0 overflow-y-auto">
						<div className="flex items-end justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
							<div className="fixed inset-0 transition-opacity" aria-hidden="true">
								<div className="absolute inset-0 bg-gray-500 opacity-75"></div>
							</div>
							<span className="hidden sm:inline-block sm:align-middle sm:h-screen" aria-hidden="true">
								&#8203;
							</span>
							<div className="inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full">
								<div className="bg-white px-4 pt-5 pb-4 sm:p-6 sm:pb-4">
									<div className="sm:flex sm:items-start">
										<div className="mt-3 text-center sm:mt-0 sm:ml-4 sm:text-left">
											<h3 className="text-lg leading-6 font-medium text-gray-900" id="modal-title">
												{mensaje}
											</h3>
										</div>
									</div>
								</div>
								<div className="bg-gray-50 px-4 py-3 sm:px-6 sm:flex sm:flex-row-reverse">
									<button
										type="button"
										className="w-full inline-flex justify-center rounded-md border border-transparent shadow-sm px-4 py-2 bg-blue-600 text-base font-medium text-white hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 sm:ml-3 sm:w-auto sm:text-sm"
										onClick={() => setShowModal(false)}
									>
										Cerrar
									</button>
								</div>
							</div>
						</div>
					</div>
				)}
			</div>
		</div>
	);
}
