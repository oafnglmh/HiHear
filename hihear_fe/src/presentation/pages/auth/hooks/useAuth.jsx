import { useState } from "react";
import { authService } from "../service/authService";
import toast from "react-hot-toast";
import { useNavigate } from "react-router-dom";

export const useAuth = () => {
  const navigate = useNavigate();
  const [loading, setLoading] = useState(false);

  const saveToken = (token) => {
    localStorage.setItem("token", token);
  };

  const getToken = () => {
    return localStorage.getItem("token");
  };

  const loginWithGoogle = async (idToken) => {
    try {
      setLoading(true);
      const res = await authService.loginWithGoogle(idToken);
      saveToken(res.token.accessToken);
      localStorage.setItem("role", res.user.role);

      toast.success("Đăng nhập Google thành công!");
      console.log("adbc",res.user.role)
      if (res.user.role === "USER") {
        navigate("/admin/dashboard");
      } else {
        navigate("/404");
      }
    } catch (err) {
      toast.error("Đăng nhập Google thất bại");
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  const loginWithFacebook = async () => {
    try {
      setLoading(true);
      const res = await authService.loginWithFacebook();
      saveToken(res.token.accessToken);
      toast.success("Đăng nhập Facebook thành công!");
      navigate("/admin/dashboard");
    } catch (err) {
      toast.error("Đăng nhập Facebook thất bại!");
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  const logout = () => {
    localStorage.removeItem("token");
    navigate("/login");
  };

  return {
    loginWithGoogle,
    loginWithFacebook,
    getToken,
    logout,
    loading,
  };
};
