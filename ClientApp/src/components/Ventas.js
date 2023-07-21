import React, { useState, useEffect } from "react";
import axios from "axios";
import VentaForm from "./VentaForm";

function Ventas({ mesa }) {
  const [ventas, setVentas] = useState([]);
  const [selectedVenta, setSelectedVenta] = useState(null);

  const fetchVentas = async () => {
    const response = await axios.get(
      `https://localhost:7100/Mesas/${mesa.Id}/Ventas`
    );
    setVentas(response.data);
  };

  useEffect(() => {
    fetchVentas();
  }, [mesa]);

  const handleVentaClick = (venta) => {
    setSelectedVenta(venta);
  };

  return (
    <div>
      {ventas.map((venta) => (
        <div onClick={() => handleVentaClick(venta)} key={venta.Id}>
          <h3>Venta {venta.Id}</h3>
          <p>Total: {venta.Total}</p>
        </div>
      ))}

      {selectedVenta && (
        <VentaForm venta={selectedVenta} onUpdated={fetchVentas} />
      )}
    </div>
  );
}

export default Ventas;
