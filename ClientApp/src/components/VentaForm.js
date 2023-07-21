import React, { useState, useEffect } from "react";
import axios from "axios";
import ProductoForm from "./ProductoForm";

function VentaForm({ venta, onUpdated }) {
  const [productos, setProductos] = useState([]);

  const fetchProductos = async () => {
    const response = await axios.get(
      `https://localhost:7100/Ventas/${venta.Id}/Productos`
    );
    setProductos(response.data);
  };

  useEffect(() => {
    fetchProductos();
  }, [venta]);

  const handleFacturar = async () => {
    const total = productos.reduce((total, vp) => total + vp.Cantidad, 0);
    await axios.post("https://localhost:7100/Ventas/Facturas", {
      VentasIds: [venta.Id],
      Total: total,
    });
    onUpdated();
  };

  return (
    <div>
      <h2>Venta {venta.Id}</h2>
      {productos.map((vp) => (
        <p key={vp.ProductoId}>{vp.Cantidad}</p>
      ))}
      <ProductoForm venta={venta} onUpdated={fetchProductos} />
      <button onClick={handleFacturar}>Facturar</button>
    </div>
  );
}

export default VentaForm;
