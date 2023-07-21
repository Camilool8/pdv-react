import React, { useState, useEffect } from "react";
import axios from "axios";
import MesaForm from "./MesaForm";
import Ventas from "./Ventas";
import { Card, Button, Container, Row, Col } from "react-bootstrap";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faUtensils } from "@fortawesome/free-solid-svg-icons";
import "./Mesas.css";

function Mesa() {
  const [mesas, setMesas] = useState([]);
  const [selectedMesa, setSelectedMesa] = useState(null);

  const fetchMesas = async () => {
    const response = await axios.get("https://localhost:7100/Mesas");
    setMesas(response.data);
  };

  useEffect(() => {
    fetchMesas();
  }, []);

  const handleMesaClick = (mesa) => {
    setSelectedMesa(mesa);
  };

  const getCardColor = (estado) => {
    switch (estado) {
      case "Libre":
        return "success";
      case "Reservada":
        return "warning";
      case "Ocupada":
        return "secondary";
      default:
        return "";
    }
  };

  return (
    <Container>
      <Row>
        {mesas.map((mesa) => (
          <Col md={4} key={mesa.id}>
            <Card
              bg={getCardColor(mesa.estado)}
              text="white"
              style={{ margin: "1rem" }}
            >
              <Card.Body>
                <Card.Title>
                  <FontAwesomeIcon icon={faUtensils} /> Mesa No: {mesa.id}
                </Card.Title>
                <Card.Text>Estado: {mesa.estado}</Card.Text>
                <Button variant="light" onClick={() => handleMesaClick(mesa)}>
                  Ver Detalles
                </Button>
              </Card.Body>
            </Card>
          </Col>
        ))}
      </Row>

      {selectedMesa && <MesaForm mesa={selectedMesa} onUpdated={fetchMesas} />}
      {selectedMesa && <Ventas mesa={selectedMesa} />}
    </Container>
  );
}

export default Mesa;
