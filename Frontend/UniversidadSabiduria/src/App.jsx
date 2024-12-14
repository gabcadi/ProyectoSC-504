import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import Login from './pages/Login.jsx'
import Home from './pages/Home.jsx'
import Perfil from './pages/Perfil.jsx';
import PlanEstudios from './pages/PlanEstudios.jsx';
import Matricula from './pages/Matricula.jsx';
import CambioHorario from './pages/CambioHorario.jsx';
import HistorialAcademico from './pages/HistorialAcademico.jsx';
import NotFound from './pages/NotFound.jsx';
import RegistrarUsuario from './pages/RegistrarUsuario.jsx';
import CambiarContrasena from './pages/CambiarContrasena.jsx';
import GestionCursos from './pages/GestionCursos.jsx';
import { UserProvider } from './hooks/UserContext';

function App() {

  return (
    <div className="app-container">
      <UserProvider>
        <Router>
          <Routes>
            <Route path="*" element={<NotFound />} />
            <Route path="/" element={<Login />} />
            <Route path="/Home" element={<Home />} />
            <Route path="/Perfil" element={<Perfil />} />
            <Route path="/PlanEstudios" element={<PlanEstudios />} />
            <Route path="/Matricula" element={<Matricula />} />
            <Route path="/CambioHorario" element={<CambioHorario />} />
            <Route path="/HistorialAcademico" element={<HistorialAcademico />} />
            <Route path="/RegistrarUsuario" element={<RegistrarUsuario />} />
            <Route path="/CambiarContrasena" element={<CambiarContrasena />} />
            <Route path="/GestionCursos" element={<GestionCursos />} />
          </Routes>
        </Router>
        </UserProvider>
    </div>
  )
}

export default App
