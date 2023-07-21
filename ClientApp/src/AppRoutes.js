// AppRoutes.js
import React from "react";
import { Routes, Route } from "react-router-dom";
import Login from "./components/Login";
import Clientes from "./components/Clientes";
import Productos from "./components/Productos";
import Mesas from "./components/Mesas";
import BarraNavegacion from "./components/BarraNavegacion";
import "./App.css";

const AppRoutes = () => (
  <React.Fragment>
    <Routes>
      <Route path="/login" element={<Login />} />
      <Route path="/clientes" element={<Clientes />} />
      <Route path="/productos" element={<Productos />} />
      <Route path="/mesas" element={<Mesas />} />
    </Routes>
    <BarraNavegacion />
  </React.Fragment>
);

export default AppRoutes;
