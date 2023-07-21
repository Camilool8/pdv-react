// src/components/Login.js
import React, { useState, useContext } from "react";
import { Alert, Button, Form } from "react-bootstrap";
import { useNavigate } from "react-router-dom";
import { AuthContext } from "../context/authContext";
import "./Login.css";

function Login() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState(null);
  const navigate = useNavigate();

  const { login } = useContext(AuthContext);

  const handleSubmit = async (event) => {
    event.preventDefault();

    try {
      await login({ Email: email, Contraseña: password });
      navigate("/");
    } catch (error) {
      setError("Inicio de sesión fallido");
      console.error("Inicio de sesión fallido", error);
    }
  };

  return (
    <div className="login-wrapper">
      <div className="login-container">
        <h2 className="login-title">Restaurante POS</h2>
        {error && <Alert variant="danger">{error}</Alert>}
        <Form onSubmit={handleSubmit}>
          <Form.Group controlId="formEmail">
            <Form.Label>Email</Form.Label>
            <Form.Control
              type="email"
              placeholder="Ingrese su email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
            />
          </Form.Group>

          <Form.Group controlId="formPassword">
            <Form.Label>Contraseña</Form.Label>
            <Form.Control
              type="password"
              placeholder="Ingrese su contraseña"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
            />
          </Form.Group>

          <Button variant="primary" type="submit">
            Iniciar sesión
          </Button>
        </Form>
      </div>
    </div>
  );
}

export default Login;
