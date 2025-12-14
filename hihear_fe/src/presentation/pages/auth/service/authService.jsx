import apiClient from "../../../../Core/config/apiClient";

export const authService = {
  loginWithGoogle: async (idToken) => {
    console.log("chạy tới đây",idToken)
    const res = await apiClient.post("/auths/google", { idToken });
    console.log("chạy tới đây 02",res.data)
    return res.data;
  },

  loginWithFacebook: async () => {
    const response = await apiClient.get("/auth/facebook");
    return response.data;
  },
};
