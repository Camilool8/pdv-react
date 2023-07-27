import React, { useContext, useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { AuthContext } from "../context/authContext";
import axios from "axios";
import { useForm } from "react-hook-form";
import { useQuery, useMutation, useQueryClient } from "react-query";
import {
  BsFillTrashFill,
  BsPencilSquare,
  BsPlus,
  BsX,
  BsArrowCounterclockwise,
} from "react-icons/bs";
import "bootstrap/dist/css/bootstrap.min.css";
import "./Clientes.css";
import { BaseUrl } from "../services/apiUrl";

function Clientes() {
  const [selectedClient, setSelectedClient] = useState(null);
  const { user, loading, getToken } = useContext(AuthContext);
  const [searchTerm, setSearchTerm] = useState("");
  const { register, handleSubmit, reset, setValue } = useForm();
  const queryClient = useQueryClient();

  const navigate = useNavigate();

  useEffect(() => {
    if (!loading && !user) {
      navigate("/login");
    }
  }, [loading, user, navigate]);

  const fetchClients = async () => {
    const token = getToken();
    const { data } = await axios.get(`${BaseUrl}/Clientes`, {
      headers: { Authorization: `Bearer ${token}` },
    });
    return data;
  };

  const createClient = async (newClient) => {
    const token = getToken();
    const { data } = await axios.post(
      `${BaseUrl}/Clientes`,
      newClient,
      {
        headers: { Authorization: `Bearer ${token}` },
      }
    );
    return data;
  };

  const updateClient = async ({ id, ...updatedClient }) => {
    const token = getToken();
    const { data } = await axios.put(
      `${BaseUrl}/Clientes/${id}`,
      updatedClient,
      {
        headers: { Authorization: `Bearer ${token}` },
      }
    );
    return data;
  };

  const deleteClient = async (id) => {
    const token = getToken();
    await axios.delete(`${BaseUrl}/Clientes/${id}`, {
      headers: { Authorization: `Bearer ${token}` },
    });
    return id;
  };

  const { data: clients, isLoading } = useQuery("clients", fetchClients);

  const mutationCreate = useMutation(createClient, {
    onSuccess: () => {
      queryClient.invalidateQueries("clients");
    },
  });

  const mutationUpdate = useMutation(updateClient, {
    onSuccess: () => {
      setSelectedClient(null);
      queryClient.invalidateQueries("clients");
    },
  });

  const mutationDelete = useMutation(deleteClient, {
    onSuccess: (deletedId) => {
      if (selectedClient?.id === deletedId) setSelectedClient(null);
      queryClient.invalidateQueries("clients");
    },
  });

  const onSubmit = (data) => {
    if (selectedClient) {
      mutationUpdate.mutate({ ...data, id: selectedClient.id });
    } else {
      mutationCreate.mutate(data);
    }
    reset();
  };

  const deselectClient = () => {
    setSelectedClient(null);
  };

  const clearForm = () => {
    reset();
  };

  useEffect(() => {
    if (selectedClient) {
      setValue("nombre", selectedClient.nombre);
      setValue("direccion", selectedClient.direccion);
      setValue("telefono", selectedClient.telefono);
    } else {
      reset();
    }
  }, [selectedClient, setValue, reset]);

  const handleSearch = (event) => {
    setSearchTerm(event.target.value);
  };

  const filteredClients = clients?.filter(
    (client) =>
      client.nombre.toLowerCase().includes(searchTerm.toLowerCase()) ||
      client.direccion.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <div className="client-container row g-3">
      {user && user.rol === "Administrador" && (
        <div className="client-form-container p-4 bg-light rounded-3 shadow">
          <h2 className="mb-4">Añadir / Editar Cliente</h2>
          <form onSubmit={handleSubmit(onSubmit)}>
            <div className="mb-3">
              <label className="form-label">Nombre</label>
              <input
                {...register("nombre")}
                placeholder="Nombre"
                className="form-control form-input"
              />
            </div>
            <div className="mb-3">
              <label className="form-label">Dirección</label>
              <input
                {...register("direccion")}
                placeholder="Dirección"
                className="form-control form-input"
              />
            </div>
            <div className="mb-3">
              <label className="form-label">Teléfono</label>
              <input
                {...register("telefono")}
                placeholder="Teléfono"
                className="form-control form-input"
              />
            </div>
            <div className="d-flex justify-content-between">
              <div className="btn-group">
                <button type="submit" className="btn btn-outline-primary">
                  {selectedClient ? (
                    <>
                      <BsPencilSquare />
                      Editar
                    </>
                  ) : (
                    <>
                      <BsPlus />
                      Crear
                    </>
                  )}
                </button>
                <button
                  type="button"
                  onClick={clearForm}
                  className="btn btn-outline-danger"
                >
                  <BsArrowCounterclockwise />
                  Limpiar
                </button>
                {selectedClient && (
                  <button
                    type="button"
                    onClick={deselectClient}
                    className="btn btn-outline-secondary"
                  >
                    <BsX />
                    Deseleccionar
                  </button>
                )}
              </div>
            </div>
          </form>
        </div>
      )}

      <div
        className={
          user && user.rol === "Administrador"
            ? "client-list-container p-4 bg-light rounded-3 shadow"
            : "client-list-container-full p-4 bg-light rounded-3 shadow"
        }
      >
        <h2 className="mb-4">Lista de Clientes</h2>
        <input
          type="text"
          className="form-control form-input mb-4"
          placeholder="Buscar..."
          onChange={handleSearch} // Add onChange to capture user input
        />
        <div className="table-container">
          <table className="table table-striped">
            <thead>
              <tr>
                <th>Nombre</th>
                <th>Dirección</th>
                <th>Teléfono</th>
                {user && user.rol === "Administrador" && <th>Acciones</th>}
              </tr>
            </thead>
            <tbody>
              {isLoading ? (
                <tr>
                  <td colSpan="4">Cargando clientes...</td>
                </tr>
              ) : (
                filteredClients.map((client) => (
                  <tr
                    key={client.id}
                    className={`${
                      selectedClient?.id === client.id ? "table-success" : ""
                    }`}
                    onClick={() => setSelectedClient(client)}
                  >
                    <td>{client.nombre}</td>
                    <td>{client.direccion}</td>
                    <td>{client.telefono}</td>
                    {user && user.rol === "Administrador" && (
                      <td>
                        <BsPencilSquare
                          onClick={() => setSelectedClient(client)}
                          className="me-2 text-warning cursor-pointer"
                        />
                        <BsFillTrashFill
                          onClick={(e) => {
                            e.stopPropagation();
                            mutationDelete.mutate(client.id);
                          }}
                          className="text-danger cursor-pointer"
                        />
                      </td>
                    )}
                  </tr>
                ))
              )}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}

export default Clientes;
