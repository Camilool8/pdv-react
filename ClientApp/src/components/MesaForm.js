import React from "react";
import axios from "axios";

function MesaForm({ mesa, onUpdated }) {
  const handleReservation = async () => {
    await axios.put(`https://localhost:7100/Mesas/${mesa.Id}`, {
      ...mesa,
      Estado: "Reservado",
    });
    onUpdated();
  };

  const handleFree = async () => {
    await axios.put(`https://localhost:7100/Mesas/${mesa.Id}`, {
      ...mesa,
      Estado: "Libre",
    });
    onUpdated();
  };

  return (
    <div>
      <h2>Mesa {mesa.Id}</h2>
      {mesa.Estado === "Libre" ? (
        <button onClick={handleReservation}>Reservar</button>
      ) : (
        <button onClick={handleFree}>Liberar</button>
      )}
    </div>
  );
}

export default MesaForm;
