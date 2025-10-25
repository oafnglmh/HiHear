import apiClient from "../../../../Core/config/apiClient";

export const authService = {
  loginWithGoogle: async () => {
    const response = await apiClient.get("/auth/google");
    return response.data;
  },

  loginWithFacebook: async () => {
    const response = await apiClient.get("/auth/facebook");
    return response.data;
  },
};
