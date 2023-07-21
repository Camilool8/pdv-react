// BarraNavegacion.js
import React, { useContext } from "react";
import { Link } from "react-router-dom";
import { AuthContext } from "../context/authContext";
import { BsPeopleFill, BsFillGridFill, BsTable } from "react-icons/bs"; // import needed icons
import "./BarraNavegacion.css";

const BarraNavegacion = () => {
  const { user } = useContext(AuthContext);

  return (
    <div className="navbar fixed-bottom navbar-style d-flex justify-content-around align-items-center">
      <div className="navbar-user-info">
        <span>
          <i className="fas fa-user-circle"></i>&nbsp;<strong>Usuario:</strong>{" "}
          {user?.nombre}
        </span>
        <span style={{ marginLeft: "15px" }}>
          <i className="fas fa-id-badge"></i>&nbsp;<strong>Rol:</strong>{" "}
          {user?.rol}
        </span>
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
    </div>
  );
};

export default BarraNavegacion;
