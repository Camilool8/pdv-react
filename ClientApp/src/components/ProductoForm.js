import React, { useState } from "react";
import axios from "axios";

function ProductoForm({ venta, onUpdated }) {
  const [productoId, setProductoId] = useState(null);
  const [cantidad, setCantidad] = useState(1);

  const handleSubmit = async (event) => {
    event.preventDefault();
    const ventaProducto = { ProductoId: productoId, Cantidad: cantidad };
    await axios.post(
      `https://localhost:7100/Ventas/${venta.Id}/Productos`,
      ventaProducto
    );
    onUpdated();
  };

  return (
    <form onSubmit={handleSubmit}>
      <input
        type="number"
        placeholder="Producto ID"
        value={productoId}
        onChange={(e) => setProductoId(e.target.value)}
        required
      />
      <input
        type="number"
        placeholder="Cantidad"
        value={cantidad}
        onChange={(e) => setCantidad(e.target.value)}
        required
      />
      <button type="submit">Agregar producto</button>
    </form>
  );
}

export default ProductoForm;
