// BarraNavegacion.js
import React, { useContext, useEffect } from "react";
import { Link, useNavigate } from "react-router-dom";
import { AuthContext } from "../context/authContext";
import { BsPeopleFill, BsFillGridFill, BsTable } from "react-icons/bs";
import {
  FaUserCircle,
  FaIdBadge,
  FaSignOutAlt,
  FaUserShield,
} from "react-icons/fa";
import "./BarraNavegacion.css";

const BarraNavegacion = () => {
  const { user, loading, logout } = useContext(AuthContext);
  const navigate = useNavigate();

  useEffect(() => {
    if (!loading && !user) {
      navigate("/login");
    }
  }, [loading, user, navigate]);

  const handleLogout = () => {
    logout();
    navigate("/login");
  };

  return (
    <div className="navbar fixed-bottom navbar-style d-flex justify-content-around align-items-center">
      <div className="navbar-user-info">
        {user ? (
          <>
            <span>
              <FaUserCircle size={32} /> Usuario: {user.nombre}
            </span>
            <span style={{ marginLeft: "15px" }}>
              <FaIdBadge size={32} /> Rol: {user.rol}
            </span>
          </>
        ) : (
          <span>Esperando usuario...</span>
        )}
      </div>
      <Link className="btn nav-button" to="/clientes">
        <BsPeopleFill size={32} /> Clientes
      </Link>
      <Link className="btn nav-button" to="/productos">
        <BsFillGridFill size={32} /> Productos
      </Link>
      <Link className="btn nav-button" to="/mesas">
        <BsTable size={32} /> Mesas
      </Link>
      {user?.rol === "Administrador" && (
        <Link className="btn nav-button" to="/administracion">
          <FaUserShield size={32} /> Administración
        </Link>
      )}
      <Link className="btn nav-button" to="#" onClick={handleLogout}>
        <FaSignOutAlt size={32} /> Salir
      </Link>
    </div>
  );
};

export default BarraNavegacion;
