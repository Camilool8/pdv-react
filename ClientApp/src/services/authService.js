// /src/services/authService.js
import axios from "axios";

// URL de tu API
const API_URL = "https://localhost:7100/Accounts/";

async function registerUser(user) {
  try {
    const response = await axios.post(API_URL + "register", user);
    if (response.status === 200) {
      return response.data;
    } else {
      throw new Error("Registration failed");
    }
  } catch (error) {
    throw error;
  }
}

async function loginUser(user) {
  try {
    const response = await axios.post(API_URL + "login", user);
    if (response.data) {
      // Almacenar el token en el local storage
      localStorage.setItem("userToken", response.data);
    }
    return response.data;
  } catch (error) {
    throw error;
  }
}

function logoutUser() {
  // Eliminar el token del local storage al cerrar sesión
  localStorage.removeItem("userToken");
}

function getToken() {
  // Obtener el token del local storage
  return localStorage.getItem("userToken");
}

export { registerUser, loginUser, logoutUser, getToken };
