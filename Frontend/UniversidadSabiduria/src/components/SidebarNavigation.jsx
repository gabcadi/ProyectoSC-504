import React, { useState, useContext } from 'react';
import { UserContext } from '../hooks/UserContext';
import { Link } from 'react-router-dom';

export default function SidebarNavigation() {
	const [sidenav, setSidenav] = useState(true);
	const { user } = useContext(UserContext);

	return (
		<div className="font-poppins antialiased flex flex-row">
			<button
				onClick={() => setSidenav(true)}
				className="p-2 border-2 bg-white rounded-md border-gray-200 shadow-lg text-gray-500 focus:bg-teal-500 focus:outline-none focus:text-white absolute top-0 left-0 sm:hidden"
			>
				<svg className="w-5 h-5 fill-current" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
					<path
						fillRule="evenodd"
						d="M3 5a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 10a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 15a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z"
						clipRule="evenodd"
					></path>
				</svg>
			</button>
			<div
				id="sidebar"
				className={`bg-white h-screen md:block shadow-xl px-3 w-30 md:w-60 lg:w-60 overflow-x-hidden transition-transform duration-300 ease-in-out ${
					sidenav ? 'block' : 'hidden'
				}`}
				onClick={() => setSidenav(false)}
			>
				<div className="space-y-6 md:space-y-10 mt-10">
					<h1 className="hidden md:block font-bold text-sm md:text-xl text-center">
						Bienvenido<span className="text-teal-600">.</span>
					</h1>
					<div id="profile" className="space-y-3">
						<img
							src="https://images.unsplash.com/photo-1628157588553-5eeea00af15c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80"
							alt="Avatar user"
							className="w-36 rounded-full mx-auto"
						/>
						<div>
							<h2 className="text-xl text-center text-teal-800">{user.NOMBRE}</h2>
							<p className="text-gray-500 text-center">{user.TIPO_USUARIO}</p>
						</div>
					</div>
					<div id="menu" className="flex flex-col space-y-2">
						{user.TIPO_USUARIO === 'Estudiante' ? (
							<>
								<Link
									to="/Perfil"
									className="text-sm font-medium text-gray-700 py-2 px-2 hover:bg-teal-500 hover:text-white hover:scale-105 rounded-md transition duration-150 ease-in-out"
								>
									<span>Mi perfil</span>
								</Link>
								<Link
									to="/PlanEstudios"
									className="text-sm font-medium text-gray-700 py-2 px-2 hover:bg-teal-500 hover:text-white hover:scale-105 rounded-md transition duration-150 ease-in-out"
								>
									<span>Plan de estudios</span>
								</Link>
								<Link
									to="/Matricula"
									className="text-sm font-medium text-gray-700 py-2 px-2 hover:bg-teal-500 hover:text-white hover:scale-105 rounded-md transition duration-150 ease-in-out"
								>
									<span>Matrícula en línea</span>
								</Link>
								<Link
									to="/CambioHorario"
									className="text-sm font-medium text-gray-700 py-2 px-2 hover:bg-teal-500 hover:text-white hover:scale-105 rounded-md transition duration-150 ease-in-out"
								>
									<span>Cambio Horario</span>
								</Link>
								<Link
									to="/HistorialAcademico"
									className="text-sm font-medium text-gray-700 py-2 px-2 hover:bg-teal-500 hover:text-white hover:scale-105 rounded-md transition duration-150 ease-in-out"
								>
									<span>Historial Académico</span>
								</Link>
							</>
						) : user.TIPO_USUARIO === 'Docente' ? (
							<>
								<Link
									to="/Perfil"
									className="text-sm font-medium text-gray-700 py-2 px-2 hover:bg-teal-500 hover:text-white hover:scale-105 rounded-md transition duration-150 ease-in-out"
								>
									<span>Mi perfil</span>
								</Link>
								<Link
									to="/GestionCursos"
									className="text-sm font-medium text-gray-700 py-2 px-2 hover:bg-teal-500 hover:text-white hover:scale-105 rounded-md transition duration-150 ease-in-out"
								>
									<span>Gestión de Cursos</span>
								</Link>
							</>
						) : null}
					</div>
				</div>
			</div>
		</div>
	);
}
